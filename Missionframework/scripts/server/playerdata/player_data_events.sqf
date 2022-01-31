waitUntil {!isNil "GRLIB_players_data"};
waitUntil {!isNil "save_is_loaded"};
waitUntil {save_is_loaded};

GRLIB_Players_Disconnect_Vehicles = createHashMap;
GRLIB_Players_Disconnect_SquadMate = createHashMap;
publicVariable "GRLIB_Players_Disconnect_Vehicles";
publicVariable "GRLIB_Players_Disconnect_SquadMate";

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

    _owner publicVariableClient "GRLIB_Players_Disconnect_Vehicles";
    _owner publicVariableClient "GRLIB_Players_Disconnect_SquadMate";
};


addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
    
    if !(isNull (objectParent _unit)) then {
        GRLIB_Players_Disconnect_Vehicles set [_uid,vehicle _unit];
        publicVariable "GRLIB_Players_Disconnect_Vehicles";
    };
    
    _nearbyFriends = (units (group _unit)) select {!(_x isEqualTo _unit )&&(_x distance _unit ) <100};
    if (count _nearbyFriends > 0) then {
        GRLIB_Players_Disconnect_SquadMate set [_uid,(_nearbyFriends select 0)];
        publicVariable "GRLIB_Players_Disconnect_SquadMate";
    };

    [_unit,_uid] call KPLIB_fnc_updatePlayerData;

    false
}];

addMissionEventHandler ["playerConnected",
    {
        params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
        if (_uid == "") exitwith {};
        [_owner,_uid] call SendPlayerData;
}];

    
if (count allplayers > 0) then {
        {
            _uid = getPlayerUID _x;
            if (_uid == "") exitwith {};
            [(owner _x),_uid] call SendPlayerData;
        } forEach allplayers;
};

[] spawn {
    while {true} do {
        {
            _unit = _x;
            _uid = getPlayerUID _unit;
            if !(_uid=="") then {
                if !(isNull (objectParent _unit)) then {
                    GRLIB_Players_Disconnect_Vehicles set [_uid,vehicle _unit];
                }else{
                    GRLIB_Players_Disconnect_Vehicles set [_uid,objNull];
                };
                _nearbyFriends = (units (group _unit)) select {!(_x isEqualTo _unit )&&(_x distance _unit ) <100};
                if (count _nearbyFriends > 0) then {
                    GRLIB_Players_Disconnect_SquadMate set [_uid,(_nearbyFriends select 0)];
                }else{
                    GRLIB_Players_Disconnect_SquadMate set [_uid,objNull];
                };
            };   
        } forEach allplayers;

        publicVariable "GRLIB_Players_Disconnect_SquadMate";
        publicVariable "GRLIB_Players_Disconnect_Vehicles";

        sleep 60;
    };
    
};