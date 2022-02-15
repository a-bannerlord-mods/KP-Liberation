r0ed_SurvivableCrashes_OnVehicleCrash = compile preprocessFileLineNumbers "modules\r0ed_SurvivableCrashes\functions\fn_onVehicleCrash.sqf";
r0ed_SurvivableCrashes_VehicleInit = compile preprocessFileLineNumbers "modules\r0ed_SurvivableCrashes\functions\fn_vehicleInit.sqf";
r0ed_SurvivableCrashes_PlaySfx = compile preprocessFileLineNumbers "modules\r0ed_SurvivableCrashes\functions\fn_playSfx.sqf";

{
    _unit = _x;
    _veh = vehicle _x;
	if(_veh != _unit && not (_veh isKindOf "Man")) then {
		if(isServer) then {
			[_veh] call r0ed_SurvivableCrashes_VehicleInit;
		};
	};
} forEach allUnits;

if(hasInterface) then {
	player addEventHandler ["GetInMan", {
		params ["_unit", "_position", "_veh"];
		if(hasInterface) then {
			if(_unit == player) then {
				[_veh] call r0ed_SurvivableCrashes_VehicleInit;
			};
		};
		[_veh] remoteExec ["r0ed_fnc_vehicleInit", 2];
	}];
}