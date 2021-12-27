/*
    File: fn_getVehiclePylon.sqf
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
//[_v] call KPLIB_fnc_getVehiclePylon;


params["_target"];

if (isNull _target) exitWith {["Null object given"] call BIS_fnc_error; []};

_ammoPylon = []; {
    _type = _x;
    _amount = _target ammoOnPylon(_foreachindex + 1);
    _ammoPylon pushback[_type, _amount];
}
forEach getPylonMagazines _target;
_ammoPylon
