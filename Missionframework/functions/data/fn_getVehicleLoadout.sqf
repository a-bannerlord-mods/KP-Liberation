/*
    File: fn_getContainersItems.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-04-13
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        function return data of object to save

    Parameter(s):
        _obj - object to save

    Returns:
        array of extra data
*/
//[_v] call KPLIB_fnc_getVehicleLoadout;


params ["_target"];

if (isNull _target) exitWith {["Null object given"] call BIS_fnc_error; []};

_ammoClassic = []; 
{
    //magazinesAllTurrets type 
    _magazine = _x select 0;
    _turret = _x select 1;
    _ammo = _x select 2;

    //skip pylon ammo 
    if (gettext(configfile >> "CfgMagazines" >> _magazine >> "pylonWeapon") isEqualTo "") then {
        _found = false; {
            _turret2 = _x select 0;
            _magazine2 = _x select 1;
            _ammo2 = _x select 2;
            if (_turret isEqualTo _turret2 && _magazine2 isEqualTo _magazine) exitWith {
                _found = true;
                _ammoClassic set[_foreachindex, [_turret, _magazine, (_ammo + _ammo2)]];
            };
        }
        forEach _ammoClassic;

        if (!_found) then {
            _ammoClassic pushback[_turret, _magazine, _ammo];
        };
    };
}
forEach magazinesAllTurrets _target;

_ammoClassic
