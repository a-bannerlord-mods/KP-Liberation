update_player_markers = {
    params ["_unit"];
    if !(isnil "mapShare_fnc_markerToString") then {
        _markerDataList = []; 
        {  
                private "_a";  
                _a = toArray _x; 
                _a resize 15; 
                if (toString _a == "_USER_DEFINED #") then {
                    _saveInfo = _x call mapShare_fnc_markerToString;
                    _markerDataList pushBack _saveInfo;
                }; 
        } forEach allMapMarkers; 
        _unit setVariable ["markers",_markerDataList,true];
    };
};

player addEventHandler ["InventoryClosed", {
        params ["_unit"];
        [_unit] call update_player_markers;
        [_unit] remoteExec ["KPLIB_fnc_updatePlayerData", 2];
	}];

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
    [_unit] call update_player_markers;
    [_unit] remoteExec ["KPLIB_fnc_updatePlayerData", 2];
}];

while {true} do {
    sleep 300;
    [player] call update_player_markers;
    [player] remoteExec ["KPLIB_fnc_updatePlayerData", 2];
};