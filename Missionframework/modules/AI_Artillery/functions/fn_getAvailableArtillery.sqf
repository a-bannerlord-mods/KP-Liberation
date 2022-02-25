
params [
    ["_pos", [0, 0, 0], [[]], [2, 3]],
    ["_side", GRLIB_side_enemy, [sideEmpty]],
    ["_radius", 1000, [0]],
    ["_type",""]
];

_ARTYLST = []; 
{
	_group = _x;
    _lastFire = _group getVariable ["AI_Artillery_Last_Fire_" + _type,-1];
    if (time - _lastFire >= 60 || _lastFire == -1) then {
        _grpArt = [];
        {
            
            private _veh = (vehicle _x);
            if (alive _veh && ({alive _x && !(_x getVariable['ACE_isUnconscious', false])} count (crew _veh)) > 0) then {
                private _class = typeOf _veh;
                if !(isNil("_class")) then {
                    private _artyChk = getNumber(configfile / "CfgVehicles" / _class / "artilleryScanner");
                    if (_artyChk isEqualTo 1) then {
                        _grpArt pushback _veh;
                    };
                };

            };
        }
        foreach ((units _group) select { _pos distance2d _x < _radius });
        if (count _grpArt > 0) then {
            _ARTYLST pushBack [_group,_grpArt];
        };
    };
}forEach (AllGroups select {side _x == _side});

_ARTYLST