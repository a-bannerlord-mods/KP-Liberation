/*
    File: fn_setVehicleLoadout.sqf
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
//[_v,_loadout] call KPLIB_fnc_setVehicleLoadout;


params ["_target","_ammoClassic"];

if (isNull _target) exitWith {["Null object given"] call BIS_fnc_error; false};

{
    _magazine = _x select 0;
    _turret = _x select 1;
    _target removeMagazinesTurret[_magazine, _turret];
}
foreach(magazinesAllTurrets _target);

{
    _turret = _x select 0;
    _magazine = _x select 1;
    _ammo = _x select 2;

    _ammoPerMag = getNumber(configfile >> "CfgMagazines" >> _magazine >> "count");

    while {
        _ammo > 0
    }
    do {
        if (_ammoPerMag > _ammo) then {
            _ammoPerMag = _ammo
        };
        _target addMagazineTurret[_magazine, _turret, _ammoPerMag];
        _ammo = _ammo - _ammoPerMag;
    };
}
forEach(_ammoClassic);