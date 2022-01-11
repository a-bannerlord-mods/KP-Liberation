params[
    "_id",
    "_sector",
    "_type",
    "_title",
    "_description",
    "_objectiveParams",
    "_init_unit",
    "_condition",
    "_onsucess",
    "_onfail",
    "_onsucesseffect",
    "_onfaileffect",
    "_largestB",
    "_largestbuildingpositions", 
    "_cached_objectives"
];

_HVT_class=_objectiveParams select 0;
_HVT_Name = _objectiveParams select 1;
_bodyguard_classess= _objectiveParams select 2;
_convoy_cars=_objectiveParams select 3;

_managed_units = [];
_grp = createGroup[GRLIB_side_enemy, true];
_officer_pos = selectRandom _largestbuildingpositions;

if (count _cached_objectives > 0 ) then {
    {
        _x enableSimulation true;
        _x hideObjectGlobal false;
        _x hideObject false;
        _managed_units = _managed_units + [_x];
    } forEach _cached_objectives;
} else {
     //createUnit 
    _unit = [_HVT_class, _officer_pos, _grp] call KPLIB_fnc_createManagedUnit;
    _unit setDir(random 360);
    _unit setPos _officer_pos;

    [_unit,_init_unit,_HVT_Name] spawn {
        params ["_unit","_init_unit","_HVT_Name"];
        sleep 2;
        _unit setName[_HVT_Name, _HVT_Name, ""];
        _unit call _init_unit;
        [_unit] call KPLIB_fnc_applyCustomUnitSettings;
    };


    _unit setUnitPos "UP";
    _unit disableAI "PATH";
    [_id,[_unit],1,getPos startbase] spawn KPLIB_fnc_rescueObjective;
    _unit setVariable ["is_objective",true,true];
    _managed_units = _managed_units + [_unit];

};


if (count _convoy_cars > 0) then {
    _nearestRoad = [getPosATL _largestB, 500] call BIS_fnc_nearestRoad;
    _info = getRoadInfo _nearestRoad;
    _dir = (_info select 6) getDir(_info select 7);
    if (!isnull _nearestRoad) then {
        {
            _officer_vehicle = [((getPosATL _nearestRoad) getPos[10 * _foreachindex, _dir]), _x, true] call KPLIB_fnc_spawnVehicle;
            _managed_units pushback _officer_vehicle;

            {
                [_x, _sector] spawn building_defence_ai;
                _managed_units pushback _x;
            }
            foreach(crew _officer_vehicle);

            _officer_vehicle setdir _dir;
            _officer_vehicle forceFlagtexture opfor_flag_texture;
        }
        forEach _convoy_cars;
    };
};


_grp = createGroup[GRLIB_side_enemy, true];

if (count _bodyguard_classess > 0 ) then {
    _managed_units = _managed_units + (['army', count _largestbuildingpositions, _largestbuildingpositions, _sector, _grp,_bodyguard_classess] call KPLIB_fnc_spawnBuildingSquad);
} else {
    _managed_units = _managed_units + (['army', count _largestbuildingpositions, _largestbuildingpositions, _sector, _grp] call KPLIB_fnc_spawnBuildingSquad);
};


{
    [_x,_init_unit] spawn {
        params ["_unit","_init_unit"];
        sleep 2;
        _unit call _init_unit;
    };
    [_x, _sector] spawn building_defence_ai;
}
forEach units _grp;

private _numberofdoors = getNumber(configFile >> "CfgVehicles" >> (typeOf _largestB) >> "numberOfDoors");
if (_numberofdoors != -1 and _numberofdoors != 0) then {
    for "_i"
    from 1 to _numberOfDoors do {
        _largestB animate[format["door_%1_rot", _i], 0];
        _largestB setVariable[format["bis_disabled_Door_%1", _i], 1, true];
    };
};

_managed_units