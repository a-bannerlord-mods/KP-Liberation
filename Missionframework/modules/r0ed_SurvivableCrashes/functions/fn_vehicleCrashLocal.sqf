params ["_unit"];
_medicalSystem = missionNamespace getVariable "r0ed_SurvivableCrashesVar_MedicalSystem";
_visualEffectsEnabled = missionNamespace getVariable "r0ed_SurvivableCrashesVar_VisualEffectsEnabled";
_damageMultiplier = missionNamespace getVariable "r0ed_SurvivableCrashesVar_CrewDamageMultiplier";
_crewPostCrashCode = missionNamespace getVariable "r0ed_SurvivableCrashesVar_CrewPostCrashCode";

switch (_medicalSystem) do {
    case "ACE": { 	
		[_unit, 0.5] call ace_medical_fnc_adjustPainLevel;
		//[_unit, true, 30 + random 10] call ace_medical_fnc_setUnconscious;
		_unit allowDamage false;		
	};
    case "VANILLA": { _unit allowDamage false;};
	case "LIMIT_DAMAGE": { _unit allowDamage false;};
    default {};
};
// if (_visualEffectsEnabled && _unit == player) then {
// 	[] call r0ed_fnc_crashVisualEffects;
// };

[_unit, _medicalSystem, _damageMultiplier, _crewPostCrashCode] spawn {
    params ["_unit", "_medicalSystem", "_damageMultiplier", "_crewPostCrashCode"];

	waitUntil {
		sleep 1;
		_alt = getPosATL _unit select 2;
		_alt < 10 
	};

	switch (_medicalSystem) do {
		case "ACE": { 	
			_unit allowDamage true;
			[_unit, true] call ace_medical_fnc_setUnconscious;
			{
				_cause = ["vehiclecrash", "explosive"] select (round random 1);
				[_unit, _damageMultiplier * random [.3, .7, 1], _x, _cause] call ace_medical_fnc_addDamageToUnit;
				sleep .1;
			} forEach ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
			
			sleep .011;
			_unit allowDamage false;

		};
		case "VANILLA": {
			_unit setDamage (.8 * _damageMultiplier);
            sleep 5;
            _unit allowDamage true;
		};
		case "LIMIT_DAMAGE": { _unit allowDamage true;};
        default {};
    };

	waitUntil {
		sleep 1;
		_alt = getPosATL _unit select 2;
		_speed = vectorMagnitude velocity _unit;
		_alt < 2 && _speed < 1
	};
	_unit action ["eject", vehicle _unit];
	if (vehicle _unit != _unit) then {
		moveOut _unit;
	};
	_unit switchMove "";
	_unitVelocity = velocity _unit;
	_unit setVelocity [0,0,0];

	sleep 5;
	_unit allowDamage true;

	waitUntil{sleep 1; isTouchingGround _unit};
	
    [_unit] spawn _crewPostCrashCode;
};
