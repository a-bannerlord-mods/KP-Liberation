//VAM Common Vehicle Camo Apply
disableSerialization;
private _VAM_display = findDisplay 4900;
private _list_camo = _VAM_display displayCtrl 4910;

private _list_selection = lbCurSel _list_camo;
private _selected_camo_class_name = camo_class_names select _list_selection;
[VAM_targetvehicle,[_selected_camo_class_name,1],nil,nil] call BIS_fnc_initVehicle;

if (local VAM_targetvehicle) then {
	[VAM_targetvehicle,[_selected_camo_class_name,1],nil,nil] call BIS_fnc_initVehicle;
} else {
	[VAM_targetvehicle,[_selected_camo_class_name,1],nil,nil] remoteExec ["BIS_fnc_initVehicle", VAM_targetvehicle]
};