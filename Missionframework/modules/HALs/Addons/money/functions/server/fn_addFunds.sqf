/*
Function: HALs_money_fnc_addFunds
Author: HallyG

Arguments(s):
0: Unit <OBJECT>
1: Funds <NUMBER>

Return Value:
None

Example:
[player, 100] call HALs_money_fnc_addFunds;
__________________________________________________________________*/
params [
    ["_unit", objNull, [objNull]],
    ["_funds", 0, [0]]
];

// if (!local _unit) exitwith {
    // [_unit, _funds] remoteExec ["HALs_money_fnc_addFunds", _unit, false]
// };

// _unit setVariable ["HALs_money_funds", ((_unit getVariable ["HALs_money_funds", 0]) + _funds) max 0, true];
if (_funds<0) then {
    _nearfob = [] call KPLIB_fnc_getNearestFob;
    _storage_areas = (_nearfob nearObjects (GRLIB_fob_range * 2)) select {
        (_x getVariable ["KP_liberation_storage_type", -1]) == 0
    };
    [_funds*-1, 0, 0, "", 0, _storage_areas] remoteExec ["build_remote_call", 2];
} else {};