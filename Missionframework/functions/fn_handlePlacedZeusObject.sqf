/*
    File: fn_handlePlacedZeusObject.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-11
    Last Update: 2020-04-25
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Applies all KP Liberation values and functionalities for crates, units and vehicles.

    Parameter(s):
        _obj - Object to add the functionalities and values to [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/
params [
    ["_obj", objNull, [objNull]]
];
//fix bug its not working
set_random_unit_name = {
    params["_unit", "_fnames", "_snames"];
    _firstname = selectRandom _fnames;
    _secoundname = selectRandom _snames;
    if (_firstname != _secoundname) then {
        _unit setName[_firstname + " " + _secoundname, _firstname, _secoundname];
    } else {
        _unit call set_random_unit_name;
    };
};

// Identify kind of placed object once
private _unit = _obj in allUnits;
private _vehicle = _obj in vehicles;
private _crate = (toLower (typeOf _obj)) in KPLIB_crates;

// Exit if building and no resource crate
if !(_unit || _vehicle || _crate) exitWith {false};

// For a vehicle apply clear cargo
if (_vehicle) then {
    [_obj] call KPLIB_fnc_clearCargo;
    if (side _obj == GRLIB_side_friendly) then {
        if (((_obj isKindOf "Tank") || (_obj isKindOf "Car")) && tolower(typeof _obj) != KP_liberation_civ_car_classname) then {
                _obj forceFlagtexture blufor_flag_texture;
            };
    }else{
        if ((_obj isKindOf "Tank")|| (_obj isKindOf "Car")) then {
                    if (typeOf _obj in  militia_vehicles) then {
                        _obj forceFlagtexture opfor_flag_militia_texture;
                    } else {
                        _obj forceFlagtexture opfor_flag_texture;
                    };
            };
    };
    // Add kill manager and object init to possible crew units
    {
        _x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
        [_x] call KPLIB_fnc_addObjectInit;

        if (side _x == GRLIB_side_friendly) then {
            _unit = _x;
            _loadout = [];
            if ((!isnil "KPLIB_Units_Override_car_crew_Loadout") && _obj isKindOf "Car") then {
                _loadout = KPLIB_Units_Override_car_crew_Loadout;
            };
            if ((!isnil "KPLIB_Units_Override_tank_crew_Loadout") && _obj isKindOf "Tank") then {
                _loadout = KPLIB_Units_Override_tank_crew_Loadout;
            };

            if (count _loadout > 0) then {
                _unit setUnitLoadout _loadout;
            };

            _fnames = KPLIB_Units_Override_crew_Names select 0;
            _snames = KPLIB_Units_Override_crew_Names select 1;
            if (count _fnames > 0 && count _snames > 0) then {
                [_unit, _fnames, _snames] call set_random_unit_name;
            };

        }else{
            [_x] call KPLIB_fnc_applyCustomUnitSettings;
        };

    } forEach (crew _obj);

    for "_i" from 1 to 100 do { 
        _obj setPylonLoadout [_i, "", true]; 
    };

    _obj setVehicleAmmo 0;
    _ace_rearm_storage = getNumber (configFile >> "CfgVehicles" >>  typeof _obj >> "ace_rearm_defaultSupply");
    if (_ace_rearm_storage>0) then {
        [_obj, 0] call ace_rearm_fnc_setSupplyCount;
    };
    if (getNumber (configFile >> "CfgVehicles" >> typeof _obj >> "ace_refuel_fuelCargo") > 0) then {
        [_obj, 0] call ace_refuel_fnc_setFuel;
    };
};

// Apply kill manager, if it's not a crate
if !(_crate) then {
    _obj addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
} else {
    // Otherwise apply all needed values/functionalities
    _obj setMass 500;
    _obj setVariable ["KP_liberation_crate_value", 100, true];
    [_obj, true] call KPLIB_fnc_clearCargo;
    if (KP_liberation_ace) then {[_obj, true, [0, 1.5, 0], 0] remoteExec ["ace_dragging_fnc_setCarryable"];};
};

[_obj] spawn {
    params [
        ["_obj", objNull, [objNull]]
    ];
    sleep 3;
    [_obj] call KPLIB_fnc_applyCustomUnitSettings;
};



// Add object init codes
[_obj] call KPLIB_fnc_addObjectInit;

true
