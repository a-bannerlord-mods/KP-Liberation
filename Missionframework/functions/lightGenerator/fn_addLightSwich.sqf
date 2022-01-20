
/*
    File: fn_addLightSwich.sqf
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
//[this,500] call KPLIB_fnc_addLightSwich
params ["_switch","_range"];
_switch setVariable ["isOn",true,true];
_switch addAction
[
    ["<img size='1' image='mcc_sandbox_mod\data\iconintel.paa'/><t color='#FF8000'>"," Turn Off", "</t>"] joinString "",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _distancetoreach = 300;
        {
            if ((!(_x isKindOf "LandVehicle")) && (!(_x isKindOf "CAManBase")) && (!(_x isKindOf "Air")) && (!(_x isKindOf "Ship")) ) then {
                private _ticket = format ["LSS%1", _forEachindex];
                [_x, "OFF"] remoteExec ["switchLight", 0, _ticket];
            };
        } forEach nearestobjects [_caller, [], _distancetoreach];
        _target animateSource ["switchposition", 1];
        _target animateSource ["light", 0];
		_target setVariable ["isOn",false,true];
    },
    [],
    1.5,
    true,
    true,
    "",
    "(_target getVariable ['isOn',false])",
    3,
    false,
    "",
    ""
];

_switch addAction
[
    ["<img size='1' image='mcc_sandbox_mod\data\iconintel.paa'/><t color='#FF8000'>"," Turn On", "</t>"] joinString "",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _distancetoreach = 300;
        {
            if ((!(_x isKindOf "LandVehicle")) && (!(_x isKindOf "CAManBase")) && (!(_x isKindOf "Air")) && (!(_x isKindOf "Ship")) ) then {
                private _ticket = format ["LSS%1", _forEachindex];
                [_x, "On"] remoteExec ["switchLight", 0, _ticket];
            };
        } forEach nearestobjects [_caller, [], _distancetoreach];
        _target animateSource ["switchposition", -1];
        _target animateSource ["light", 1];
		_target setVariable ["isOn",true,true];
    },
    [],
    1.5,
    true,
    true,
    "",
    "!(_target getVariable ['isOn',true])",
    3,
    false,
    "",
    ""
];

_switch addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
    _distancetoreach = 300;
    {
        private _ticket = format ["LSS%1", _forEachindex];
        [_x, "OFF"] remoteExec ["switchLight", 0, _ticket];
    } forEach nearestobjects [_unit, [], _distancetoreach];
}];