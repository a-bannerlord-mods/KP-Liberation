
params ["_taskId","_objectsToCapture","_failOnKilledObjectsCount","_handoverLocation"];

{
	// Current result is saved in variable _x
	_x setVariable ["orginal_location",getPos _x,true];
	[_x,_handoverLocation] spawn {
		params ["_unit","_handoverLocation"];
		waitUntil {!(_unit getVariable ['ace_captives_isHandcuffed', true])};
		_unit setVariable ["objective_resued",true,true];

		waitUntil {(_unit distance  _handoverLocation ) < 60 };
		_unit setVariable ["objective_delivered",true,true];

	};
} forEach _objectsToCapture;



waitUntil {count (_objectsToCapture select {alive _x && !(_x getVariable ["objective_delivered",false]) }) ==0 };

if (count (_objectsToCapture select {!alive _x}) >= _failOnKilledObjectsCount) then {
	// fail
	[_taskId, "FAILED"] call BIS_fnc_taskSetState;
} else {
	// success
	[_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
};