//[_this] spawn AI_Artillery_fnc_initFO
params["_FO"];
waitUntil { !isnil "AI_Artillery_enable" };
while {alive _FO} do {
	waitUntil { AI_Artillery_enable &&!(captive _FO) && !(_FO getVariable['ACE_isUnconscious', false]) && !(_FO getVariable['ace_captives_isHandcuffed', false])};
	_sleeptime =20;

	if !(isNil "IsNightTime") then {
		if (IsNightTime) then {
			_success = [_FO] call AI_Artillery_fnc_requestFlareFire;
			if (_success) then {
				_sleeptime = _sleeptime + 10;
			};
		};
	};
	_success= [_FO] call AI_Artillery_fnc_requestSmokeFire;
	if (_success) then {
		_sleeptime = _sleeptime + 15;
	};
	_success= [_FO] call AI_Artillery_fnc_requestHEFire;
	if (_success) then {
		_sleeptime = _sleeptime + 30;
	};


	sleep _sleeptime;
};

