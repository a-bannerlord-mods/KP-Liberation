params ["_object"];

_hx=  boundingBox _object;
_targets = [];
{
_t= createVehicle ["CBA_B_InvisibleTargetVehicle",getPosATL _object];  
createVehicleCrew _t; 
_t attachTo [_object, [(_x select 0)/8 ,(_x select 1)/2,(_x select 2)/8 ]];
_targets pushBack _t;
}forEach (_hx select {typename _x == "ARRAY"});

_object setVariable ["attached_targets",_targets,true];

_object addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	_attached_targets = _unit getVariable ["attached_targets",[]];
	{
		if !(isnull _x) then {
			deleteVehicle _x;
		};
		
	} forEach _attached_targets;
	
}];