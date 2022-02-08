
params ["_taskId","_objectsToDestroy","_successOnKilledObjectsCount"];

waitUntil {count (_objectsToDestroy select {!alive _x }) >= _successOnKilledObjectsCount};

[_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
{
	_total_missions = _x getVariable ["total_missions",0];
	_x setVariable ["total_missions",_total_missions+1,true];
	[_x] call KPLIB_fnc_updatePlayerStats;
} forEach allPlayers;
KP_liberation_successful_objectives pushBackUnique  _taskId;
    
publicVariable "KP_liberation_successful_objectives";
