params [
    ["_player", player, [objNull]]
];


[_player] call KPLIB_fnc_addBuyFuelActions;
[_player] call KPLIB_fnc_addBuyAmmoActions;
[_player] call KPLIB_fnc_addRepairActions;
[_player] call KPLIB_fnc_addMoveAmmoActions;
[_player] call KPLIB_fnc_addMoveFuelActions;
