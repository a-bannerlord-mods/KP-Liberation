/*
    File: fn_setObjectExtraDataFromSave.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-04-13
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        function return data of object to save

    Parameter(s):
        _obj - object to save

    Returns:
        nothing
*/
//[_obj,_data] call KPLIB_fnc_setObjectExtraDataFromSave;
params [
    ["_obj", objNull, [objNull]],
    ["_data", [] ]
];

if (isNull _object) exitWith {["Null object given"] call BIS_fnc_error; false};

_class = tolower (typeof _obj);

{
    //fuel
    if ((_x select 0) == "fuel" && (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes) ) then {
        _obj setFuel (_x select 1);
    };

     //damage
    if ((_x select 0) == "damage" && (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes)) then {
        _previousDamage =_x select 1;
        _obj setVariable ["previousDamage" ,_previousDamage];
    };

    //jna_dataList
    if ((_x select 0) == "jna_dataList") then {
        _obj setVariable ["jna_dataList" ,(_x select 1),true];
    };
    
    //driver_radio_settings
    if ((_x select 0) == "driver_radio_settings") then {
        _obj setVariable ["driver_radio_settings" ,(_x select 1),true];
    };
    
     //container items
    if ((_x select 0) == "container_items") then {
        [_obj,(_x select 1)] call KPLIB_fnc_setContainersItems;
    };

    //vehicle ammo
    if ((_x select 0) == "vehicle_ammo") then {
        [_obj,(_x select 1)] call KPLIB_fnc_setVehicleLoadout;
    };

    //vehicle pylon
    if ((_x select 0) == "vehicle_pylon") then {
        [_obj,(_x select 1)] call KPLIB_fnc_setVehiclePylon;
    };
    
    //vehicle flag
    if ((_x select 0) == "forced_flag_texture") then {
        _obj forceFlagTexture (_x select 1);
    };
} forEach _data;


