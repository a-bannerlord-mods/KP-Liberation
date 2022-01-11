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

_objectsToDestory=_objectiveParams select 0;


_managed_units = [];

if (count _cached_objectives > 0 ) then {
    {
        _x enableSimulation true;
        _x hideObjectGlobal false;
        _x hideObject false;
        _managed_units = _managed_units + [_x];
    } forEach _cached_objectives;
} else {
    _managed_units = _managed_units + _objectsToDestory;
    {   
        _x setVariable ["is_objective",true,true];
        [_x,_init_unit] spawn {
            params ["_unit","_init_unit"];
            sleep 2;
            _unit call _init_unit;
        };
    } forEach _objectsToDestory;
    [_id,_objectsToDestory,3] spawn KPLIB_fnc_destroyObjective;
};
_managed_units