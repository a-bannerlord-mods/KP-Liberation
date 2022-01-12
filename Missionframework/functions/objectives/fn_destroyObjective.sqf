
params ["_taskId","_objectsToDestroy","_successOnKilledObjectsCount"];

waitUntil {count (_objectsToDestroy select {!alive _x }) >= _successOnKilledObjectsCount};

[_taskId, "SUCCEEDED"] call BIS_fnc_taskSetState;
KP_liberation_successful_objectives pushBackUnique  _taskId;
    
publicVariable "KP_liberation_successful_objectives";
