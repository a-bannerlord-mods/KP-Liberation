// [_this] call AI_Artillery_fnc_requestHEFire

params["_caller"];

_callerSide = side _caller;
_grp =  group _caller;
_wp = currentWaypoint _grp;
_wppos = getWPPos [_grp,_wp];

// _friendlyUnits = allUnits select {
//     ([(side _x), _callerSide] call BIS_fnc_sideIsFriendly)
// };

_allEnemyTargets = allUnits select {
    _enemyUnit = _x;
    alive _x &&
        !([(side _enemyUnit), _callerSide] call BIS_fnc_sideIsFriendly) &&
        _caller knowsAbout _x > 2 &&
        _caller distance _x < 1800 &&
        // ({
        //         _enemyUnit distance _x < 300
        //     }
        //     count _friendlyUnits) == 0
        _wppos distance _x < 100 
};

_furtherstEnemy = [_allEnemyTargets, [_caller], {
    _input0 distance _x
}, "DESCEND"] call BIS_fnc_sortBy;

_atr = [getpos _caller, _callerSide, 4000, "SMOKE"] call AI_Artillery_fnc_getAvailableArtillery;
_artVeh = [];
_artAmmo = "";

if (!isnil "commandant") then {
    (format["%1 target with %2 Smoke Artillery found", str count _furtherstEnemy, str count _atr]) remoteExec ["systemChat",commandant];
};


_barrageAmmount = ceil(5 + random 5);
_targetFound = false; 
_minDist = 0;
_maxDist = 10;
{
_target = _x; 
	{
        _tpos = _caller getHideFrom _target;
        _reldir =  180 + ( _tpos getDir  _tpos);
        _dis = _caller distance _tpos;
        _smokePos = _caller getPos [_dis/1.5,_reldir];
        if !(_targetFound) then {
            _r = [_x select 0, _x select 1, _target, "SMOKE", _barrageAmmount] call AI_Artillery_fnc_canFireOnTarget;
            if (count _r > 0) then {
                if (!isnil "commandant") then {
                    (format["%1 vehicles firing %3 smoke barrage between caller and %2", count _r, name _target, str _barrageAmmount]) remoteExec ["systemChat",commandant];
                };
                [_r, getpos _caller, 0, 0, 1, "SMOKE"] call AI_Artillery_fnc_fireArtillery;
                [_r, _smokePos, _minDist, _maxDist, _barrageAmmount -1, "SMOKE"] call AI_Artillery_fnc_fireArtillery;
                _targetFound = true;
            };

        };
    }
    forEach _atr;
}
forEach _furtherstEnemy;

_targetFound