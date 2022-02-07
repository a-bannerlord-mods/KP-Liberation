// base amount of sector lifetime tickets
// if there are no enemies one ticket is removed every SECTOR_TICK_TIME seconds
// 12 * 5 = 60s by default
#define BASE_TICKETS                12
#define SECTOR_TICK_TIME            5
// delay in minutes from which addional time will be added
#define ADDITIONAL_TICKETS_DELAY    5
params["_sector"];

waitUntil {
    !isNil "combat_readiness"
};

[format["Sector %1 (%2) activated - Managed on: %3", (markerText _sector), _sector, debug_source], "SECTORSPAWN"] remoteExecCall["KPLIB_fnc_log", 2];

private _sectorpos = markerPos _sector;
private _stopit = false;
private _spawncivs = false;
private _building_ai_max = 0;
private _infsquad = "army";
private _building_range = 50;
private _local_capture_size = GRLIB_capture_size;
private _iedcount = 0;
private _vehtospawn = [];
private _managed_units = [];
private _squad1 = [];
private _squad2 = [];
private _squad3 = [];
private _squad4 = [];
private _sniper_positions= [];
private _static_mg = 0;
private _static_at = 0;
private _static_mg_heavy = 0;
private _static_aa_heavy = 0;
private _minimum_building_positions = 5;
private _sector_despawn_tickets = BASE_TICKETS;
private _maximum_additional_tickets = (KP_liberation_delayDespawnMax * 60 / SECTOR_TICK_TIME);
private _popfactor = 1;
private _guerilla = false;
private _buildingpositions = [];
// vechile , squads , units in building
private  _sector_cache = [_sector,"", [], [], [], [], [], [], [], [],[]];

_cached_index =  KP_liberation_Sector_Cache findif { (_x select 0) == _sector };
if (_cached_index > -1) then {
    _sector_cache = KP_liberation_Sector_Cache select _cached_index;
};
private _cached_vehicles =_sector_cache select 2;
private _cached_squads = _sector_cache select 3;
private _cached_units_in_building = _sector_cache select 4;
private _cached_units_on_building = _sector_cache select 5;
private _cached_static_mg = _sector_cache select 6;
private _cached_static_at = _sector_cache select 7;
private _cached_static_mg_heavy = _sector_cache select 8;
private _cached_static_aa_heavy = _sector_cache select 9;
private _cached_objectives = _sector_cache select 10;

if (GRLIB_unitcap < 1) then {
    _popfactor = GRLIB_unitcap;
};

if (_sector in active_sectors) exitWith {};
active_sectors pushback _sector;
publicVariable "active_sectors";

