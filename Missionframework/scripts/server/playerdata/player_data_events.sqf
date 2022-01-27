waitUntil {!isNil "GRLIB_players_data"};
waitUntil {!isNil "save_is_loaded"};
waitUntil {save_is_loaded};

GRLIB_Players_Disconnect_Vehicles = [];
GRLIB_Players_Disconnect_SquadMate = [];


SendPlayerData = {
    params ["_owner","_uid"];
    _data = [[], [], []];
    _all_players_uids=[];
    {_all_players_uids pushback (_x select 0)} foreach GRLIB_players_data; 

	if (_uid in _all_players_uids) then { 
			_index = _all_players_uids find _uid; 
			_data = (GRLIB_players_data select _index) select 2;
	} else { 
			GRLIB_players_data pushback [_uid, "", _data]; 
	};
    _playerVarName = "player"+ _uid +"data";
    missionNamespace setVariable [_playerVarName, _data];
    _owner publicVariableClient _playerVarName;
};



addMissionEventHandler ["HandleDisconnect", {
        params ["_unit", "_id", "_uid", "_name"];
        if (_uid == "") exitwith {};
        
        if !(isNull (objectParent _unit)) then {
            GRLIB_Players_Disconnect_Vehicles pushBack [_uid,vehicle _unit];
        };
        
        _nearbyFriends = (units (group _unit)) select {(_x distance _unit ) <100};
        if (count _nearbyFriends > 0) then {
            GRLIB_Players_Disconnect_SquadMate pushBack [_uid,(_nearbyFriends select 0)];
        };

        [_unit,_uid] call SendPlayerData;
        false
}];
    
if (count allplayers > 0) then {
        {
            _uid = getPlayerUID _x;
            if (_uid == "") exitwith {};
            [(owner _x),_uid] call SendPlayerData;
        } forEach allplayers;
};