player addEventHandler ["InventoryClosed", {
        params ["_unit"];
        [_unit] remoteExec ["KPLIB_fnc_updatePlayerData", 2];
	}];

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
    [_unit] remoteExec ["KPLIB_fnc_updatePlayerData", 2];
}];