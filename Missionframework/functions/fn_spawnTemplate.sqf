params ["_template","_pos","_dir",["_dirOffset",0],["_onnearestRoad",false],["_side",west]];
_objects = [];

if (_onnearestRoad) then {
    _nearestRoad = [_pos, 99999] call BIS_fnc_nearestRoad;
    if (!isnull _nearestRoad) then 
    {
        _info = getRoadInfo _nearestRoad;
        _dir = (_info select 6) getDir(_info select 7);
        _pos = getpos _nearestRoad;
    };
};


_objs = [_pos, _dir + _dirOffset , _template] call BIS_fnc_ObjectsMapper;
_grpFriendly = createGroup GRLIB_side_friendly;
_grpEnemy = createGroup GRLIB_side_enemy;
{
    _unit = _x;
    switch (typeof _unit) do {
        case "Sign_Arrow_Blue_F": { 
            _funit = [(selectRandom infantry_units) select 0, getpos _unit, _grpfriendly] call KPLIB_fnc_createManagedUnit;
            _funit disableAI "PATH";
            _funit spawn {
                sleep (random 5);
                [_this, "WATCH", "FULL"] call BIS_fnc_ambientAnimCombat;
            };		
            _objects pushBack _funit;
            deleteVehicle _unit;
        };
        case "Sign_Arrow_F": { 
            _class = selectRandom ([] call KPLIB_fnc_getSquadComp);
            _funit = [_class, getpos _unit, _grpEnemy] call KPLIB_fnc_createManagedUnit;
            _funit disableAI "PATH";
            // _funit spawn {
            //     sleep (random 5);
            //     [_this, "WATCH", "FULL"] call BIS_fnc_ambientAnimCombat;
            // };		
            _objects pushBack _funit;
            deleteVehicle _unit;
        };
        case "Sign_Arrow_Green_F": { 
            _funit = [(selectRandom infantry_units) select 0, getpos _unit, _grpfriendly] call KPLIB_fnc_createManagedUnit;
            _funit disableAI "PATH";
            _funit spawn {
                sleep (random 5);
                [_this, "WATCH", "FULL"] call BIS_fnc_ambientAnimCombat;
            };		
            _objects pushBack _funit;
            deleteVehicle _unit;
        };
        case "FlagCarrierWhite_EP1": {
            switch (_side) do {
                case GRLIB_side_friendly: { _unit forceFlagtexture blufor_flag_texture;_objects pushBack _unit; };
                case GRLIB_side_enemy: {_unit forceFlagtexture opfor_flag_texture; _objects pushBack _unit;};
                case GRLIB_side_resistance: {_unit forceFlagtexture guerilla_flag_texture; _objects pushBack _unit;};
                default { deleteVehicle  _unit;};
            };
            
        };
        case "ACE_IEDUrbanBig_Range": {
            _ied_type =  selectrandom opfor_military_AP_mine;
            _ied_obj = createVehicle [_ied_type, getpos _unit];
            _side revealMine _ied_obj;
            deleteVehicle _unit;
            _objects pushBack _ied_obj;
        }; 
        case "ACE_IEDLandBig_Range": {
            _ied_type =  selectrandom opfor_military_AP_mine;
            _ied_obj = createVehicle [_ied_type, getpos _unit];
            _side revealMine _ied_obj;
            deleteVehicle _unit;
            _objects pushBack _ied_obj;
        };
        case "Sign_1L_Noentry_EP1": {
            _unit allowDamage false;
            _objects pushBack _unit;
        }; 
        case "Land_CamoNetVar_NATO_EP1": {
            _unit allowDamage false;
            _objects pushBack _unit;
        }; 
        case "CamoNet_BLUFOR_F": {
            _unit allowDamage false;
            _objects pushBack _unit;
        };
        default {
            if !(_unit iskindof "man") then {
                    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
                    [_unit] call KPLIB_fnc_addObjectInit;
                    [_unit] call KPLIB_fnc_clearCargo;
                    if (tolower(typeof _unit) in KPLIB_b_allVeh_classes) then {
                        if (((_unit isKindOf "Tank") || (_unit isKindOf "Car")) && tolower(typeof _unit) != KP_liberation_civ_car_classname) then {
                                _unit forceFlagtexture blufor_flag_texture;
                            };
                            [_unit] call KPLIB_fnc_forceBluforCrew;	
                    }else{
                        if ((_unit isKindOf "Tank")|| (_unit isKindOf "Car")) then {
                                    if (typeOf _unit in  militia_vehicles) then {
                                        _unit forceFlagtexture opfor_flag_militia_texture;
                                    } else {
                                        _unit forceFlagtexture opfor_flag_texture;
                                    };
                            };
                            createVehicleCrew _unit;
                    };
                    
                    _objects pushBack _unit;
                    {
                        _objects pushBack _x;	
                        _x disableAI "PATH";
                        						
                    } forEach (crew _unit);	
                    _unit allowCrewInImmobile false;	
            };
        };
    };
    _unit setvectorUp surfaceNormal position _unit;
} forEach _objs;


_objects