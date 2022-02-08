/*
    File: fn_addActionsPlayer.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-08-07
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Adds Liberation player actions to the given player.

    Parameter(s):
        _player - Player to add the actions to [OBJECT, defaults to player]
    [player] call KPLIB_fnc_updatePlayerStats;
    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_player", player, [objNull]]
];

if !(isServer) exitwith {
    [_player] remoteExecCall ["KPLIB_fnc_updatePlayerStats", 2];
};

if !(isPlayer _player) exitWith {["No player given"] call BIS_fnc_error; []};

_uid = getPlayerUID _player;

if (_uid=="") exitWith {["Player has no UID"] call BIS_fnc_error; []};

_indx = stats_players findif { (_x select 0 )==_uid };

_civ_killed = _player getVariable ["civ_killed",0];
_total_spent = _player getVariable ["total_spent",0];
_total_KIA = _player getVariable ["total_KIA",0];
_total_unconscious = _player getVariable ["total_unconscious",0];
_total_kills =_player getVariable ["total_kills",0];
_total_timespent =_player getVariable ["total_timespent",0];
_total_missions =_player getVariable ["total_missions",0];
_data = [_uid,name _player,_total_kills,_total_unconscious,_total_KIA,_total_spent,_civ_killed,_total_missions,_total_timespent];

if (_indx>-1) then {
    stats_players set [_indx,_data]
} else {
    stats_players pushBack _data;
};
