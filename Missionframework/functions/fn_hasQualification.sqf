/*
    File: fn_hasQualification.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-11-25
    Last Update: 2020-04-09
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Checks if local player has the given qualification granted.

    Parameter(s):
        _qualification - qualification to check [NUMBER, defaults to -1]

    Returns:
        Has qualification granted [BOOL]
*/
//[3] call KPLIB_fnc_hasQualification
params [
    ["_qualification", -1, [0]]
];

if (_qualification isEqualTo -1) exitWith {["No qualification number given"] call BIS_fnc_error; false};
//if (!GRLIB_qualifications_param) exitWith {true};

if (isNil "GRLIB_last_qualification_check_time") then {GRLIB_last_qualification_check_time = -1000;};

if (time > GRLIB_last_qualification_check_time + 10) then {
    GRLIB_last_qualification_check_time = time;
    GRLIB_qualifications_cache = ((GRLIB_qualifications select {(_x select 0) isEqualTo (getPlayerUID player)}) select 0) select 2;
};

if (isNil "GRLIB_qualifications_cache") exitWith {false};

if (count GRLIB_qualifications_cache > _qualification) then {
    GRLIB_qualifications_cache select _qualification
} else {
    false
};
