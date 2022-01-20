/* 
	File: fn_forceBluforCrew.sqf 
	Author: KP Liberation Dev Team - https://github.com/KillahPotatoes 
	Date: 2019-11-25 
	Last Update: 2019-12-04 
	License: MIT License - http://www.opensource.org/licenses/MIT 
 
	Description: 
		Creates vehicle crew from vehicle config. 
		If the crew isn't the same side as the players, it'll create a player side crew. 
 
	Parameter(s): 
		_veh - Vehicle to add the blufor crew to [OBJECT, defaults to objNull] 
 
	Returns: 
		Function reached the end [BOOL] 
*/

params[
    ["_veh", objNull, [objNull]]
];

set_random_crew_name = {
    params["_unit", "_fnames", "_snames"];
    _firstname = selectRandom _fnames;
    _secoundname = selectRandom _snames;
    if (_firstname != _secoundname) then {
        _unit setName[_firstname + " " + _secoundname, _firstname, _secoundname];
    } else {
        _unit call set_random_crew_name;
    };
};

if (isNull _veh) exitWith {
    ["Null object given"] call BIS_fnc_error;
    false
};

// Create regular config crew 
private _grp = createVehicleCrew _veh;

// If the config crew isn't the correct side, replace it with the crew classnames from the preset 
if ((side _grp) != GRLIB_side_friendly) then {
    {
        deleteVehicle _x
    }
    forEach(units _grp);

    _grp = createGroup[GRLIB_side_friendly, true];
    while {
        count units _grp < 3
    }
    do {
        [crewman_classname, getPos _veh, _grp] call KPLIB_fnc_createManagedUnit;
    };
    ((units _grp) select 0)
    moveInDriver _veh;
    ((units _grp) select 1) moveInGunner _veh;
    ((units _grp) select 2) moveInCommander _veh;

    // Delete crew which isn't in the vehicle due to e.g. no commander seat 
    {
        if (isNull objectParent _x) then {
            deleteVehicle _x
        };
    }
    forEach(units _grp);
};

{
    _unit = _x;
    if !(isplayer _unit) then {
        _loadout = [];
        if ((!isnil "KPLIB_Units_Override_tank_crew_Loadout") && _veh isKindOf "Tank") then {
            _loadout = KPLIB_Units_Override_tank_crew_Loadout;
        }else{
            _loadout = KPLIB_Units_Override_car_crew_Loadout;
        };

        
        if (count _loadout > 0) then {
            _unit setUnitLoadout _loadout;
        };
        
        if (!isnil "KPLIB_Units_Override_crew_Names") then {
            _fnames = KPLIB_Units_Override_crew_Names select 0;
            _snames = KPLIB_Units_Override_crew_Names select 1;
            if (count _fnames > 0 && count _snames > 0) then {
                [_unit, _fnames, _snames] call set_random_crew_name;
            };
        };
    };
    

}
forEach(units _grp);

// Set the crew to safe behaviour 
_grp setBehaviour "SAFE";

true