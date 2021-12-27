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
//[_v] call KPLIB_fnc_getContainersItems;


params ["_target"];

private _presetContents = [];


private _weapons = [];

{
    _presetContents pushBack _X;
} forEach weaponsItemsCargo _target;

private _magazineCargo = getMagazineCargo _target;

{
    _presetContents pushBack [_x, (_magazineCargo select 1) select _forEachIndex];
} forEach (_magazineCargo select 0);


private _itemCargo = getItemCargo _target;

{
    _presetContents pushBack [_x, (_itemCargo select 1) select _forEachIndex];
} forEach (_itemCargo select 0);

_presetContents