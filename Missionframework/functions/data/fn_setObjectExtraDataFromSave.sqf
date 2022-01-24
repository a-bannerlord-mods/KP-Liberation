/*
File: fn_setobjectextradatafromSave.sqf
Author: KP Liberation Dev Team - https:// github.com/KillahPotatoes
date: 2020-04-13
Last Update: 2020-04-13
License: MIT License - http:// www.opensource.org/licenses/MIT

Description:
function return data of object to save

parameter(s):
_obj - object to save

Returns:
nothing
*/
// [_obj, _data] call KPLIB_fnc_setobjectextradatafromSave;
params [
	["_obj", objNull, [objNull]],
	["_data", [] ]
];

if (isNull _obj) exitwith {
	["Null object given"] call BIS_fnc_error;
	false
};

_class = toLower (typeOf _obj);

{
	if (typename _x == "ARRAY" ) then {
		// fuel
		if ((_x select 0) == "fuel" && (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes)) then {
			_obj setFuel (_x select 1);
		};
		
		// damage
		if ((_x select 0) == "damage" && (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes)) then {
			_previousdamage =_x select 1;
			_obj setVariable ["previousdamage", _previousdamage];
		};
		
		// jna_datalist
		if ((_x select 0) == "jna_datalist") then {
			_obj setVariable ["jna_datalist", (_x select 1), true];
		};
		
		// ace_cargo_customname
		if ((_x select 0) == "ace_cargo_customname") then {
			_obj setVariable ["ace_cargo_customname", (_x select 1), true];
		};

		// KPLIB_seized
		if ((_x select 0) == "KPLIB_seized") then {
			_obj setVariable ["KPLIB_seized",(_x select 1) , true];
		};

		// KPLIB_captured
		if ((_x select 0) == "KPLIB_captured") then {
			_obj setVariable ["KPLIB_captured",(_x select 1) , true];
		};		
		
		// driver_radio_settings
		if ((_x select 0) == "driver_radio_settings") then {
			_obj setVariable ["driver_radio_settings", (_x select 1), true];
		};
		
		// container items
		if ((_x select 0) == "container_items") then {
			[_obj, (_x select 1)] call KPLIB_fnc_setContainersitems;
		};
		
		// vehicle ammo
		if ((_x select 0) == "vehicle_ammo") then {
			[_obj, (_x select 1)] call KPLIB_fnc_setvehicleloadout;
		};
		
		// vehicle pylon
		if ((_x select 0) == "vehicle_pylon") then {
			[_obj, (_x select 1)] call KPLIB_fnc_setvehiclePylon;
		};
		
		// vehicle flag
		if ((_x select 0) == "forced_flag_texture") then {
			_obj forceFlagtexture (_x select 1);
		};

		// fuel cargo
		if ((_x select 0) == "ace_fuel_currentsupply") then {
			[_obj, (_x select 1)] call ace_refuel_fnc_setFuel;
		};

		// loadout
		if ((_x select 0) == "loadout") then {
			[_obj,(_x select 1)] spawn {
				params ["_obj","_loadout"];
				sleep 1;
				_obj setUnitLoadout _loadout ;
			};	
		};

		// task
		if ((_x select 0) == "task") then {
			_obj setVariable["task", (_x select 1), true];
			switch ((_x select 1)) do {
				case "guard": { 
					_obj setUnitPos "UP";
					_obj disableAI "PATH";
					[_obj] joinSilent grpNull;
					[_obj, "WATCH", "FULL"] call BIS_fnc_ambientAnimCombat;
				};
				default { };
			};
		};

		// vehicle customization
		if ((_x select 0) == "vehicle_customization") then {
			_s = (_x select 1);
			[_obj,_s select 0 ,_s select 1] call BIS_fnc_initVehicle;
		};
		// ammo cargo
		if ((_x select 0) == "ace_rearm_currentsupply") then {
			[_obj, (_x select 1)] call ace_rearm_fnc_setSupplyCount;
		};
		
		// support group
		if (isClass(configFile >> "CfgPatches" >> "SSS")) then {
			if ((_x select 0) == "support_group") then {
				_customname = _obj getVariable ["ace_cargo_customname", ""];
				switch ((_x select 1)) do {
					case "transport": {
						[_obj, _customname, -1, {}, blufor_cas_support_required_items, {
							player getUnitTrait 'JTAC'
						}] call sss_support_fnc_addtransport;
					};
					case "cas": {
						[_obj, _customname, -1, {}, blufor_cas_support_required_items, {
							player getUnitTrait 'JTAC'
						}] call sss_support_fnc_addcashelicopter;
					};
					default {};
				};
			};
		};

		//field rations hunger
		if ((_x select 0) == "acex_field_rations_hunger") then {
			_obj setVariable ["acex_field_rations_hunger",(_x select 1) , true];
		};

		//field rations thirst
		if ((_x select 0) == "acex_field_rations_thirst") then {
			_obj setVariable ["acex_field_rations_thirst",(_x select 1)  , true];
		};

		//total supplies spent
		if ((_x select 0) == "total_spent") then {
			_obj setVariable ["total_spent",(_x select 1) , true];
		};
		
		//civ killed
		if ((_x select 0) == "civ_killed") then {
			_obj setVariable ["civ_killed",(_x select 1) , true];
		};
	};
} forEach _data;