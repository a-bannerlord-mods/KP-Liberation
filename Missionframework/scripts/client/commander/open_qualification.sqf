waitUntil {!isNil "GRLIB_qualifications"};

private _players_array = [];
private _uids_array = ["Default"];
private _dialog = createDialog "liberation_qualifications";
qualifications_playerid = -1;
qualifications_toset = -1;
save_changes = 0;

color_authorized = [0,0.9,0,1];
color_denied = [0.9,0,0,1];
fontsize = 0.017 * safezoneH;

private _modify_qualifications = + GRLIB_qualifications;

disableSerialization;

waitUntil { dialog };

Qualifications_Count= count KP_liberation_qualifications;

qualifications_create_activetext = compile '

    params ["_idx", "_column", "_qualification", "_text", "_tooltip"];
    
    private _control = (findDisplay 5119) ctrlCreate ["RscActiveText", ((Qualifications_Count * _idx) + 111) + _column, (findDisplay 5119) displayCtrl 9969];
    _control ctrlSetPosition [0.038 * _column * safeZoneW, (_idx * 0.025) * safezoneH, 0.038 * safeZoneW, 0.025  * safezoneH];
    _control ctrlSetText _text;
    _control ctrlSetFontHeight fontsize;
    _control ctrlSetTooltip _tooltip;
    _control buttonSetAction (format ["qualifications_playerid = %1; qualifications_toset = %2;", _idx, _qualification]);
    _control ctrlSetTextColor color_denied;
    _control ctrlSetActiveColor color_denied;
    _control ctrlCommit 0;

';



_players_array pushback ["Default", localize "STR_DEFAULT", 0];
private _idx = 2;

{
    if (!((name _x) in ["HC0","HC1", "HC2", "HC3", "HC4", "HC5"])) then {
        private _nextplayer = _x;

        private _displayname = "";
        if(count (squadParams _nextplayer) != 0) then {
            _displayname = "[" + ((squadParams _nextplayer select 0) select 0) + "] ";
        };
        _displayname = _displayname + name _nextplayer;

        _players_array pushback [getPlayerUID _nextplayer, _displayname, _idx];
        _uids_array pushBack getPlayerUID _nextplayer;

        _idx = _idx + 1;
    };
} foreach allPlayers;

_idx = _idx + 1;

{
    if !((_x select 0) in _uids_array) then {
        _players_array pushBack [_x select 0, _x select 1, _idx];
        _idx = _idx + 1;
    }
} forEach _modify_qualifications;

{
    private _nextplayer = _x;
    private _idx = _nextplayer select 2;

    if (_idx % 2 == 0) then {

        private _control = (findDisplay 5119) ctrlCreate ["RscBackground", -1, (findDisplay 5119) displayCtrl 9969];
        _control ctrlSetPosition [0, (_idx * 0.025) * safezoneH, 0.595 * safeZoneW, 0.025  * safezoneH];
        _control ctrlSetBackgroundColor [0.75,1,0.75,0.12];
        _control ctrlCommit 0;
    };

    private _control = (findDisplay 5119) ctrlCreate ["RscText", (Qualifications_Count * _idx), (findDisplay 5119) displayCtrl 9969];
    _control ctrlSetPosition [0, (_idx * 0.025) * safezoneH, 0.072 * safeZoneW, 0.025  * safezoneH];
    _control ctrlSetText (_nextplayer select 1);
    _control ctrlSetFontHeight fontsize;
    _control ctrlCommit 0;

    {
        [_idx, _forEachIndex+1, _forEachIndex , _x select 0 , _x select 1] call qualifications_create_activetext;
    } forEach KP_liberation_qualifications;

} foreach _players_array;

while {dialog && alive player} do {

    if (qualifications_playerid != -1 || qualifications_toset != -1) then {

        private _player_uid = "";
        private _player_name = "";
        {
            if (_x select 2 == qualifications_playerid) exitWith {_player_uid = _x select 0; _player_name = _x select 1;};
        } foreach _players_array;

        if (_player_uid != "") then {

            private _player_idx = -1;
            private _player_uids = [];
            private _player_qualifications = [];
            {
                _player_uids pushback (_x select 0);
            } foreach _modify_qualifications;

            _player_idx = _player_uids find _player_uid;


            if (_player_idx == -1) then {

                if (qualifications_toset != 666 && qualifications_toset != 999) then {
                _player_qualifications = [];
                    {
                        _player_qualifications pushBack false;
                    } forEach KP_liberation_qualifications;
                    _player_qualifications set [qualifications_toset, true];
                };

                _modify_qualifications pushback [_player_uid, _player_name, _player_qualifications];
            } else {

                if (qualifications_toset != 666 && qualifications_toset != 999) then {
 
                    _player_qualifications = (_modify_qualifications select _player_idx) select 2;

                    private _idx = 0;
                    {
                        if (qualifications_toset == _idx) exitWith {
                            if (_player_qualifications select _idx) then {
                                _player_qualifications set [_idx, false];
                            } else {
                                _player_qualifications set [_idx, true];
                            };
                        };
                        _idx = _idx + 1;
                    } foreach _player_qualifications;
                };
                _modify_qualifications set [_player_idx, [_player_uid, _player_name, _player_qualifications]];
            };
        };

        qualifications_playerid = -1;
        qualifications_toset = -1;
    };
    _indexes= [];
    {
        _indexes pushBack (_forEachIndex + 1);
        
    } forEach KP_liberation_qualifications;
    
    {
        private _nextplayer = _x;
        {
            if (_nextplayer select 0 == _x select 0) exitWith {
                private _idx = _nextplayer select 2;
                private _player_qualifications = _x select 2;

                {
                    private _control = ((findDisplay 5119) displayCtrl ((Qualifications_Count * _idx) + _x + 111));
                    if (_player_qualifications select (_x - 1)) then {
                        _control ctrlSetTextColor color_authorized;
                        _control ctrlSetActiveColor color_authorized;
                    } else {
                        _control ctrlSetTextColor color_denied;
                        _control ctrlSetActiveColor color_denied;
                    };
                } foreach _indexes;
            };
        } foreach _modify_qualifications;

    } foreach _players_array;

    if (save_changes == 1) then {
        GRLIB_qualifications = +_modify_qualifications;
        publicVariable "GRLIB_qualifications";
        [] remoteExec ["remote_call_qualifications_updated", -2];
        closeDialog 0;
    };

    waitUntil {!dialog || !(alive player) || qualifications_playerid != -1 || qualifications_toset != -1 || save_changes != 0};
};
