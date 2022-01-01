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
	_hitPoints =getAllHitPointsDamage _obj;
	if (count _hitPoints > 1) then {
		_previousDamage = _hitPoints select 2; 
		_data pushBack ["damage",_previousDamage];
	};
};

//container items
if (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes ) then {
	_items = [_obj] call KPLIB_fnc_getContainersItems;
	_data pushBack ["container_items",_items];
};

//vehicle ammo
if (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes ) then {
	_loadout = [_obj] call KPLIB_fnc_getVehicleLoadout;
	_data pushBack ["vehicle_ammo",_loadout];
};

//vehicle pylon
if (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes ) then {
	_loadout = [_obj] call KPLIB_fnc_getVehiclePylon;
	_data pushBack ["vehicle_pylon",_loadout];
};

//arsinal items
_items = _obj getVariable ["jna_dataList",[]];
if (count _items > 0 ) then {
	_data pushBack ["jna_dataList",_items];
};

//radio settings
_d = _obj getVariable ["driver_radio_settings",[]];
if (count _d > 0 ) then {
	_data pushBack ["driver_radio_settings",_d];
};

_forcedFlagTexture = getForcedFlagTexture _obj; 
if (_forcedFlagTexture!=  "" ) then {
	_data pushBack ["forced_flag_texture",_forcedFlagTexture];
};

if !(isnull (_obj getVariable['SSS_parentEntity', objNull])) then {
	if (!isnil "blufor_transport_support_vehicles" &&
		(typeof _obj ) in (blufor_transport_support_vehicles apply { _x select 0}) ) then {
		_data pushBack ["support_group","transport"];
	};
	if (!isnil "blufor_cas_support_vehicles" &&
		(typeof _obj ) in (blufor_cas_support_vehicles apply { _x select 0}) ) then {
		_data pushBack ["support_group","cas"];
	};
};

//arsinal items
_customname = _obj getVariable ["ace_cargo_customname",""];
if (_customname!="") then {
	_data pushBack ["ace_cargo_customname",_customname];
};


_data