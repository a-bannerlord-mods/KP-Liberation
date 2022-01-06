
/*
    File: fn_applyCustomUnitSettings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-05-08
    Last Update: 2020-04-29
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Applies code from kp_objectInits.sqf to given object. Returns true if some code was applied, false if object has no KPLIB init code.

    Parameter(s):
        _unit - Object which should get init code applied, if there is any defined [OBJECT, defaults to objNull]

    Returns:
        Nothing
    [_unit] call KPLIB_fnc_applyCustomUnitSettings;
*/

params [
    ["_unit", objNull, [objNull]]
];


set_random_name={
    params ["_unit","_fnames","_snames"];
    _firstname = selectRandom _fnames;
    _secoundname = selectRandom _snames;
    if (_firstname!=_secoundname) then {
        _unit setName [_firstname+" "+_secoundname, _firstname, _secoundname];
    } else {
        _unit call set_random_name;
    };
};

if (isNull _unit) exitWith {["Null unit given"] call BIS_fnc_error; false};

_classname = typeof _unit;
_overrindex = KPLIB_units_Override apply {
    toLower (_x select 0)
} find (toLower _classname);

if (_overrindex!=-1) then {
    _units_Override = KPLIB_units_Override select _overrindex;
    _loadout = _units_Override select 4;
    if (count _loadout > 0) then {
        _unit setUnitLoadout _loadout;
    };
    _fnames = _units_Override select 2;
    _snames = _units_Override select 3;
    if (count _fnames > 0 && count _snames > 0) then {
        [_unit, _fnames, _snames] call set_random_name;
    };
};