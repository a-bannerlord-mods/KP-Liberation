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

params["_number"];

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



private _saveData = profileNamespace getVariable (GRLIB_save_key + "_BACKUP_" + _number);
if !(isNil "_saveData") then {
    kp_liberation_saving = true;
    // Write data in the server profileNamespace
    profileNamespace setVariable [GRLIB_save_key, _saveData];
    saveProfileNamespace;

    kp_liberation_saving = false;
    "Restoring Backup" remoteExec ["hint",commandant];
    sleep 30;
    
    "Backup_Restored" call BIS_fnc_endMissionServer;

    true
}else{
    if (!isnil "commandant") then {
            "Backup Not Found" remoteExec ["hint",commandant];
    };
    false
};


