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

params [["_forced",true]];

if (!KPLIB_init) exitWith {
    ["Framework is not initalized, skipping save!", "SAVE"] call KPLIB_fnc_log;
    if (!isnil "commandant") then {
        "Framework is not initalized, skipping save!" remoteExec ["hint",commandant];
    };
    if (!isnil "commandant_1") then {
        "Framework is not initalized, skipping save!" remoteExec ["hint",commandant_1];
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

_number = (str (systemTime select 0)) + (str (systemTime select 1)) + (str (systemTime select 2));

_saveData = profileNamespace getVariable (GRLIB_save_key + "_BACKUP_" + _number);

if (isNil "_saveData" || _forced) then {
    kp_liberation_saving = true;

    //Save all players data
    {
        [_x] call KPLIB_fnc_updatePlayerData;
    } forEach allplayers;

    private _saveData = [] call KPLIB_fnc_getSaveData;


    // Write data in the server profileNamespace
    profileNamespace setVariable [(GRLIB_save_key + "_BACKUP_" + _number),  str _saveData];
    saveProfileNamespace;

    if (!isnil "commandant") then {
        format ["Backup [%1] done Successfully!",_number] remoteExec ["hint",commandant];
    };

    kp_liberation_saving = false;

    true
}else{
    false
};

