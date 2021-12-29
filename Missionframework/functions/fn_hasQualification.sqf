/*
File: fn_hasQualification.sqf
Author: KP Liberation Dev Team - https:// github.com/KillahPotatoes
date: 2019-11-25
Last Update: 2020-04-09
License: MIT License - http:// www.opensource.org/licenses/MIT

Description:
Checks if local player has the given qualification granted.

parameter(s):
_qualification - qualification to check [NUMBER, defaults to -1]

Returns:
Has qualification granted [BOOL]
*/
// [3] call KPLIB_fnc_hasQualification
params[
    ["_qualification", -1, [0, ""]]
];
_hasQualification = false;
if (_qualification isEqualto - 1) exitwith {
    ["No qualification number given"] call BIS_fnc_error;
    _hasQualification = false;
};
if (typeName _qualification == "STRING") then {

    _index = KP_liberation_qualifications apply {
        _x select 0
    }
    find _qualification;
    _hasQualification = [_index] call KPLIB_fnc_hasQualification;
}
else {

    if (isnil "GRLIB_last_qualification_check_time") then {
        GRLIB_last_qualification_check_time = -1000;
    };

    if (time > GRLIB_last_qualification_check_time + 10) then {
        GRLIB_last_qualification_check_time = time;
        GRLIB_qualifications_cache = ((GRLIB_qualifications select {
            (_x select 0) isEqualto(getplayerUID player)
        }) select 0) select 2;
    };

    if (isnil "GRLIB_qualifications_cache") exitwith {
        _hasQualification = false;
    };

    if (count GRLIB_qualifications_cache > _qualification) then {
        _hasQualification = GRLIB_qualifications_cache select _qualification;
    } else {
        _hasQualification = false;
    };
};

_hasQualification