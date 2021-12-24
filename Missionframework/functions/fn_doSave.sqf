/*
    File: fn_doSave.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-03-29
    Last Update: 2020-05-08
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Save mission state to profileNamespace.

    Parameter(s):
        NONE

    Returns:
        Data was saved [BOOL]
*/

if (!isServer) exitWith {false};



if (!KPLIB_init) exitWith {
    ["Framework is not initalized, skipping save!", "SAVE"] call KPLIB_fnc_log;
    if (!isnil "commandant") then {
        "Framework is not initalized, skipping save!" remoteExec ["hint",commandant];
    };
    false
};

if (missionNamespace getVariable ["kp_liberation_saving", false]) exitWith {
    ["Saving already in progress, skipping save!", "SAVE"] call KPLIB_fnc_log;
    if (!isnil "commandant") then {
        "Saving already in progress, skipping save!" remoteExec ["hint",commandant];
    };
    false
};

kp_liberation_saving = true;

//Save all players data
{
    [_x] call KPLIB_fnc_updatePlayerData;
} forEach allplayers;

private _saveData = [] call KPLIB_fnc_getSaveData;

// Write data in the server profileNamespace
profileNamespace setVariable [GRLIB_save_key, str _saveData];
saveProfileNamespace;

if (!isnil "commandant") then {
        "Players and Progress Saved Successfully!" remoteExec ["hint",commandant];
};

kp_liberation_saving = false;

true
