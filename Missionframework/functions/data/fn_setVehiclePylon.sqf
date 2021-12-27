/*
    File: fn_setVehiclePylon.sqf
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
//[_v,_ammoPylon] call KPLIB_fnc_setVehiclePylon;


params["_target", "_ammoPylon"];

if (isNull _target) exitWith {["Null object given"] call BIS_fnc_error; false};

{
    _target removeWeaponGlobal getText(configFile >> "CfgMagazines" >> _x >> "pylonWeapon")
} forEach getPylonMagazines _target;

{
    _type = _x select 0;
    _amount = _x select 1;
    _location = _foreachindex + 1;
    _target setPylonLoadOut[_location, _type, true];
    _target setAmmoOnPylon[_location, _amount];
}
foreach(_ammoPylon);