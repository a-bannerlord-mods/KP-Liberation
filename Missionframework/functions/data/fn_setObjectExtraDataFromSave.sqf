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

	// ammo cargo
	if ((_x select 0) == "ace_rearm_currentsupply") then {
        [_obj, (_x select 1)] call ace_rearm_fnc_setSupplyCount;
	};
	
	// support group
	if (isClass(configFile >> "CfgPatches" >> "SSS")) then {
		if ((_x select 0) == "support_group") then {
			switch ((_x select 1)) do {
				case "transport": {
					[_obj, "", -1, {}, blufor_cas_support_required_items, {
						player getUnitTrait 'JTAC'
					}] call sss_support_fnc_addtransport;
				};
				case "cas": {
					[_obj, "", -1, {}, blufor_cas_support_required_items, {
						player getUnitTrait 'JTAC'
					}] call sss_support_fnc_addcashelicopter;
				};
				default {};
			};
		};
	};
} forEach _data;