private _opforcount = [] call KPLIB_fnc_getOpforCap;
[_sector, _opforcount] call wait_to_spawn_sector;
_range = [_opforcount] call KPLIB_fnc_getSectorRange;
if ([_sector, _range] call KPLIB_fnc_sectorCanBeActivated) then {


    if (_sector in sectors_bigtown) then {
        if (combat_readiness < 20) then {
            _infsquad = "militia";
        };
        if ((_sector_cache select 1) != "" && (_sector_cache select 1) != _infsquad) then {
            _cached_vehicles = [];
            _cached_squads = [];
            _cached_units_in_building = [];
        };

        _total =   infantry_weight+  armor_weight+  air_weight;
        _static_mg = ceil(4 + ((ceil(combat_readiness - 20)/20) * (1 + (infantry_weight/_total))));
        _static_mg_heavy = (2 max ceil(((combat_readiness * (infantry_weight / _total))/10))) min 4;
        _static_at = ceil(3 + ((ceil(combat_readiness - 20)/20) * (1 + (armor_weight/_total))));

        if (air_weight>35 || combat_readiness > 50 ) then {
            _static_aa_heavy = 1;
        };
        if (air_weight>40|| combat_readiness > 80) then {
            _static_aa_heavy = 2;
        };
        
        _static_mg = _static_mg - count _cached_static_mg;
        _static_at = _static_at - count _cached_static_at;
        _static_mg_heavy = _static_mg_heavy - count _cached_static_mg_heavy;
        _static_aa_heavy = _static_aa_heavy - count _cached_static_aa_heavy;

        switch (true) do {
            case (count(_cached_squads) < 1):{
                    _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                };
            case (count(_cached_squads) < 2):{
                    _squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                };
            case (count(_cached_squads) < 3):{
                    if (GRLIB_unitcap >= 1) then {
                        _squad3 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                    };
                };
            case (count(_cached_squads) < 4):{
                    if (GRLIB_unitcap >= 1.5) then {
                        _squad4 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                    };
                };
        };

        if (_infsquad == "army") then {
            switch (true) do {
                case (count(_cached_vehicles) < 1):{
                        _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                    };
                case (count(_cached_vehicles) < 2):{
                        _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                    };
                case (count(_cached_vehicles) < 3):{
                        _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                    };
                case (count(_cached_vehicles) < 4):{
                        _vehtospawn pushback([true] call KPLIB_fnc_getAdaptiveVehicle);
                    };
                case (count(_cached_vehicles) < 5):{
                        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                        };
                    };
            };
        } else {
            _vehtospawn = [];
            switch (true) do {
                case (count(_cached_vehicles) < 1):{
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
                case (count(_cached_vehicles) < 2):{
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
                case (count(_cached_vehicles) < 3):{
                        if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback(selectRandom militia_vehicles);
                        };
                    };
                case (count(_cached_vehicles) < 4):{
                        if ((random 100) > (50 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback(selectRandom militia_vehicles);
                        };
                    };
            };
        };

        _spawncivs = true;

        if (((random 100) <= KP_liberation_resistance_sector_chance) && (([] call KPLIB_fnc_crGetMulti) > 0)) then {
            _guerilla = true;
        };

        _building_ai_max = round(100 * _popfactor);
        if (count(_cached_units_in_building) < _building_ai_max) then {
            _building_ai_max = _building_ai_max - count(_cached_units_in_building);
        };
        _building_range = 250;
        _local_capture_size = _local_capture_size * 1.4;

        if (KP_liberation_civ_rep < 0) then {
            _iedcount = round(2 + (ceil(random 4)) * (round((KP_liberation_civ_rep * -1) / 33)) * GRLIB_difficulty_modifier);
        } else {
            _iedcount = 0;
        };
        if (_iedcount > 16) then {
            _iedcount = 16
        };
    };

    if (_sector in sectors_capture) then {
        if (combat_readiness < 35) then {
            _infsquad = "militia";
        };
        if ((_sector_cache select 1) != "" && (_sector_cache select 1) != _infsquad) then {
            _cached_vehicles = [];
            _cached_squads = [];
            _cached_units_in_building = [];
        };


        _total =   infantry_weight+  armor_weight+  air_weight;
        _static_mg = ceil(2 + ((ceil(combat_readiness - 30)/20) * (1 + (infantry_weight/_total))));
        _static_mg_heavy = (2 max ceil(((combat_readiness * (infantry_weight / _total))/10))) min 4;


         _static_at = ceil(1 + ((ceil(combat_readiness - 30)/20) * (1 + (armor_weight/_total))));

        if (air_weight>40 || combat_readiness > 80) then {
            _static_aa_heavy = 1;
        };
        _static_mg = _static_mg - count _cached_static_mg;
        _static_at = _static_at - count _cached_static_at;
        _static_mg_heavy = _static_mg_heavy - count _cached_static_mg_heavy;
        _static_aa_heavy = _static_aa_heavy - count _cached_static_aa_heavy;

        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback(selectRandom militia_vehicles);
        };
        if (_infsquad == "army") then {
            switch (true) do {
                case (count(_cached_squads) < 1):{
                        _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                    };
                case (count(_cached_squads) < 2):{
                        if (GRLIB_unitcap >= 1.25) then {
                            _squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                        };
                    };
                case (count(_cached_squads) < 3):{
                        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                            _squad3 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                        };
                    };
            };
            _vehtospawn = [];
            switch (true) do {
                case (count(_cached_vehicles) < 1):{
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
                case (count(_cached_vehicles) < 2):{
                        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback(selectRandom militia_vehicles);
                        };
                    };
                case (count(_cached_vehicles) < 3):{
                        if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback(selectRandom militia_vehicles);
                        };
                    };
                case (count(_cached_vehicles) < 4):{
                        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                        };
                    };
            };

        } else {
            switch (true) do {
                case (count(_cached_squads) < 1):{
                        _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                    };
                case (count(_cached_squads) < 2):{
                        if (GRLIB_unitcap >= 1.25) then {
                            _squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                        };
                    };
            };
            _vehtospawn = [];
            switch (true) do {
                case (count(_cached_vehicles) < 1):{
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
                case (count(_cached_vehicles) < 2):{
                        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback(selectRandom militia_vehicles);
                        };
                    };
                case (count(_cached_vehicles) < 3):{
                        if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback(selectRandom militia_vehicles);
                        };
                    };
            };
        };

        _spawncivs = true;

        if (((random 100) <= KP_liberation_resistance_sector_chance) && (([] call KPLIB_fnc_crGetMulti) > 0)) then {
            _guerilla = true;
        };

        _building_ai_max = round((ceil(30 + (round(combat_readiness / 8)))) * _popfactor);
        if (count(_cached_units_in_building) < _building_ai_max) then {
            _building_ai_max = _building_ai_max - count(_cached_units_in_building);
        };
        _building_range = 200;

        if (KP_liberation_civ_rep < 0) then {
            _iedcount = round((ceil(random 4)) * (round((KP_liberation_civ_rep * -1) / 33)) * GRLIB_difficulty_modifier);
        } else {
            _iedcount = 0;
        };
        if (_iedcount > 12) then {
            _iedcount = 12
        };
    };

    if (_sector in sectors_military) then {

        switch (true) do {
            case (count(_cached_squads) < 1):{
                    _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                };
            case (count(_cached_squads) < 2):{
                    _squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                };
            case (count(_cached_squads) < 3):{
                    if (GRLIB_unitcap >= 1.5) then {
                        _squad3 = ([] call KPLIB_fnc_getSquadComp);
                    };
                };
            case (count(_cached_squads) < 4):{
                    if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                        _squad4 = ([] call KPLIB_fnc_getSquadComp);
                    };
                };
        };
        
        _total =   infantry_weight+  armor_weight+  air_weight;
        _static_mg = ceil(3 + ((ceil(combat_readiness - 20)/20) * (1 + (infantry_weight/_total))));
        _static_mg_heavy = (2 max ceil(((combat_readiness * (infantry_weight / _total))/10))) min 5;
        _static_at = ceil(2 + ((ceil(combat_readiness - 30)/20) * (1 + (armor_weight/_total))));
        
        if (air_weight>30 || combat_readiness > 40) then {
            _static_aa_heavy = 1;
        };
        if (air_weight>35 || combat_readiness > 80) then {
            _static_aa_heavy = 2;
        };
        _static_mg = _static_mg - count _cached_static_mg;
        _static_at = _static_at - count _cached_static_at;
        _static_mg_heavy = _static_mg_heavy - count _cached_static_mg_heavy;
        _static_aa_heavy = _static_aa_heavy - count _cached_static_aa_heavy;

        _vehtospawn = [];
        switch (true) do {
            case (count(_cached_vehicles) < 1):{
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
            case (count(_cached_vehicles) < 2):{
                            _vehtospawn pushback([true] call KPLIB_fnc_getAdaptiveVehicle);
                    };
            case (count(_cached_vehicles) < 3):{
                        if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                        };
                    };
            case (count(_cached_vehicles) < 4):{
                        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
                            _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                        };
                    };
            };

        _spawncivs = false;

        _building_ai_max = round((ceil(40 + (round(combat_readiness / 4)))) * _popfactor);
        _building_range = 120;
    };

    if (_sector in sectors_factory) then {
        if (combat_readiness < 40) then {
            _infsquad = "militia";
        };

        if ((_sector_cache select 1) != "" && (_sector_cache select 1) != _infsquad) then {
            _cached_vehicles = [];
            _cached_squads = [];
            _cached_units_in_building = [];
        };

        _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
        switch (true) do {
            case (count(_cached_squads) < 1):{
                    _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                };
            case (count(_cached_squads) < 2):{
                    if (GRLIB_unitcap >= 1.25) then {
                            _squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);
                        };
                };
        };


        _vehtospawn = [];
        switch (true) do {
            case (count(_cached_vehicles) < 1):{
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
            case (count(_cached_vehicles) < 2):{
                    if ((random 100) > 66) then {
                        _vehtospawn pushback(selectRandom militia_vehicles);
                    };
                };
            case (count(_cached_vehicles) < 3):{
                    if ((random 100) > 33) then {
                        _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
                    };
                };
        };
        
        _total =   infantry_weight+  armor_weight+  air_weight;
        _static_mg = ceil(1 + ((ceil(combat_readiness - 30)/20) * (1 + (infantry_weight/_total))));
        _static_mg_heavy = (2 max ceil(((combat_readiness * (infantry_weight / _total))/10))) min 4;

         _static_at = ceil(2 + ((ceil(combat_readiness - 20)/20) * (1 + (armor_weight/_total))));

        if (air_weight>40|| combat_readiness > 80) then {
            _static_aa_heavy = 1;
        };
        _static_mg = _static_mg - count _cached_static_mg;
        _static_at = _static_at - count _cached_static_at;
        _static_mg_heavy = _static_mg_heavy - count _cached_static_mg_heavy;
        _static_aa_heavy = _static_aa_heavy - count _cached_static_aa_heavy;


        _spawncivs = false;

        if (((random 100) <= KP_liberation_resistance_sector_chance) && (([] call KPLIB_fnc_crGetMulti) > 0)) then {
            _guerilla = true;
        };

        _building_ai_max = round((ceil(22 + (round(combat_readiness / 8)))) * _popfactor);
        _building_range = 120;

        if (KP_liberation_civ_rep < 0) then {
            _iedcount = round((ceil(random 3)) * (round((KP_liberation_civ_rep * -1) / 33)) * GRLIB_difficulty_modifier);
        } else {
            _iedcount = 0;
        };
        if (_iedcount > 8) then {
            _iedcount = 8
        };
    };

    if (_sector in sectors_tower) then {
        _squad1 = ([] call KPLIB_fnc_getSquadComp);
        if (combat_readiness > 30) then {
            _squad2 = ([] call KPLIB_fnc_getSquadComp);
        };
        if (GRLIB_unitcap >= 1.5) then {
            _squad3 = ([] call KPLIB_fnc_getSquadComp);
        };

        if ((random 100) > 95) then {
            _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
        };
        if (combat_readiness > 60) then {
            _squad2 = ([true] call KPLIB_fnc_getAdaptiveVehicle);
        };

        {
            _offset1  =[-0.774414,0.594849,-23.8931];  
            _offset2  =[0.463867,1.0481,-24.0858]; 
            _offset3  =[0.569336,-1.17261,-24.1316]; 
            _offset4  =[-0.764648,-1.20349,-23.9235]; 
            _offsets = [selectRandom [_offset1,_offset2],selectRandom [_offset3,_offset4]];
            _tower = _x;
            { 
                _sniper_positions pushBack [  
                    ((getPosATL _tower) select 0) - (_x select 0),  
                    ((getPosATL _tower) select 1) - (_x select 1),  
                    ((getPosATL _tower) select 2) - (_x select 2)  
                ];  
            } forEach _offsets;
        
        } forEach (_sectorpos nearObjects ["Land_TTowerBig_2_F", 200]);
        
        {
            _offset1  =[-1.80078,-1.89746,-22.1357];  
            _offset2  =[2.20801,-1.54297,-22.0331]; 
            _offset3  =[1.74023,2.06934,-21.9976]; 
            _offset4  =[-1.79297,1.8916,-22.1355]; 
            _offsets = [selectRandom [_offset1,_offset2],selectRandom [_offset3,_offset4]];
            _tower = _x;
            { 
                _sniper_positions pushBack [  
                    ((getPosATL _tower) select 0) - (_x select 0),  
                    ((getPosATL _tower) select 1) - (_x select 1),  
                    ((getPosATL _tower) select 2) - (_x select 2)  
                ];  
            } forEach _offsets;
        
        } forEach (_sectorpos nearObjects ["Land_TTowerBig_1_F", 200]);
        _spawncivs = false;

        _building_ai_max = 0;
    };
    _samSystem = [];
    if (_sector in sectors_SAM && (count opfor_SAM) > 0) then {
        _samSystem = selectrandom opfor_SAM;
        if ((count _samSystem) == 2) then {
            _squad1 = ([] call KPLIB_fnc_getSquadComp);
            if (combat_readiness > 30) then {
                _squad2 = ([] call KPLIB_fnc_getSquadComp);
            };
            if (GRLIB_unitcap >= 1.5) then {
                _squad3 = ([] call KPLIB_fnc_getSquadComp);
            };

            if ((random 100) > 95) then {
                _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
            };

            _spawncivs = false;

            _building_ai_max = 0;
        };
    };

    if (_sector in sectors_lightArtillery && (count opfor_light_artillery) > 0) then {

        _light_artillerySystem = selectrandom opfor_light_artillery;
        _squad1 = ([] call KPLIB_fnc_getSquadComp);
        if (combat_readiness > 60) then {
            _squad2 = ([] call KPLIB_fnc_getSquadComp);
        };
        if (GRLIB_unitcap >= 1.5) then {
            _squad3 = ([] call KPLIB_fnc_getSquadComp);
        };

        if ((random 100) > 95) then {
            _vehtospawn pushback([] call KPLIB_fnc_getAdaptiveVehicle);
        };

        _spawncivs = false;
        if (count(_cached_vehicles)==0) then {
            //artillery
            _vehtospawn pushBack _light_artillerySystem;
            _vehtospawn pushBack _light_artillerySystem;
            _vehtospawn pushBack _light_artillerySystem;
        };

        _building_ai_max = 0;

    };

    if (_sector in sectors_heavyArtillery && (count opfor_heavy_artillery) > 0) then {

        _heavy_artillerySystem = selectrandom opfor_heavy_artillery;
        _spawncivs = false;

        if (count(_cached_vehicles)==0) then {
            //artillery
            _vehtospawn pushBack _heavy_artillerySystem;
            _vehtospawn pushBack _heavy_artillerySystem;
            _vehtospawn pushback ([true] call KPLIB_fnc_getAdaptiveVehicle);
            _vehtospawn pushback ([true] call KPLIB_fnc_getAdaptiveVehicle);
        };

        _building_ai_max = 0;

    };

    _vehtospawn = _vehtospawn select {
        !(isNil "_x")
    };

    if (KP_liberation_sectorspawn_debug > 0) then {
        [format["Sector %1 (%2) - manage_one_sector calculated -> _infsquad: %3 - _squad1: %4 - _squad2: %5 - _squad3: %6 - _squad4: %7 - _vehtospawn: %8 - _building_ai_max: %9", (markerText _sector), _sector, _infsquad, (count _squad1), (count _squad2), (count _squad3), (count _squad4), (count _vehtospawn), _building_ai_max], "SECTORSPAWN"] remoteExecCall["KPLIB_fnc_log", 2];
    };

    if (_building_ai_max > 0 && GRLIB_adaptive_opfor) then {
        _building_ai_max = round(_building_ai_max * ([] call KPLIB_fnc_getOpforFactor));
    };
    _g = createGroup[GRLIB_side_enemy, true]; 
    

    //vehicles
    
    {
    
        _vehicle = objNull;
        if (_sector in sectors_lightArtillery || _sector in sectors_heavyArtillery || _sector in sectors_SAM) then {
            _vehicle = [ _x select 0 , _x select 1 , false, true, _g] call KPLIB_fnc_spawnVehicle;
            _vehicle allowCrewInImmobile true;
            _vehicle setFuel 0;
        } else {
            _vehicle = [ _x select 0 ,  _x select 1 , true] call KPLIB_fnc_spawnVehicle;
            [group((crew _vehicle) select 0), _sectorpos] spawn add_defense_waypoints;
        };
        _managed_units pushback _vehicle; 
        {
            _managed_units pushback _x;
        }foreach(crew _vehicle);
        if ((_vehicle isKindOf "Tank") || (_vehicle isKindOf "Car")) then {
            if (typeOf _vehicle in militia_vehicles) then {
                _vehicle forceFlagtexture opfor_flag_militia_texture;
            } else {
                _vehicle forceFlagtexture opfor_flag_texture;
            };
        };

        sleep 0.25;
        
    } forEach _cached_vehicles;
    
    {
        
        _vehicle = objNull;

        if (_sector in sectors_lightArtillery || _sector in sectors_heavyArtillery  ) then {
            _vehicle = [_sectorpos, _x, false, true, _g] call KPLIB_fnc_spawnVehicle;
            _vehicle allowCrewInImmobile true;
            if ((tolower _x) in opfor_heavy_artillery) then {
                _vehicle setFuel 0;
            };
        } else {
                _vehicle = [_sectorpos, _x] call KPLIB_fnc_spawnVehicle;
                [group((crew _vehicle) select 0), _sectorpos] spawn add_defense_waypoints;

        };
        _managed_units pushback _vehicle; {
            _managed_units pushback _x;
        }
        foreach(crew _vehicle);
        if ((_vehicle isKindOf "Tank") || (_vehicle isKindOf "Car")) then {
            if (typeOf _vehicle in militia_vehicles) then {
                _vehicle forceFlagtexture opfor_flag_militia_texture;
            } else {
                _vehicle forceFlagtexture opfor_flag_texture;
            };
        };

        _cached_vehicles pushBack [getPosATL _vehicle , typeof _vehicle];
        sleep 0.25;
    } forEach _vehtospawn;

    if (_sector in sectors_SAM) then {
        if ((count _samSystem) == 2) then {     
                //Radars
                _hpos = ASLToATL  ([_sectorpos,100] call KPLIB_fnc_getHighestPos);
                _vehicle = [ _hpos getPos [0,0]  , _samSystem select 0 , true, true, _g] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _vehicle setFuel 0;
                _managed_units pushback _vehicle; 
                {_managed_units pushback _x; }foreach(crew _vehicle);

                _vehicle = [ _hpos getPos [20,90] , _samSystem select 1 , true, true, _g] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _vehicle  setdir 90;
                _vehicle setFuel 0;
                _managed_units pushback _vehicle; 
                {_managed_units pushback _x; }foreach(crew _vehicle);

                _vehicle = [ _hpos getPos [20,180] , _samSystem select 1 , true, true, _g] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _vehicle  setdir 180;
                _vehicle setFuel 0;
                _managed_units pushback _vehicle; 
                {_managed_units pushback _x; }foreach(crew _vehicle);

                _vehicle = [ _hpos getPos [20,270] , _samSystem select 1 , true, true, _g] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _vehicle  setdir 270;
                _vehicle setFuel 0;
                _managed_units pushback _vehicle; 
                {_managed_units pushback _x; }foreach(crew _vehicle);

                _vehicle = [ _hpos getPos [20,360] , _samSystem select 1 , true, true, _g] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _vehicle  setdir 360;
                _vehicle setFuel 0;
                _managed_units pushback _vehicle; 
                {_managed_units pushback _x; }foreach(crew _vehicle);

            };

    };

    _units = ([_cached_units_in_building] call KPLIB_fnc_spawnBuildingSquadFromCache);
    _managed_units = _managed_units + _units;
    _units = ([_cached_units_on_building] call KPLIB_fnc_spawnBuildingSquadFromCache);
    _managed_units = _managed_units + _units;

    {
        {
            _vehicle = [ _x select 0 ,  _x select 1 , true] call KPLIB_fnc_spawnVehicle;
            _managed_units pushback _vehicle; 
            {
                _managed_units pushback _x;
            }foreach(crew _vehicle);
            sleep 0.25;   
        } forEach _x;
    } forEach [_cached_static_mg,_cached_static_at,_cached_static_mg_heavy,_cached_static_aa_heavy];

    if (_building_ai_max > 0) then {

        _largestB = objNull;
        _largestBPos = 0;
        _allbuildings = (nearestObjects[_sectorpos, ["House"], _building_range]) select {
            alive _x
        };
        _buildingpositions = []; 
        {
            _thisBuildingpositions = ([_x] call BIS_fnc_buildingPositions);
            _buildingpositions = _buildingpositions + _thisBuildingpositions;
            _thisBuildingpositionsCount = count _thisBuildingpositions;
            if (_thisBuildingpositionsCount > _largestBPos) then {
                _largestBPos = _thisBuildingpositionsCount;
                _largestB = _x;
            };
        }
        forEach _allbuildings;
        _buildingpositions  = _buildingpositions - (_cached_units_in_building apply {_x select 0});
        _buildingpositions  = _buildingpositions - (_cached_units_on_building apply {_x select 0});
        _buildingpositions  = _buildingpositions - (_cached_static_mg apply {_x select 0});
        _buildingpositions  = _buildingpositions - (_cached_static_at apply {_x select 0});
        _buildingpositions  = _buildingpositions - (_cached_static_mg_heavy apply {_x select 0});
        _buildingpositions  = _buildingpositions - (_cached_static_aa_heavy apply {_x select 0});
        if !(isNull _largestB) then {
            _largestbuildingpositions = ([_largestB] call BIS_fnc_buildingPositions);
            _buildingpositions = _buildingpositions - _largestbuildingpositions;
            _largestbuilding_top_positions = [_largestbuildingpositions] call KPLIB_fnc_getBuildingRooftopPositions;
            _largestbuildingpositions = _largestbuildingpositions - _largestbuilding_top_positions;
            if (_sector in (KP_Objectives apply {_x select 1}) ) then {
                _units = [];
                _objective_index = KP_Objectives findIf {_x select 1 == _sector};
                _objective = KP_Objectives select _objective_index;
                if (
                    !((_objective select 0) in KP_liberation_failed_objectives) 
                &&  !((_objective select 0) in KP_liberation_successful_objectives)
                    ) then {
                    _objective pushBack _largestB;
                    _objective pushBack _largestbuildingpositions; 
                    _objective pushBack _cached_objectives;
                    switch (_objective select 2) do {
                        case "capture": {                      
                            _units = _objective call KPLIB_fnc_spawnCaptureObjectiveInSector;
                            _managed_units = _managed_units + _units;
                        };
                        case "rescue": {     
                            _units = _objective call KPLIB_fnc_spawnRescueObjectiveInSector;
                            _managed_units = _managed_units + _units;
                        };
                        case "destroy": {     
                            _units = _objective call KPLIB_fnc_spawnDestroyObjectiveInSector;
                            _managed_units = _managed_units + _units;
                        };
                    };
                };
            } else {

                //spawn normal officer 
                _grp = createGroup[GRLIB_side_enemy, true];
                _officer_pos = selectRandom _largestbuildingpositions;
                _unit = [opfor_officer, _officer_pos, _grp] call KPLIB_fnc_createManagedUnit;
                _unit setDir(random 360);
                _unit setPos _officer_pos;

                if (count opfor_officer_cars > 0) then {
                    _nearestRoad = [getPosATL _largestB, 500] call BIS_fnc_nearestRoad;
                    _info = getRoadInfo _nearestRoad;
                    _dir = (_info select 6) getDir (_info select 7); 
                    if (!isnull _nearestRoad) then { 
                        {
                            _officer_vehicle = [(( getPosATL _nearestRoad) getPos [10 * _foreachindex , _dir] )  ,  _x, true] call KPLIB_fnc_spawnVehicle;
                            _managed_units pushback _officer_vehicle; 
                            {
                                [_x, _sector] spawn building_defence_ai;
                                _managed_units pushback _x;
                            }foreach(crew _officer_vehicle); 
                            _officer_vehicle setdir _dir;
                            _officer_vehicle forceFlagtexture opfor_flag_texture;
                        } forEach opfor_officer_cars;
                    };
                };

                [_unit, _sector] spawn building_defence_ai;
                _managed_units = _managed_units + [_unit];
                _largestbuildingpositions = _largestbuildingpositions - [_officer_pos];
                _grp = createGroup[GRLIB_side_enemy, true];
                _managed_units = _managed_units + (['army', count _largestbuildingpositions, _largestbuildingpositions, _sector, _grp] call KPLIB_fnc_spawnBuildingSquad); {
                [_x, _sector] spawn building_defence_ai;
                }forEach units _grp;

                private _numberofdoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _largestB) >> "numberOfDoors");
                if(_numberofdoors != -1 and _numberofdoors != 0) then{ 
                        for "_i" from 1 to _numberOfDoors do {
                            _largestB animate[format["door_%1_rot",_i],0];
                            _largestB setVariable[format["bis_disabled_Door_%1",_i],1,true];
                        };
                    };
                };
            };

        
        
        
        
        _top_positions = [_buildingpositions] call KPLIB_fnc_getBuildingRooftopPositions;
        _buildingpositions = _buildingpositions - _top_positions;
        _top_positions = [_top_positions, [], { (_x select 2) }, "DESCEND"] call BIS_fnc_sortBy;
        _good_sniper_positions = [];
        {
            _currentPos = _x;
            if ((_x select 2) > 8 && count(_good_sniper_positions select {(_x distance _currentPos) < 20 } ) == 0) then {
                _good_sniper_positions pushBackUnique _currentPos;
            }; 
        } forEach _top_positions;
        for "_i"
        from 1 to (5 min (count _good_sniper_positions)) do {
            if (count _good_sniper_positions > 0) then {
            _sniper_pos = selectRandom _good_sniper_positions;
            _top_positions = _top_positions - [_sniper_pos];
            _good_sniper_positions = _good_sniper_positions - [_sniper_pos];
            _sniper_positions pushBack _sniper_pos;
            };
        };



        if (KP_liberation_sectorspawn_debug > 0) then {
            [format["Sector %1 (%2) - manage_one_sector found %3 building positions", (markerText _sector), _sector, (count _buildingpositions)], "SECTORSPAWN"] remoteExecCall["KPLIB_fnc_log", 2];
        };
        if (count _buildingpositions > _minimum_building_positions) then {
            _units = ([_infsquad, _building_ai_max, _buildingpositions, _sector] call KPLIB_fnc_spawnBuildingSquad);
            {
                _cached_units_in_building pushBack [getPosATL _x , typeof _x];
            } forEach _units;
            _managed_units = _managed_units + _units;
        };
        if (count _top_positions > 0) then {
            _g = createGroup[GRLIB_side_enemy, true];
            _top_positions = [_top_positions] call CBA_fnc_Shuffle;
            for "_i"
            from 1 to((count _top_positions) min _static_mg) do {
                    _gun = selectRandom(opfor_static_guns - opfor_heavy_static_guns);
                    if (count _top_positions > 0 ) then {
                        _emptypos = selectRandom _top_positions;
                        if (count _emptypos > 1) then {
                            _vehicle = [
                                [_emptypos select 0, _emptypos select 1, ((_emptypos select 2) + 0.8)], _gun, true, true, _g
                            ] call KPLIB_fnc_spawnVehicle;
                            _vehicle allowCrewInImmobile true;
                            _managed_units pushback _vehicle; {
                                _managed_units pushback _x;
                            }
                            foreach(crew _vehicle);
                            //sleep 1;
                            //_vehicle setPosATL[(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 0.5];
                            //_vehicle setVectorUp surfaceNormal position _vehicle;
                            _top_positions = _top_positions - [_emptypos];
                            _cached_static_mg pushBack [_emptypos,_gun];
                        };
                    };
                };
            for "_i"
            from 1 to((count _top_positions) min _static_at) do {
                _gun = selectRandom(opfor_AT_static_guns - opfor_heavy_static_guns);
                if (count _top_positions > 0 ) then {
                    _emptypos = selectRandom _top_positions;
                    if (count _emptypos > 1) then {
                        _vehicle = [
                            [_emptypos select 0, _emptypos select 1, (_emptypos select 2) + 0.8], _gun, true, true, _g
                        ] call KPLIB_fnc_spawnVehicle;
                        _vehicle allowCrewInImmobile true;
                        _managed_units pushback _vehicle; {
                            _managed_units pushback _x;
                        }
                        foreach(crew _vehicle);
                        //sleep 1;
                        // _vehicle setPosATL[(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1];
                        // _vehicle setVectorUp surfaceNormal position _vehicle;
                        _top_positions = _top_positions - [_emptypos];
                        _cached_static_at pushBack [_emptypos,_gun];
                    };
                };
            };
        };

        for "_i"
        from 1 to _static_mg_heavy do {
            _gun = selectRandom(opfor_static_guns arrayIntersect opfor_heavy_static_guns);
            _emptypos = _sectorpos findEmptyPosition[5, _building_range, _gun];
            _rndpos = [
                [
                    [_sectorpos, _building_range]
                ],
                []
            ] call BIS_fnc_randomPos;
            _emptypos = _rndpos findEmptyPosition[0, 30, _gun];
            if (count _emptypos > 1) then {
                _vehicle = [
                    [_emptypos select 0, _emptypos select 1, (_emptypos select 2) + 0.8], _gun, true, true, _g
                ] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _managed_units pushback _vehicle; {
                    _managed_units pushback _x;
                }
                foreach(crew _vehicle);
                _vehicle setDir((_vehicle getRelDir _sectorpos) - 180);
                // sleep 1;
                // _vehicle setPosATL[(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1];
                // _vehicle setVectorUp surfaceNormal position _vehicle;
                _cached_static_mg_heavy pushBack [_emptypos,_gun];
            };
        };
        //_static_aa_heavy
        for "_i"
        from 1 to _static_aa_heavy do {
            _gun = selectRandom(opfor_AA_static_guns arrayIntersect opfor_heavy_static_guns);
            _emptypos = _sectorpos findEmptyPosition[5, _building_range, _gun];
            _rndpos = [
                [
                    [_sectorpos, _building_range]
                ],
                []
            ] call BIS_fnc_randomPos;
            _emptypos = _rndpos findEmptyPosition[0, 30, _gun];
            if (count _emptypos > 1) then {
                _vehicle = [
                    [_emptypos select 0, _emptypos select 1, (_emptypos select 2) + 0.8], _gun, true, true, _g
                ] call KPLIB_fnc_spawnVehicle;
                _vehicle allowCrewInImmobile true;
                _managed_units pushback _vehicle; {
                    _managed_units pushback _x;
                }
                foreach(crew _vehicle);
                _vehicle setDir((_vehicle getRelDir _sectorpos) - 180);
                // sleep 1;
                // _vehicle setPosATL[(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1];
                // _vehicle setVectorUp surfaceNormal position _vehicle;
                _cached_static_aa_heavy pushBack [_emptypos,_gun];
            };
        };
        _num = ceil(_building_ai_max * 0.4) min (count _top_positions);
        _units = ([_infsquad, _num, _top_positions, _sector] call KPLIB_fnc_spawnBuildingSquad);
        {
            _cached_units_on_building pushBack [getPosATL _x , typeof _x];
        } forEach _units;
                _managed_units = _managed_units + _units;
    };
    
    {
        _cached_objectives pushBackUnique _x;
        
    } forEach (_managed_units select { _x getVariable ["is_objective",false] });
    _managed_units = _managed_units + ([_sectorpos] call KPLIB_fnc_spawnMilitaryPostSquad);

    if (count _squad1 > 0) then {
        _grp = [_sector, _squad1] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _grp setVariable ["lambs_danger_enableGroupReinforce", false, true];
        _managed_units = _managed_units + (units _grp);
    };

    if (count _squad2 > 0) then {
        _grp = [_sector, _squad2] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _grp setVariable ["lambs_danger_enableGroupReinforce", false, true];
        _managed_units = _managed_units + (units _grp);
    };

    if (count _squad3 > 0) then {
        _grp = [_sector, _squad3] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _grp setVariable ["lambs_danger_enableGroupReinforce", true, true];
        _managed_units = _managed_units + (units _grp);
    };

    if (count _squad4 > 0) then {
        _grp = [_sector, _squad4] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _grp setVariable ["lambs_danger_enableGroupReinforce", true, true];
        _managed_units = _managed_units + (units _grp);
    };

    if (count _sniper_positions > 0) then {
        _grp = createGroup[GRLIB_side_enemy, true];
        {
            _unit = [opfor_sniper, _sectorpos, _grp] call KPLIB_fnc_createManagedUnit;
            _unit setPosATL _x;
            _managed_units = _managed_units + [_unit];
            [_unit, _sector] spawn sniper_ai;
        } forEach _sniper_positions;
    };

    if (_spawncivs && GRLIB_civilian_activity > 0) then {
        _managed_units = _managed_units + ([_sector,_buildingpositions] call KPLIB_fnc_spawnCivilians);
    };

    if (KP_liberation_asymmetric_debug > 0) then {
        [format["Sector %1 (%2) - Range: %3 - Count: %4", (markerText _sector), _sector, _building_range, _iedcount], "ASYMMETRIC"] remoteExecCall["KPLIB_fnc_log", 2];
    };
    [_sector, _building_range, _iedcount] spawn ied_manager;

    if (_guerilla) then {
        [_sector] spawn sector_guerilla;
    };

    if (_cached_index > -1) then {
        KP_liberation_Sector_Cache set  [_cached_index,[_sector,_infsquad,_cached_vehicles,_cached_squads,_cached_units_in_building,_cached_units_on_building,_cached_static_mg,_cached_static_at,_cached_static_mg_heavy,_cached_static_aa_heavy,_cached_objectives]];
    } else {
        KP_liberation_Sector_Cache pushBack [_sector,_infsquad,_cached_vehicles,_cached_squads,_cached_units_in_building,_cached_units_on_building,_cached_static_mg,_cached_static_at,_cached_static_mg_heavy,_cached_static_aa_heavy,_cached_objectives];
    };
    publicVariable "KP_liberation_Sector_Cache";
    
    if (isnil "sectors_opfor_sniper_nests_active") then {
        sectors_opfor_sniper_nests_active = [];
    };

    _sniper= "";
    _spotter = "";
    if (combat_readiness > 60) then {
        _sniper = opfor_sf_sniper;
        _spotter = opfor_sf_sharpshooter;
    } else {
        _sniper = opfor_sniper;
        _spotter = opfor_sharpshooter;
    };

    if !(_sector in sectors_SAM) then {
            {
            _pos = getmarkerpos _x;

            if !(_x in sectors_opfor_sniper_nests_active) then {
                _grp = createGroup[GRLIB_side_enemy, true];
                _unit = [_sniper, _sectorpos, _grp] call KPLIB_fnc_createManagedUnit;
                _unit setPosATL _pos;
                _unit doWatch _sectorpos;
                _managed_units = _managed_units + [_unit];
                [_unit, _sector] spawn sniper_ai;
                _unit setVariable ["nest",_x,true];
                _unitspotter = [_spotter, _sectorpos, _grp] call KPLIB_fnc_createManagedUnit;
                _unitspotter setPosATL _pos;
                _unitspotter doWatch _sectorpos;
                _managed_units = _managed_units + [_unitspotter];
                [_unitspotter,_unit, _sector] spawn spotter_ai;
                _unitspotter setVariable ["nest",_x,true];
            }else{
                _managed_units = _managed_units + (nearestObjects[_pos, [_sniper,_spotter], 50]);
            };

            sectors_opfor_sniper_nests_active pushBack  _x;

        } forEach (sectors_opfor_sniper_nests select { _sectorpos distance ( getmarkerpos _x) < 1200 });   
        publicVariable "sectors_opfor_sniper_nests_active";
    };
    
    sleep 10;

    if ((_sector in sectors_factory) || (_sector in sectors_capture) || (_sector in sectors_bigtown) || (_sector in sectors_military)) then {
        [_sector] remoteExec["reinforcements_remote_call", 2];
    };

    if (KP_liberation_sectorspawn_debug > 0) then {
        [format["Sector %1 (%2) - populating done", (markerText _sector), _sector], "SECTORSPAWN"] remoteExecCall["KPLIB_fnc_log", 2];
    };

    private _activationTime = time;
    private _isFleeing = false;
    private _orginalUnitcount = GRLIB_side_enemy countSide(_managed_units select {
        alive _x && (_x getVariable ['nest', ""] == "") && !(_x getVariable["ACE_isUnconscious", false]) && !(captive _x)
    });


    //set flee count
    private _fleeCount = 0;
    if (_sector in sectors_lightArtillery || _sector in sectors_SAM) then {
        _fleeCount = selectRandom[0, 0, 0, 0, 0, 1, 1, 1, 1, 2];
    } else {
        _fleeCount = (ceil(_orginalUnitcount * 0.05) max 1) min 5;
    };
    if (_sector in sectors_heavyArtillery) then {
        _fleeCount = 0;
    };

    // sector lifetime loop
    while {
        !_stopit
    }
    do {

        _sector_alive_devices = [];

        //check if all radars/launchers destroyed 
        if (_sector in sectors_SAM) then {
            _sector_alive_devices append(_managed_units select {
                alive _x
                    &&
                    (toLower(typeof _x)) in (opfor_SAM apply {
                        toLower(_x select 0)
                    })
            });
            _sector_alive_devices append(_managed_units select {
                alive _x
                    &&
                    (toLower(typeof _x)) in (opfor_SAM apply {
                        toLower(_x select 1)
                    })
            });
        };

        //check if artillery destroyed
        if (_sector in sectors_heavyArtillery || _sector in sectors_lightArtillery) then {
            _sector_alive_devices append(_managed_units select {
                alive _x
                    &&
                    (toLower(typeof _x)) in (opfor_heavy_artillery apply {
                        toLower(_x)
                    })
            });
            _sector_alive_devices append(_managed_units select {
                alive _x
                    &&
                    (toLower(typeof _x)) in (opfor_light_artillery apply {
                        toLower(_x)
                    })
            });
        };

        _unitcount = GRLIB_side_enemy countSide(_managed_units select {
            alive _x && (_x getVariable ['nest', ""] == "") && !(_x getVariable["ACE_isUnconscious", false]) && !(captive _x)
        });

        if (_fleeCount >= _unitcount) then {
            _isFleeing = true; {
                if (_x isKindOf "Man" && alive _x  && !(captive _x) && (side group _x) == GRLIB_side_enemy && (_x getVariable ['nest', ""] == "") ) then {
                    [_x, _sector] call KPLIB_fnc_makeUnitFlee;
                };

            }
            forEach _managed_units;
        };

        // sector was captured
        if ((count _sector_alive_devices) == 0 && ([_sectorpos, _local_capture_size] call KPLIB_fnc_getSectorOwnership == GRLIB_side_friendly) && (GRLIB_endgame == 0)) then {
            if (isServer) then {
                [_sector] spawn sector_liberated_remote_call;
            } else {
                [_sector] remoteExec["sector_liberated_remote_call", 2];
            };
            
            _stopit = true;

            // {
            //     [_x] spawn prisonner_ai;
            // }
            // forEach((markerPos _sector) nearEntities[["Man"], _local_capture_size * 1.2]);

            sleep 5;

            _taskId= format ["task_destroy_%1",_sector];
            _exists = [_taskId] call BIS_fnc_taskExists;
            if (_exists) then {
                [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
                deleteMarker (format ["marker_task_liberate_%1",_sector]);
            };

            _taskId= format ["task_liberate_%1",_sector];
            _exists = [_taskId] call BIS_fnc_taskExists;
            if (_exists) then {
                [_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
                deleteMarker (format ["marker_task_liberate_%1",_sector]);
            };

            sleep 60;

            active_sectors = active_sectors - [_sector];
            publicVariable "active_sectors";

            sleep 600;

            {
                if (_x isKindOf "Man") then {
                    if (side group _x != GRLIB_side_friendly) then {
                        if (_x getVariable ["is_objective",false]) then {
                            if ((_x distance _sectorpos) < 200) then {
                                _x enableSimulation false;
		                        _x hideObjectGlobal true;
		                        _x hideObject true;
                            };
                        } else {
                            _nest = _x getVariable ['nest', ""];
                                if (_nest == "" || !(_nest in  sectors_opfor_sniper_nests_active)) then {
                                    if (!(captive _x) && !(_x getVariable ['ace_captives_isHandcuffed', false])) then {
                                        deleteVehicle _x;
                                    };
                            };
                        };
                    };
                } else {
                    if (!isNull _x) then {
                        if (_x getVariable ["is_objective",false]) then {
                                if ((_x distance _sectorpos) < 200) then {
                                    _x enableSimulation false;
		                            _x hideObjectGlobal true;
		                            _x hideObject true;
                                };
                            } else {
                                [_x] call KPLIB_fnc_cleanOpforVehicle;
                            };
                    };
                };
            }
            forEach _managed_units;
        } else {
            if (!(_sector in sectors_forced_spawn) && ([_sectorpos, (([_opforcount] call KPLIB_fnc_getSectorRange) + 300), GRLIB_side_friendly, _sector] call KPLIB_fnc_getUnitsCount) == 0) then {
                _sector_despawn_tickets = _sector_despawn_tickets - 1;
            } else {
                // start counting running minutes after ADDITIONAL_TICKETS_DELAY
                private _runningMinutes = (floor((time - _activationTime) / 60)) - ADDITIONAL_TICKETS_DELAY;
                private _additionalTickets = (_runningMinutes * BASE_TICKETS);

                // clamp from 0 to "_maximum_additional_tickets"
                _additionalTickets = (_additionalTickets max 0) min _maximum_additional_tickets;

                _sector_despawn_tickets = BASE_TICKETS + _additionalTickets;
            };

            if ((_sector_despawn_tickets <= 0) || (_sector in sectors_forced_despawn && !(_sector in sectors_forced_spawn))) then {

                {
                    sectors_opfor_sniper_nests_active  deleteAt (sectors_opfor_sniper_nests_active find _x);
                } forEach (sectors_opfor_sniper_nests select { _sectorpos distance ( getmarkerpos _x) < 1200 });
                publicVariable "sectors_opfor_sniper_nests_active";
                {
                    if (_x isKindOf "Man") then {
                        if (_x getVariable ["is_objective",false]) then {
                            if ((_x distance _sectorpos) < 200) then {
                                _x enableSimulation false;
		                        _x hideObjectGlobal true;
		                        _x hideObject true;
                            };
                        } else {
                            _nest = _x getVariable ['nest', ""];
                            if (_nest == "" || !(_nest in  sectors_opfor_sniper_nests_active)) then {
                                if (!(captive _x) && !(_x getVariable ['fleeing', false]) && !(_x getVariable ['ace_captives_isHandcuffed', false])) then {
                                    deleteVehicle _x;
                                };
                            };
                        };
                    } else {
                        if (!isNull _x) then {
                            if (_x getVariable ["is_objective",false]) then {
                                if ((_x distance _sectorpos) < 200) then {
                                    _x enableSimulation false;
		                            _x hideObjectGlobal true;
		                            _x hideObject true;
                                };
                            } else {
                                [_x] call KPLIB_fnc_cleanOpforVehicle;
                            };
                        };
                    };
                    
                }
                forEach _managed_units; 
                _stopit = true;
                active_sectors = active_sectors - [_sector];
                publicVariable "active_sectors";
            };
        };
        sleep SECTOR_TICK_TIME;
    };
}
else {
    sleep 40;
    active_sectors = active_sectors - [_sector];
    publicVariable "active_sectors";
};

[format["Sector %1 (%2) deactivated - Was managed on: %3", (markerText _sector), _sector, debug_source], "SECTORSPAWN"] remoteExecCall["KPLIB_fnc_log", 2];