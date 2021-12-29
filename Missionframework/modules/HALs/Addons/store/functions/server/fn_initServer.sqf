/*
	Function: HALs_store_fnc_initServer
	Author: HallyG
	Server initialisation.

	Argument(s):
	0: None

	Return Value:
	None

	Example:
	[] call HALs_store_fnc_initServer;
__________________________________________________________________*/
if (!isServer) exitWith {};
if (!isNil "HALs_store_debug") exitWith {};

[
	["CfgHALsStore"],
	"HALs_store_",
	[
		["containerRadius", 10, {_this max 0}, true],
		["containerTypes", [], {_this}, true],
		["currencySymbol", "¢", {_this}, true],
		["sellFactor", 1, {_this max 0 min 1}, true],
		["debug", 0, {_this isEqualTo 1}]
	]
] call HALs_fnc_getModuleSettings;

missionNamespace setVariable ["HALs_store_getNearbyVehicles", compile '
	params [
		["_trader", objNull, [objNull]],
		["_types", [KP_liberation_loadoutbox_classname], [[]]],
		["_radius", 250, [0]]
	];

	private _vehicles = nearestObjects [_trader, _types, _radius, true];
	_vehicles select {alive _x && isNil {_x getVariable "HALs_store_trader_type"}};
', true];