
/*
    File: fn_addLightGenerator.sqf
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
//[this,500] call KPLIB_fnc_addLightGenerator
params ["_generator","_range"];

_generator addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    _distancetoreach = 300;
    {
        if ((!(_x isKindOf "LandVehicle")) && (!(_x isKindOf "CAManBase")) && (!(_x isKindOf "Air")) && (!(_x isKindOf "Ship")) ) then {
            private _ticket = format ["LSS%1", _forEachindex];
            [_x, "OFF"] remoteExec ["switchLight", 0, _ticket];
        };
    } forEach nearestobjects [_unit, [], _distancetoreach];

    {
        // Current result is saved in variable _x
        deleteVehicle _x;
    }  forEach nearestobjects [_unit, ["Land_TransferSwitch_01_F"], 10];
}];