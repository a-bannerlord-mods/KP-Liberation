/*
    File: fn_setContainersItems.sqf
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
//[_v,[items]] call KPLIB_fnc_setContainersItems;

params ["_target", "_presetContents"];

if (isNull _target) exitWith {["Null object given"] call BIS_fnc_error; []};

{
    if (count _x > 2) then { //Weapon
        _target addWeaponWithAttachmentsCargoGlobal [_x, 1];
    } else { //Item
        _x params ["_class", "_count"];
        _target addItemCargoGlobal [_class, _count];
    }
} forEach _presetContents;