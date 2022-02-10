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
	_key =_x select 0;
	_value=_x select 1;
	if (typename _x == "ARRAY" ) then {
		// fuel
		if (_key == "fuel" && (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes)) then {
			_obj setFuel _value;
		};
		
		// damage
		if (_key == "damage" && (_class in KPLIB_b_allVeh_classes ||_class in KPLIB_o_allVeh_classes)) then {
			_previousdamage =_x select 1;
			_obj setVariable ["previousdamage", _previousdamage];
		};
		
		// jna_datalist
		if (_key == "jna_datalist") then {
			_obj setVariable ["jna_datalist", _value, true];
		};
		
		// ace_cargo_customname
		if (_key == "ace_cargo_customname") then {
			_obj setVariable ["ace_cargo_customname", _value, true];
		};

		// KPLIB_seized
		if (_key == "KPLIB_seized") then {
			_obj setVariable ["KPLIB_seized",_value , true];
		};

		// KPLIB_captured
		if (_key == "KPLIB_captured") then {
			_obj setVariable ["KPLIB_captured",_value , true];
		};		
		
		// driver_radio_settings
		if (_key == "driver_radio_settings") then {
			_obj setVariable ["driver_radio_settings", _value, true];
		};
		
		// container items
		if (_key == "container_items") then {
			[_obj, _value] call KPLIB_fnc_setContainersitems;
		};
		
		// vehicle ammo
		if (_key == "vehicle_ammo") then {
			[_obj, _value] call KPLIB_fnc_setvehicleloadout;
		};
		
		// vehicle pylon
		if (_key == "vehicle_pylon") then {
			[_obj, _value] call KPLIB_fnc_setvehiclePylon;
		};
		
		// vehicle flag
		if (_key == "forced_flag_texture") then {
			_obj forceFlagtexture _value;
		};

		// fuel cargo
		if (_key == "ace_fuel_currentsupply") then {
			[_obj, _value] call ace_refuel_fnc_setFuel;
		};

		// loadout
		if (_key == "loadout") then {
			[_obj,_value] spawn {
				params ["_obj","_loadout"];
				sleep 1;
				_obj setUnitLoadout _loadout ;
			};	
		};

		// task
		if (_key == "task") then {
			_obj setVariable["task", _value, true];
			switch (_value) do {
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
		if (_key == "vehicle_customization") then {
			_s = _value;
			[_obj,_s select 0 ,_s select 1] call BIS_fnc_initVehicle;
		};
		// ammo cargo
		if (_key == "ace_rearm_currentsupply") then {
			[_obj, _value] call ace_rearm_fnc_setSupplyCount;
		};
		
		// support group
		if (isClass(configFile >> "CfgPatches" >> "SSS")) then {
			if (_key == "support_group") then {
				_customname = _obj getVariable ["ace_cargo_customname", ""];
				switch (_value) do {
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
		if (_key == "acex_field_rations_hunger") then {
			_obj setVariable ["acex_field_rations_hunger",_value , true];
		};

		//field rations thirst
		if (_key == "acex_field_rations_thirst") then {
			_obj setVariable ["acex_field_rations_thirst",_value  , true];
		};

		//markers
		if !(isnil "mapShare_fnc_stringToMarker") then {
			if (_key == "markers") then {
				if (isplayer _obj) then {
					_markers = _value;
					[_markers, 	
						{
							{
							_x call mapShare_fnc_stringToMarker;
							} forEach _this;
						}
					] remoteExec ["call", _obj];
				};
			};
		};
		//captives isHandcuffed
		if (_key == "ace_captives_isHandcuffed") then {
			[_obj, _value, objNull] call ACE_captives_fnc_setHandcuffed;
		};
		
		//stored notes
		if (_key == "GRAD_leaveNotes_stored_notes") then {
			_obj setVariable ["GRAD_leaveNotes_stored_notes",_value , true];
		};

	
		//person name
		if (_key == "person_name") then {
			_obj setname _value;
		};
		
		//person name
		if (_key == "person_rank") then {
			_obj setRank _value;
		};

		//notes and documents
		if (_key == "GRAD_leaveNotes_notesInventory") then {
			[[_obj,_x select 1], 	
				{
					params ["_obj","_notes"];
					
					{
						[(_obj getVariable ["GRAD_leaveNotes_notesHandled", 0]) + 1,"add", _x select 0, _x select 1,_x select 2] call GRAD_leaveNotes_fnc_updateMyNotes;
					} forEach _notes;
				}
			] remoteExec ["call", _obj];
		};

		//handwriting
		if (_key == "GRAD_leaveNotes_handwriting") then {
			_obj setVariable ["GRAD_leaveNotes_handwriting",_value , true];
		};

		//notes data
		if (_key == "GRAD_leaveNotes_data") then {
			_obj setVariable ["GRAD_leaveNotes_data",_value, true];
			_obj setVariable ["message", _value select 0, true];
			_obj setVariable ["handwriting", _value select 1, true];
			_obj setVariable ["type", _value select 2, true];
			[_obj] remoteExec ["GRAD_leaveNotes_fnc_initNote", 0, true];
		};

		//player stats
		if (_key == "total_KIA") then {
			_obj setVariable ["total_KIA",_value , true];
		};

		if (_key == "total_unconscious") then {
			_obj setVariable ["total_unconscious",_value , true];
		};

		if (_key == "total_kills") then {
			_obj setVariable ["total_kills",_value , true];
		};

		if (_key == "total_timespent") then {
			_obj setVariable ["total_timespent",_value , true];
		};

		if (_key == "total_missions") then {
			_obj setVariable ["total_missions",_value , true];
		};

		if (_key == "total_spent") then {
			_obj setVariable ["total_spent",_value , true];
		};
		
		if (_key == "civ_killed") then {
			_obj setVariable ["civ_killed",_value , true];
		};

		//ace cargo 
		if (_key == "ace_cargo") then {
			_cargo = _obj getVariable ["ace_cargo_loaded",[]];
			{
				[_x, _obj] call ace_cargo_fnc_removeCargoItem;
			} forEach _cargo;

			{
				_v= createVehicle [_x select 0 ,[0,0,0]];
				[_v, _x select 1] call KPLIB_fnc_setobjectextradatafromSave;

				// Clear cargo, if enabled
				[_v] call KPLIB_fnc_clearCargo;
				// Process KP object init
				[_v] call KPLIB_fnc_addObjectInit;

				_done = [_v, _obj,true] call ace_cargo_fnc_loadItem;
				if !(_done) then {
					deleteVehicle _v;
				};
				
			} forEach _value;
		};
	};
} forEach _data;