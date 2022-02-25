// [_this] call AI_Artillery_fnc_requestHEFire

params["_caller"];

_callerSide = side _caller;
_friendlyUnits = allUnits select {
    ([(side _x), _callerSide] call BIS_fnc_sideIsFriendly)
};

_allEnemyTargets = allUnits select {
    _enemyUnit = _x;
    	alive _x &&
		!(_x getVariable['ACE_isUnconscious', false]) && 
		!(_x getVariable['ace_captives_isHandcuffed', false]) &&
        !([(side _enemyUnit), _callerSide] call BIS_fnc_sideIsFriendly) &&
        _caller knowsAbout _x > 1 &&
        _caller distance _x < 1800 &&
        ({
                _enemyUnit distance _x < 300
            }
            count _friendlyUnits) == 0

};

_furtherstEnemy = [_allEnemyTargets, [_caller], {
    _input0 distance _x
}, "DESCEND"] call BIS_fnc_sortBy;

_atr = [getpos _caller, _callerSide, 4000, "HE"] call AI_Artillery_fnc_getAvailableArtillery;


if (!isnil "commandant") then {
    (format ["%1 target with %2 HE Artillery found", str count _furtherstEnemy, str count _atr]) remoteExec ["systemChat",commandant];
};
_old_targets = _caller getVariable["FO_Targets", createHashMap];
_barrageAmmount = ceil(3 + random 3);
_targetFound = false; 
{
	_target = _x; 
	_tpos = _caller getHideFrom _target;
	_Tdata = [];
	if ((netId _target) in _old_targets) then {
		_Tdata = _old_targets get(netId _target);
	} else {
		_Tdata = [_tpos, 1, 0];
	};
	_Tdata params[["_lastFirePos", _tpos], ["_accuracy", 1], ["_times", 0]];
	_distance = _tpos distance _lastFirePos;
	switch (true) do {
		case (_distance <= 10 ):{
				_times = _times + 1;
				_accuracy = (_accuracy + (((_caller knowsAbout _target) * _times)*2)) min 100;
			};
		case (_distance <= 50 && _distance > 10):{
				_times = _times + 1;
				_accuracy = (_accuracy + (((_caller knowsAbout _target) * _times))) min 100;
			};
		case (_distance <= 100 && _distance > 50):{
				_times = _times + 1;
				_accuracy = (_accuracy + (((_caller knowsAbout _target) * _times) / 2)) min 100;
			};
		case (_distance <= 200 && _distance > 100):{
				_times = _times + 1;
				_accuracy = (_accuracy + (((_caller knowsAbout _target) * _times) / 3)) min 100;
			};
		case (_distance > 200):{
				_accuracy = 1;
				_times = 0;
			};
	};

	_minDist = 0;
	_maxDist = 0;
	switch (true) do {
		case (_accuracy <= 10 && _accuracy > 0):{
				_minDist = 90;
				_maxDist = 140;
			};
		case (_accuracy <= 20 && _accuracy > 10):{
				_minDist = 80;
				_maxDist = 120;
			};
		case (_accuracy <= 30 && _accuracy > 20):{
				_minDist = 70;
				_maxDist = 110;
			};
		case (_accuracy <= 40 && _accuracy > 30):{
				_minDist = 60;
				_maxDist = 100;
			};
		case (_accuracy <= 50 && _accuracy > 40):{
				_minDist = 50;
				_maxDist = 90;
			};
		case (_accuracy <= 60 && _accuracy > 50):{
				_minDist = 35;
				_maxDist = 80;
			};
		case (_accuracy <= 70 && _accuracy > 60):{
				_minDist = 25;
				_maxDist = 70;
			};
		case (_accuracy <= 80 && _accuracy > 70):{
				_minDist = 15;
				_maxDist = 60;
			};
		case (_accuracy <= 90 && _accuracy > 80):{
				_minDist = 10;
				_maxDist = 50;
			};
		case (_accuracy <= 100 && _accuracy > 90):{
				_minDist = 0;
				_maxDist = 30;
			};
	};

	{
        if !(_targetFound) then {
            _r = [_x select 0, _x select 1, _target, "HE", _barrageAmmount] call AI_Artillery_fnc_canFireOnTarget;
            if (count _r > 2) then {
				_old_targets set[(netId _target), [_tpos, _accuracy, _times]];
				if (!isnil "commandant") then {
    				(format["%1 vehicles firing %3 barrage on %2 with acc %4 (%5-%6)", count _r, name _target, str _barrageAmmount, str _accuracy, str _minDist, str _maxDist]) remoteExec ["systemChat",commandant];
				};
				for "_i"
        		from 0 to 10 do {
					_caller playActionNow "HandSignalRadio";
					sleep 2;
        		};
			
				if (!(captive _caller) && !(_caller getVariable['ACE_isUnconscious', false]) && !(_caller getVariable['ace_captives_isHandcuffed', false])) then {
					[_r, _tpos, _minDist, _maxDist, _barrageAmmount, "HE"] call AI_Artillery_fnc_fireArtillery;
				};
                _targetFound = true;
            };

        };
    }
    forEach _atr;
}
forEach _furtherstEnemy;

_caller setVariable["FO_Targets", _old_targets];

_targetFound