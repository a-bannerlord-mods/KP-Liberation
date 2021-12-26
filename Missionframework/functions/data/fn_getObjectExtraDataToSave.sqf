/*
    File: fn_getObjectExtraDataToSave.sqf
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
//[player] call KPLIB_fnc_getObjectExtraDataToSave;
params [
    ["_obj", objNull, [objNull]]
];

if (isNull _obj) exitWith {["Null object given"] call BIS_fnc_error; false};

_data = [];
_class = tolower (typeof _obj);

//fuel
if (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes ) then {
    _data pushBack ["fuel",fuel _obj];
};

//damage
if (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes ) then {
    // Save this with whatever other info you're saving. 
    _hitPoints =getAllHitPointsDamage _obj;
    if (count _hitPoints > 1) then {
        _previousDamage = _hitPoints select 2; 
        _data pushBack ["damage",_previousDamage];
    };
};

_items = _obj getVariable ["jna_dataList",[]];
if (count _items > 0 ) then {
    _data pushBack ["jna_dataList",_items];
};

_d = _obj getVariable ["driver_radio_settings",[]];
if (count _d > 0 ) then {
    _data pushBack ["driver_radio_settings",_d];
};

_data