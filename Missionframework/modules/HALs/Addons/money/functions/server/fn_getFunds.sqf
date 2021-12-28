/*
	Function: HALs_money_fnc_getFunds
	Author: HallyG

	Arguments(s):
	0: Unit <OBJECT>

	Return Value:
	Funds <NUMBER>

	Example:
	[] call HALs_money_fnc_getFunds;
__________________________________________________________________*/
params [
	["_unit", objNull, [objNull]]
];

_nearfob = [] call KPLIB_fnc_getNearestFob;
_actual_fob = KP_liberation_fob_resources select {((_x select 0) distance _nearfob) < GRLIB_fob_range};
(_actual_fob select 0) select 1
//(_unit getVariable ["HALs_money_funds", 0])
