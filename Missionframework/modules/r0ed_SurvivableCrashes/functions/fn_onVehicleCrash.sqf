	params ["_veh","_HandleDamageEvent"];
	private ["_vehRestCode", "_sfxEnabled", "_exagEffectsEnabled"];
	_vehRestCode = missionNamespace getVariable "r0ed_SurvivableCrashesVar_VehicleRestCode";
	_sfxEnabled = missionNamespace getVariable "r0ed_SurvivableCrashesVar_SoundEffectsEnabled";
	_exagEffectsEnabled = missionNamespace getVariable "r0ed_SurvivableCrashesVar_ExaggeratedEffectsEnabled";
	_onCrashCode = missionNamespace getVariable "r0ed_SurvivableCrashesVar_OnCrashCode";

	_veh setFuel .2 + (random 10)/100;
	//_veh setDamage .88;

	_hitparts = (getAllHitPointsDamage _veh) select 0;

	{
		if ((tolower _x) in (["HitHRotor","HitVRotor","HitEngine","HitEngine2"] apply {toLower _x}) ) then {
			_veh setHitPointDamage [_x,.89 + (random 10)/100 ];
		} else {
			_veh setHitPointDamage [_x, .5 + (random 30)/100];
		};
	} forEach _hitparts;

	// _veh setHitPointDamage ["HitHRotor",.88];
	// _veh setHitPointDamage ["HitVRotor",.88];
	// _veh setHitPointDamage ["HitEngine",.88];
	_veh allowDamage false;

	_fire = objNull;
	if(_exagEffectsEnabled) then {
		_fire = createVehicle ["test_EmptyObjectForFireBig", position _veh, [], 0, "CAN_COLLIDE"];
		_fire attachTo [_veh,[0,0.0,0.0],"motor"];
	} else {
		_fire = createVehicle ["test_EmptyObjectForSmoke", position _veh, [], 0, "CAN_COLLIDE"];
		_fire attachTo [_veh,[0,0.0,0.0],"motor"];
	};

	[_veh, _sfxEnabled, _exagEffectsEnabled, _vehRestCode, _fire] spawn {
		params ["_veh","_sfxEnabled", "_exagEffectsEnabled",  "_vehRestCode", "_fire"];
		private ["_velocityVehPrev"];
		// if (_sfxEnabled) then {
		// 	[_veh] remoteExec ["r0ed_SurvivableCrashes_PlaySfx", -2];
		// };
		// _velocityVeh = vectorMagnitude velocity _veh;
		// waitUntil{
		// 	_velocityVehPrev = _velocityVeh;
		// 	_velocityVeh = vectorMagnitude velocity _veh;
		// 	isTouchingGround _veh
		// };
		// if(_exagEffectsEnabled) then {
		// 	[_veh,_velocityVehPrev] call {
		// 	    params ["_veh", "_aproxVel"];
				
		// 		_velocityVeh = velocity _veh;
		// 		_dir = (_velocityVeh select 0) atan2 (_velocityVeh select 1);
		// 		_speed = 4 + random 2;
				
		// 		_velocityVeh = [(sin _dir) * _speed * sqrt abs(_velocityVeh select 0),
		// 			(cos _dir) * _speed * sqrt abs(_velocityVeh select 1),
		// 			(1 + random 4) * sqrt(abs(_aproxVel)) + .4 ]; // being tested - post 1.2.1
		// 		_veh setVelocity _velocityVeh;
		// 	};
		//};
		waitUntil {
			sleep 1; _totalSpeed = vectorMagnitude velocity _veh;
			_totalSpeed < 1;
		};

		//[_veh, _velocityVehPrev] call _vehRestCode;
		[_veh, vectorMagnitude velocity _veh] call _vehRestCode;
		if(!(isNull _fire)) then {
			[_fire,_veh] spawn {
				params ["_fire","_veh"];
				// delete fire
				_fire addMPEventHandler ["MPKilled", {
					_this = _this select 0;
					{
						deleteVehicle _x;
					} forEach (_this getVariable ["effects", []]);
					if (isServer) then {
						deleteVehicle _this;
					};
				}];
				waitUntil {
					sleep 5;
					(isNull _veh)  || ((((getAllHitPointsDamage _veh) select 2) select { _x > 0  }) call BIS_fnc_arithmeticMean) <0.25
				};
				_fire setDamage 1;
			};
		};
	};
	{
		[_x] remoteExecCall ["r0ed_fnc_vehicleCrashLocal", _x];
	} forEach crew _veh;

	[_veh, _HandleDamageEvent] spawn _onCrashCode;