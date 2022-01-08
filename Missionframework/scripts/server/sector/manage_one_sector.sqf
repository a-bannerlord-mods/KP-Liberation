// base amount of sector lifetime tickets
// if there are no enemies one ticket is removed every SECTOR_TICK_TIME seconds
// 12 * 5 = 60s by default
#define BASE_TICKETS                12
#define SECTOR_TICK_TIME            5
// delay in minutes from which addional time will be added
#define ADDITIONAL_TICKETS_DELAY    5

params ["_sector"];

waitUntil {!isNil "combat_readiness"};

[format ["Sector %1 (%2) activated - Managed on: %3", (markerText _sector), _sector, debug_source], "SECTORSPAWN"] remoteExecCall ["KPLIB_fnc_log", 2];

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
private _minimum_building_positions = 5;
private _sector_despawn_tickets = BASE_TICKETS;
private _maximum_additional_tickets = (KP_liberation_delayDespawnMax * 60 / SECTOR_TICK_TIME);
private _popfactor = 1;
private _guerilla = false;

if (GRLIB_unitcap < 1) then {_popfactor = GRLIB_unitcap;};

if (_sector in active_sectors) exitWith {};
active_sectors pushback _sector; publicVariable "active_sectors";

private _opforcount = [] call KPLIB_fnc_getOpforCap;
[_sector, _opforcount] call wait_to_spawn_sector;
_range= [_opforcount] call KPLIB_fnc_getSectorRange;
if ([_sector,_range] call KPLIB_fnc_sectorCanBeActivated) then {

    // vechile , squads , units in building
    _chached_unit=[0,"",[],[],[]];

    

    if (_sector in sectors_bigtown) then {
        if (combat_readiness < 20) then {_infsquad = "militia";};
        if((_chached_unit select 1) != _infsquad){
             _chached_unit=[combat_readiness,_infsquad,[],[],[]];
        };

        switch (true) do {
            case (count (_chached_unit select 2) < 1): { _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);};
            case (count (_chached_unit select 2) < 2): { _squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);};
            case (count (_chached_unit select 2) < 3): {if (GRLIB_unitcap >= 1) then {_squad3 = ([_infsquad] call KPLIB_fnc_getSquadComp);};};
            case (count (_chached_unit select 2) < 4): {if (GRLIB_unitcap >= 1.5) then {_squad4 = ([_infsquad] call KPLIB_fnc_getSquadComp);};};
        };
  
        if (_infsquad == "army") then {
            switch (true) do {
                case (count (_chached_unit select 3) < 1): {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};
                case (count (_chached_unit select 3) < 2): {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};
                case (count (_chached_unit select 3) < 3): {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};
                case (count (_chached_unit select 3) < 4): {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};
                case (count (_chached_unit select 3) < 5): {if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};};
            };
        }else{
            _vehtospawn = [];
            switch (true) do {
                case (count (_chached_unit select 3) < 1): {_vehtospawn pushback (selectRandom militia_vehicles);};
                case (count (_chached_unit select 3) < 2): {_vehtospawn pushback (selectRandom militia_vehicles);};
                case (count (_chached_unit select 3) < 3): {if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};};
                case (count (_chached_unit select 3) < 4): {if ((random 100) > (50 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};};
            };
        };

        _spawncivs = true;

        if (((random 100) <= KP_liberation_resistance_sector_chance) && (([] call KPLIB_fnc_crGetMulti) > 0)) then {
            _guerilla = true;
        };

        _building_ai_max = round (100 * _popfactor);
        if(count (_chached_unit select 4) < _building_ai_max ) then{
                _building_ai_max = _building_ai_max - count (_chached_unit select 4);
        };
        _building_range = 250;
        _local_capture_size = _local_capture_size * 1.4;

        if (KP_liberation_civ_rep < 0) then {
            _iedcount = round (2 + (ceil (random 4)) * (round ((KP_liberation_civ_rep * -1) / 33)) * GRLIB_difficulty_modifier);
        } else {
            _iedcount = 0;
        };
        if (_iedcount > 16) then {_iedcount = 16};
    };

    if (_sector in sectors_capture) then {
        if (combat_readiness < 35) then {_infsquad = "militia";};
        if((_chached_unit select 1) != _infsquad){
             _chached_unit=[combat_readiness,_infsquad,[],[],[]];
        };
        
       

        
        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};
        if (_infsquad == "army") then {
             switch (true) do {
                case (count (_chached_unit select 2) < 1): { _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);};
                case (count (_chached_unit select 2) < 2): {  if (GRLIB_unitcap >= 1.25) then {_squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);};};
                case (count (_chached_unit select 2) < 3): {if ((random 100) > (33 / GRLIB_difficulty_modifier)) then { _squad3 = ([_infsquad] call KPLIB_fnc_getSquadComp);};};        
            };
             _vehtospawn = [];
            switch (true) do {
                case (count (_chached_unit select 3) < 1): {_vehtospawn pushback (selectRandom militia_vehicles);};
                case (count (_chached_unit select 3) < 2): {if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};};
                case (count (_chached_unit select 3) < 3): {if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};};
                case (count (_chached_unit select 3) < 4): {if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};};
            };
            
        }else{
            switch (true) do {
                case (count (_chached_unit select 2) < 1): { _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);};
                case (count (_chached_unit select 2) < 2): {  if (GRLIB_unitcap >= 1.25) then {_squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);};};
            };
            _vehtospawn = [];
            switch (true) do {
                case (count (_chached_unit select 3) < 1): {_vehtospawn pushback (selectRandom militia_vehicles);};
                case (count (_chached_unit select 3) < 2): {if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};};
                case (count (_chached_unit select 3) < 3): {if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback (selectRandom militia_vehicles);};};
            };
        };

        _spawncivs = true;

        if (((random 100) <= KP_liberation_resistance_sector_chance) && (([] call KPLIB_fnc_crGetMulti) > 0)) then {
            _guerilla = true;
        };

        _building_ai_max = round ((floor (30 + (round (combat_readiness / 8 )))) * _popfactor);
         if(count (_chached_unit select 4) < _building_ai_max ) then{
                _building_ai_max = _building_ai_max - count (_chached_unit select 4);
        };
        _building_range = 200;

        if (KP_liberation_civ_rep < 0) then {
            _iedcount = round ((ceil (random 4)) * (round ((KP_liberation_civ_rep * -1) / 33)) * GRLIB_difficulty_modifier);
        } else {
            _iedcount = 0;
        };
        if (_iedcount > 12) then {_iedcount = 12};
    };

    if (_sector in sectors_military) then {
        _squad1 = ([] call KPLIB_fnc_getSquadComp);
        _squad2 = ([] call KPLIB_fnc_getSquadComp);
        if (GRLIB_unitcap >= 1.5) then {_squad3 = ([] call KPLIB_fnc_getSquadComp);};

        _vehtospawn = [([] call KPLIB_fnc_getAdaptiveVehicle),([] call KPLIB_fnc_getAdaptiveVehicle)];
        if ((random 100) > (33 / GRLIB_difficulty_modifier)) then {
            _vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);
            _squad4 = ([] call KPLIB_fnc_getSquadComp);
        };
        if ((random 100) > (66 / GRLIB_difficulty_modifier)) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};

        _spawncivs = false;

        _building_ai_max = round ((floor (40 + (round (combat_readiness / 4 )))) * _popfactor);
        _building_range = 120;
    };

    if (_sector in sectors_factory) then {
        if (combat_readiness < 40) then {_infsquad = "militia";};

        _squad1 = ([_infsquad] call KPLIB_fnc_getSquadComp);
        if (GRLIB_unitcap >= 1.25) then {_squad2 = ([_infsquad] call KPLIB_fnc_getSquadComp);};

        if ((random 100) > 66) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};
        if ((random 100) > 33) then {_vehtospawn pushback (selectRandom militia_vehicles);};

        _spawncivs = false;

        if (((random 100) <= KP_liberation_resistance_sector_chance) && (([] call KPLIB_fnc_crGetMulti) > 0)) then {
            _guerilla = true;
        };

        _building_ai_max = round ((floor (18 + (round (combat_readiness / 10 )))) * _popfactor);
        _building_range = 120;

        if (KP_liberation_civ_rep < 0) then {
            _iedcount = round ((ceil (random 3)) * (round ((KP_liberation_civ_rep * -1) / 33)) * GRLIB_difficulty_modifier);
        } else {
            _iedcount = 0;
        };
        if (_iedcount > 8) then {_iedcount = 8};
    };

    if (_sector in sectors_tower) then {
        _squad1 = ([] call KPLIB_fnc_getSquadComp);
        if (combat_readiness > 30) then {_squad2 = ([] call KPLIB_fnc_getSquadComp);};
        if (GRLIB_unitcap >= 1.5) then {_squad3 = ([] call KPLIB_fnc_getSquadComp);};

        if((random 100) > 95) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};

        _spawncivs = false;

        _building_ai_max = 0;
    };

    if (_sector in sectors_SAM && (count opfor_SAM) > 0) then {
        _samSystem = selectrandom opfor_SAM;
        if ((count _samSystem) == 2) then {
            _squad1 = ([] call KPLIB_fnc_getSquadComp);
            if (combat_readiness > 30) then {_squad2 = ([] call KPLIB_fnc_getSquadComp);};
            if (GRLIB_unitcap >= 1.5) then {_squad3 = ([] call KPLIB_fnc_getSquadComp);};

            if((random 100) > 95) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};

            _spawncivs = false;

            //Radars
            _vehtospawn pushBack (_samSystem select 0);
            _vehtospawn pushBack (_samSystem select 0);

            //launchers
            _vehtospawn pushBack (_samSystem select 1);
            _vehtospawn pushBack (_samSystem select 1);
            _vehtospawn pushBack (_samSystem select 1);
            _vehtospawn pushBack (_samSystem select 1);

            _building_ai_max = 0;
        };
    };

    if (_sector in sectors_lightArtillery && (count opfor_light_artillery) > 0) then {

            _light_artillerySystem = selectrandom opfor_light_artillery;
            _squad1 = ([] call KPLIB_fnc_getSquadComp);
            if (combat_readiness > 60) then {_squad2 = ([] call KPLIB_fnc_getSquadComp);};
            if (GRLIB_unitcap >= 1.5) then {_squad3 = ([] call KPLIB_fnc_getSquadComp);};

            if((random 100) > 95) then {_vehtospawn pushback ([] call KPLIB_fnc_getAdaptiveVehicle);};

            _spawncivs = false;

            //artillery
            _vehtospawn pushBack _light_artillerySystem;
            _vehtospawn pushBack _light_artillerySystem;
            _vehtospawn pushBack _light_artillerySystem;
            
            _building_ai_max = 0;
        
    };

    if (_sector in sectors_heavyArtillery && (count opfor_heavy_artillery) > 0) then {

            _heavy_artillerySystem = selectrandom opfor_heavy_artillery;
            _spawncivs = false;

            //artillery
            _vehtospawn pushBack _heavy_artillerySystem;
            _vehtospawn pushBack _heavy_artillerySystem;
            
            _building_ai_max = 0;
        
    };
    
    _vehtospawn = _vehtospawn select {!(isNil "_x")};

    if (KP_liberation_sectorspawn_debug > 0) then {[format ["Sector %1 (%2) - manage_one_sector calculated -> _infsquad: %3 - _squad1: %4 - _squad2: %5 - _squad3: %6 - _squad4: %7 - _vehtospawn: %8 - _building_ai_max: %9", (markerText _sector), _sector, _infsquad, (count _squad1), (count _squad2), (count _squad3), (count _squad4), (count _vehtospawn), _building_ai_max], "SECTORSPAWN"] remoteExecCall ["KPLIB_fnc_log", 2];};

    if (_building_ai_max > 0 && GRLIB_adaptive_opfor) then {
        _building_ai_max = round (_building_ai_max * ([] call KPLIB_fnc_getOpforFactor));
    };
    _g = createGroup [GRLIB_side_enemy, true];
    {
        _vehicle= objNull;
        if ( _sector in sectors_lightArtillery ||  _sector in sectors_heavyArtillery || _sector in sectors_SAM ) then {
            _vehicle = [_sectorpos, _x,false,true,_g] call KPLIB_fnc_spawnVehicle;
            _vehicle allowCrewInImmobile true;
            _vehicle setFuel 0;
        }else{
            _vehicle = [_sectorpos, _x] call KPLIB_fnc_spawnVehicle;
            [group ((crew _vehicle) select 0),_sectorpos] spawn add_defense_waypoints;
            
        };
        _managed_units pushback _vehicle;
        {_managed_units pushback _x;} foreach (crew _vehicle);
        if ((_vehicle isKindOf "Tank")|| (_vehicle isKindOf "Car")) then {
                    if (typeOf _vehicle in  militia_vehicles) then {
                        _vehicle forceFlagtexture opfor_flag_militia_texture;
                    } else {
                        _vehicle forceFlagtexture opfor_flag_texture;
                    };
        };

        sleep 0.25;
    } forEach _vehtospawn;
    
    

    if (_building_ai_max > 0) then {
        _largestB = objNull;
        _largestBPos = 0;
        _allbuildings = (nearestObjects [_sectorpos, ["House"], _building_range]) select {alive _x};
        _buildingpositions = [];
        {
            _thisBuildingpositions = ([_x] call BIS_fnc_buildingPositions);
            _buildingpositions = _buildingpositions + _thisBuildingpositions;
            _thisBuildingpositionsCount = count _thisBuildingpositions;
            if (_thisBuildingpositionsCount > _largestBPos) then {
                _largestBPos =  _thisBuildingpositionsCount;
                _largestB = _x;
            };
        } forEach _allbuildings;
        if !(isNull _largestB) then {
            _largestbuildingpositions =  ([_largestB] call BIS_fnc_buildingPositions);
            _buildingpositions = _buildingpositions-_largestbuildingpositions;
            _largestbuilding_top_positions = [_largestbuildingpositions] call KPLIB_fnc_getBuildingRooftopPositions;
            _largestbuildingpositions = _largestbuildingpositions-_largestbuilding_top_positions;
            
            _grp = createGroup [GRLIB_side_enemy, true];
            _officer_pos = selectRandom _largestbuildingpositions;
            _unit = [opfor_officer, _officer_pos , _grp] call KPLIB_fnc_createManagedUnit;
            _unit setDir (random 360);
            _unit setPos _officer_pos;
            [_unit, _sector] spawn building_defence_ai;
            _managed_units = _managed_units + [_unit];
            _largestbuildingpositions =_largestbuildingpositions- [_officer_pos];
            _grp = createGroup [GRLIB_side_enemy, true];
            _managed_units = _managed_units + ([_infsquad,count  _largestbuildingpositions, _largestbuildingpositions, _sector,_grp] call KPLIB_fnc_spawnBuildingSquad);
            {
                [_x, _sector] spawn building_defence_ai;
            } forEach units _grp;
            _largestB setVariable ["bis_disabled_Door_1", 1, true];

        };

        _top_positions = [_buildingpositions] call KPLIB_fnc_getBuildingRooftopPositions;
        _buildingpositions = _buildingpositions-_top_positions;
        if (KP_liberation_sectorspawn_debug > 0) then {[format ["Sector %1 (%2) - manage_one_sector found %3 building positions", (markerText _sector), _sector, (count _buildingpositions)], "SECTORSPAWN"] remoteExecCall ["KPLIB_fnc_log", 2];};
        if (count _buildingpositions > _minimum_building_positions) then {
            _managed_units = _managed_units + ([_infsquad, _building_ai_max , _buildingpositions, _sector] call KPLIB_fnc_spawnBuildingSquad);
        };

        if (count _top_positions > 0) then {
            _g = createGroup [GRLIB_side_enemy, true];
            _top_positions = [_top_positions] call CBA_fnc_Shuffle;
            for "_i" from 0 to ((count _top_positions) min 3) do { 

                _gun = selectRandom (opfor_static_guns  - opfor_heavy_static_guns);
                _emptypos = selectRandom _top_positions;        
                if (count _emptypos > 1 ) then {
                    _vehicle = [ [_emptypos select 0 , _emptypos select 1 ,(_emptypos select 2) +1.5] , _gun ,true,true,_g] call KPLIB_fnc_spawnVehicle;
                    _vehicle allowCrewInImmobile true;
                    _managed_units pushback _vehicle;
                    {_managed_units pushback _x;} foreach (crew _vehicle);
                    sleep 1;

                    _vehicle setPosATL [ (getPosATL _vehicle) select 0 , (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1]; 
                    _vehicle setVectorUp surfaceNormal position _vehicle;
                    _top_positions = _top_positions- [_emptypos];
                };
            };
            for "_i" from 0 to ((count _top_positions) min 3) do { 
                _gun = selectRandom ( opfor_AT_static_guns - opfor_heavy_static_guns);
                _emptypos = selectRandom _top_positions;        
                if (count _emptypos > 1 ) then {
                    _vehicle = [ [_emptypos select 0 , _emptypos select 1 ,(_emptypos select 2) +1.5] , _gun ,true,true,_g] call KPLIB_fnc_spawnVehicle;
                    _vehicle allowCrewInImmobile true;
                    _managed_units pushback _vehicle;
                    {_managed_units pushback _x;} foreach (crew _vehicle);
                    sleep 1;

                    _vehicle setPosATL [ (getPosATL _vehicle) select 0 , (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1]; 
                    _vehicle setVectorUp surfaceNormal position _vehicle;
                    _top_positions = _top_positions- [_emptypos];
                };
            };
        };

        for "_i" from 0 to 2 do { 
                _gun = selectRandom (opfor_static_guns arrayIntersect opfor_heavy_static_guns);
                _emptypos = _sectorpos findEmptyPosition [5,_building_range,_gun];
                _gun = selectRandom (opfor_static_guns arrayIntersect opfor_heavy_static_guns); 
                _rndpos = [[[_sectorpos,_building_range]],[]] call BIS_fnc_randomPos;
                _emptypos= _rndpos findEmptyPosition [0,30,_gun];
                if (count _emptypos > 1 ) then {
                    _vehicle = [ [_emptypos select 0 , _emptypos select 1 ,(_emptypos select 2) +1.5] , _gun ,true,true,_g] call KPLIB_fnc_spawnVehicle;
                    _vehicle allowCrewInImmobile true;
                    _managed_units pushback _vehicle;
                    {_managed_units pushback _x;} foreach (crew _vehicle);
                    _vehicle setDir ((_vehicle getRelDir _sectorpos) - 180);
                    sleep 1;
                    _vehicle setPosATL [ (getPosATL _vehicle) select 0 , (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1]; 
                    _vehicle setVectorUp surfaceNormal position _vehicle;
                    
                };
        };
        
        _num = ceil(_building_ai_max*0.4) min (count _top_positions);
        _managed_units = _managed_units + ([_infsquad,_num  , _top_positions, _sector] call KPLIB_fnc_spawnBuildingSquad);
    };

    _managed_units = _managed_units + ([_sectorpos] call KPLIB_fnc_spawnMilitaryPostSquad);

    if (count _squad1 > 0) then {
        _grp = [_sector, _squad1] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _managed_units = _managed_units + (units _grp);
    };

    if (count _squad2 > 0) then {
        _grp = [_sector, _squad2] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _managed_units = _managed_units + (units _grp);
    };

    if (count _squad3 > 0) then {
        _grp = [_sector, _squad3] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _managed_units = _managed_units + (units _grp);
    };

    if (count _squad4 > 0) then {
        _grp = [_sector, _squad4] call KPLIB_fnc_spawnRegularSquad;
        [_grp, _sectorpos] spawn add_defense_waypoints;
        _managed_units = _managed_units + (units _grp);
    };

    if (_spawncivs && GRLIB_civilian_activity > 0) then {
        _managed_units = _managed_units + ([_sector] call KPLIB_fnc_spawnCivilians);
    };

    if (KP_liberation_asymmetric_debug > 0) then {[format ["Sector %1 (%2) - Range: %3 - Count: %4", (markerText _sector), _sector, _building_range, _iedcount], "ASYMMETRIC"] remoteExecCall ["KPLIB_fnc_log", 2];};
    [_sector, _building_range, _iedcount] spawn ied_manager;

    if (_guerilla) then {
        [_sector] spawn sector_guerilla;
    };

    sleep 10;

    if ((_sector in sectors_factory) || (_sector in sectors_capture) || (_sector in sectors_bigtown) || (_sector in sectors_military)) then {
        [_sector] remoteExec ["reinforcements_remote_call",2];
    };

    if (KP_liberation_sectorspawn_debug > 0) then {[format ["Sector %1 (%2) - populating done", (markerText _sector), _sector], "SECTORSPAWN"] remoteExecCall ["KPLIB_fnc_log", 2];};

    private _activationTime = time;
    private _isFleeing = false;
    private _orginalUnitcount = GRLIB_side_enemy countSide  (_managed_units select {
        alive _x && !(_x getVariable["ACE_isUnconscious", false]) && !(captive _x)
        });
    

    //set flee count
    private _fleeCount = 0;
    if ( _sector in sectors_lightArtillery || _sector in sectors_SAM) then {
        _fleeCount = selectRandom [0,0,0,0,0,1,1,1,1,2];
    } else {
        _fleeCount = (ceil(_orginalUnitcount * 0.05) max 1) min 5 ;
    };
    if (_sector in sectors_heavyArtillery ) then {
        _fleeCount = 0 ;
    };


    // sector lifetime loop
    while {!_stopit} do {
        
        _sector_alive_devices = [];

        //check if all radars/launchers destroyed 
        if (_sector in sectors_SAM ) then {
            _sector_alive_devices append (_managed_units select {
                alive _x 
                && (toLower (typeof _x)) in (opfor_SAM apply {toLower (_x select 0)}) 
            });
            _sector_alive_devices append (_managed_units select {
                alive _x 
                && (toLower (typeof _x)) in (opfor_SAM apply {toLower (_x select 1)}) 
            });
        };

         //check if artillery destroyed
        if (_sector in sectors_heavyArtillery || _sector in sectors_lightArtillery) then {
            _sector_alive_devices append (_managed_units select {
                alive _x 
                && (toLower (typeof _x)) in (opfor_heavy_artillery apply {toLower (_x)}) 
            });
            _sector_alive_devices append (_managed_units select {
                alive _x 
                && (toLower (typeof _x)) in (opfor_light_artillery apply {toLower (_x)}) 
            });
        };
        
        _unitcount =   GRLIB_side_enemy countSide  (_managed_units select {
        alive _x && !(_x getVariable["ACE_isUnconscious", false]) && !(captive _x)
        });
        if (_fleeCount >= _unitcount ) then {
            _isFleeing= true;
            {
                if (_x isKindOf "Man" && !(captive _x)  && (side group _x )== GRLIB_side_enemy) then {
                    [_x,_sector] call KPLIB_fnc_makeUnitFlee;
                };
                
            } forEach _managed_units;
        };
        
        // sector was captured
        if ((count _sector_alive_devices) == 0 && ([_sectorpos, _local_capture_size] call KPLIB_fnc_getSectorOwnership == GRLIB_side_friendly) && (GRLIB_endgame == 0)) then {
            if (isServer) then {
                [_sector] spawn sector_liberated_remote_call;
            } else {
                [_sector] remoteExec ["sector_liberated_remote_call",2];
            };

            _stopit = true;

            {[_x] spawn prisonner_ai;} forEach ((markerPos _sector) nearEntities [["Man"], _local_capture_size * 1.2]);

            sleep 60;

            active_sectors = active_sectors - [_sector]; publicVariable "active_sectors";

            sleep 600;

            {
                if (_x isKindOf "Man") then {
                    if (side group _x != GRLIB_side_friendly) then {
                        deleteVehicle _x;
                    };
                } else {
                    if (!isNull _x) then {
                        [_x] call KPLIB_fnc_cleanOpforVehicle;
                    };
                };
            } forEach _managed_units;
        } else {
            if (!(_sector in sectors_forced_spawn) && ([_sectorpos, (([_opforcount] call KPLIB_fnc_getSectorRange) + 300), GRLIB_side_friendly,_sector] call KPLIB_fnc_getUnitsCount) == 0) then {
                _sector_despawn_tickets = _sector_despawn_tickets - 1;
            } else {
                // start counting running minutes after ADDITIONAL_TICKETS_DELAY
                private _runningMinutes = (floor ((time - _activationTime) / 60)) - ADDITIONAL_TICKETS_DELAY;
                private _additionalTickets = (_runningMinutes * BASE_TICKETS);

                // clamp from 0 to "_maximum_additional_tickets"
                _additionalTickets = (_additionalTickets max 0) min _maximum_additional_tickets;

                _sector_despawn_tickets = BASE_TICKETS + _additionalTickets;
            };

            if ((_sector_despawn_tickets <= 0)||(_sector in sectors_forced_despawn && !(_sector in sectors_forced_spawn))) then {
                {
                    if (_x isKindOf "Man") then {
                        deleteVehicle _x;
                    } else {
                        if (!isNull _x) then {
                            [_x] call KPLIB_fnc_cleanOpforVehicle;
                        };
                    };
                } forEach _managed_units;

                _stopit = true;
                active_sectors = active_sectors - [_sector]; publicVariable "active_sectors";
            };
        };
        sleep SECTOR_TICK_TIME;
    };
} 
else {
    sleep 40;
    active_sectors = active_sectors - [_sector]; publicVariable "active_sectors";
};

[format ["Sector %1 (%2) deactivated - Was managed on: %3", (markerText _sector), _sector, debug_source], "SECTORSPAWN"] remoteExecCall ["KPLIB_fnc_log", 2];
