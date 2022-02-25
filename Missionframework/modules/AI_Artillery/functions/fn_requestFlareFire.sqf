// [_this] call AI_Artillery_fnc_requestHEFire

params["_caller"];

_callerSide = side _caller;


_allEnemyTargets = allUnits select {
    _enemyUnit = _x;
    	alive _x &&
		!(_x getVariable['ACE_isUnconscious', false]) && 
		!(_x getVariable['ace_captives_isHandcuffed', false]) &&
        !([(side _enemyUnit), _callerSide] call BIS_fnc_sideIsFriendly) &&
        _caller knowsAbout _x > 0.5 &&
        _caller distance _x < 1800 
};

_furtherstEnemy = _allEnemyTargets call BIS_fnc_arrayShuffle ;

_atr = [getpos _caller, _callerSide, 4000, "FLARE"] call AI_Artillery_fnc_getAvailableArtillery;

if (!isnil "commandant") then {
    (format ["%1 target with %2 Flare Artillery found", str count _furtherstEnemy, str count _atr]) remoteExec ["systemChat",commandant];
};
_barrageAmmount = ceil(2 + random 2);
_targetFound = false; 
{
	_target = _x; 
	_tpos = _caller getHideFrom _target;
	_minDist = 0;
	_maxDist = 30;
	{
        if !(_targetFound) then {
            _r = [_x select 0, _x select 1, _target, "FLARE", _barrageAmmount] call AI_Artillery_fnc_canFireOnTarget;
            if (count _r > 0) then {
				if (!isnil "commandant") then {
    				(format["%1 vehicles firing Flares %3 barrage on %2", count _r, name _target, str _barrageAmmount]) remoteExec ["systemChat",commandant];
				};

				for "_i"
        		from 0 to 4 do {
					_caller playActionNow "HandSignalRadio";
					sleep 2;
        		};
			
				if (!(captive _caller) && !(_caller getVariable['ACE_isUnconscious', false]) && !(_caller getVariable['ace_captives_isHandcuffed', false])) then {
					[_r, _tpos, _minDist, _maxDist, _barrageAmmount, "FLARE"] call AI_Artillery_fnc_fireArtillery;
				};
                _targetFound = true;
            };

        };
    }
    forEach _atr;
}
forEach _furtherstEnemy;

_targetFound