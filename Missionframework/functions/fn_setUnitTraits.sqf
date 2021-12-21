/*
    File: fn_setUnitTraits.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-11-25
    Last Update: 2020-04-09
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Checks if local player has the given qualification granted.

    Parameter(s):
        _unit - player  to set his traits based on qualifictions

    Returns:
        Nothing
*/
//[player] call KPLIB_fnc_setUnitTraits
params [
    "_unit"
];



if (isNil "GRLIB_last_qualification_check_time") then {GRLIB_last_qualification_check_time = -1000;};

if (time > GRLIB_last_qualification_check_time + 10) then {
    GRLIB_last_qualification_check_time = time;
    GRLIB_qualifications_cache = ((GRLIB_qualifications select {(_x select 0) isEqualTo (getPlayerUID _unit)}) select 0) select 2;
};

if (isNil "GRLIB_qualifications_cache") exitWith {false};
if (isNil "KP_liberation_qualifications") exitWith {false};

{
    if (_x) then
    {
        _execQualification = (KP_liberation_qualifications select _forEachIndex) select 2;
        _unit call _execQualification;
    }

} forEach GRLIB_qualifications_cache;
