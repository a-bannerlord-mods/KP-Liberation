
waitUntil {!isNil "save_is_loaded"};
waitUntil {save_is_loaded};

{
	if ((_x select 0) in KP_liberation_failed_objectives || (_x select 0) in KP_liberation_successful_objectives) then {
		{
			deleteVehicle _x;
		} forEach ((_x select 5) select 0) ;
	}
	
	
} forEach (KP_Objectives select {(_x select 2) in ["destroy"] });

[west, ["main_task"], ["El Mamar" , "El Mamar",""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
{
	if (isnil "KP_liberation_successful_objectives") then {
		KP_liberation_successful_objectives = [];
	};

	if (isnil "KP_liberation_failed_objectives") then {
		KP_liberation_failed_objectives = [];
	};

	_status = "CREATED";
	switch (true) do {
		case ((_x select 0) in KP_liberation_successful_objectives): {
			_status = "SUCCEEDED";
		};
		case ((_x select 0) in KP_liberation_failed_objectives): {
			_status = "FAILED";
		};
	};
	[west, [_x select 0,"main_task"], [_x select 4 ,_x select 3,""], objNull, _status, 0, true] call BIS_fnc_taskCreate;
	
} forEach KP_Objectives;
