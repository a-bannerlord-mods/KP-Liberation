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

//loadout
if (_class in KPLIB_b_infantry_classes ) then {
	_data pushBack ["loadout", getUnitLoadout _obj];
};

//task
if (_class in KPLIB_b_infantry_classes ) then {
	_task = _obj getVariable ["task",""];
	if (_task!="") then {
		_data pushBack ["task",_task];
	};
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

//cargo customname
_customname = _obj getVariable ["ace_cargo_customname",""];
if (_customname!="") then {
	_data pushBack ["ace_cargo_customname",_customname];
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

//rearm 
_ace_rearm_storage = getNumber (configFile >> "CfgVehicles" >>  typeof _obj >> "ace_rearm_defaultSupply");
if (_ace_rearm_storage>0) then {
	_data pushBack ["ace_rearm_currentsupply",([_obj] call ace_rearm_fnc_getSupplyCount)];
};

//fuel
_ace_fuel_storage = getNumber (configFile >> "CfgVehicles" >> typeof _obj >> "ace_refuel_fuelCargo");
if (_ace_fuel_storage>0) then {
	_ace_fuel_currentsupply = [_obj] call ace_refuel_fnc_getFuel;
	_data pushBack ["ace_fuel_currentsupply",_ace_fuel_currentsupply];
};

//captured
_KPLIB_captured = _obj getVariable ["KPLIB_captured",false];
if (_KPLIB_captured) then {
	_data pushBack ["KPLIB_captured",true];
};

//seized
_KPLIB_seized = _obj getVariable ["KPLIB_seized",false];
if (_KPLIB_seized) then {
	_data pushBack ["KPLIB_seized",true];
};

if (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes ) then {
	_s = [_obj] call BIS_fnc_getVehicleCustomization;
	_data pushBack ["vehicle_customization",_s];
};


_acex_field_rations_hunger = _obj getVariable ["acex_field_rations_hunger",-1];
if (_acex_field_rations_hunger!=-1) then {
	_data pushBack ["acex_field_rations_hunger",_acex_field_rations_hunger];
};

_acex_field_rations_thirst = _obj getVariable ["acex_field_rations_thirst",-1];
if (_acex_field_rations_thirst!=-1) then {
	_data pushBack ["acex_field_rations_thirst",_acex_field_rations_thirst];
};

_total_spent = _obj getVariable ["total_spent",-1];
if (_total_spent!=-1) then {
	_data pushBack ["total_spent",_total_spent];
};

_civ_killed = _obj getVariable ["civ_killed",-1];
if (_civ_killed!=-1) then {
	_data pushBack ["civ_killed",_civ_killed];
};


_data