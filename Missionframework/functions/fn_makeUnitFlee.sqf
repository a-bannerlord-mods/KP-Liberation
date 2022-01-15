/*
    File: fn_setUnitTraits.sqf
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
//[_unit] call KPLIB_fnc_makeUnitFlee
params [
    "_unit",
    ["_sector",""]
];


_unit setVariable ["fleeing",true,true];

flee_run = {
    params [
    "_unit",
    ["_sector",""]
    ];
    if (_sector == "") then {
    _sector = [500, getPos _unit] call KPLIB_fnc_getNearestSector;
    };
    _sectors = sectors_military - blufor_sectors - [_sector];

    _fleeSector = [5000, getPos _unit , _sectors ] call KPLIB_fnc_getNearestSectorOfType;

    if (_fleeSector=="") then {
        _sectors = sectors_allSectors - blufor_sectors - [_sector];
        _fleeSector = [9000, getPos _unit , _sectors ] call KPLIB_fnc_getNearestSectorOfType;
    };

    if (vehicle _unit != _unit) then {
        _unit leaveVehicle (vehicle _unit)
    };
    _unit enableAI "PATH";
    _unit enableAI "MOVE"; 
    _unit disableAI "AUTOTARGET";


    doStop _unit;

    _g  = (createGroup [GRLIB_side_enemy, true]);
    _unit joinAsSilent [_g,0];

    _unit doMove getMarkerPos _fleeSector;

    _unit setspeedmode "FULL";

    _unit setbehaviour "SAFE";

    _unit setskill ["spotDistance",0.1];

    _unit setskill ["spotTime",0.1];

    _unit setskill ["courage",1];

    _unit setskill ["commanding",0.1];

    _unit setskill ["general",0.1];


    sleep 60; 

    waitUntil { headgear _unit != "mgsr_headbag" && goggles _unit != "mgsr_headbag_goggles" &&  count ((allPlayers) select {(_x distance _unit) <12 }) == 0 };
    [_unit, false] call ACE_captives_fnc_setHandcuffed;
    _unit setCaptive false;

    [_unit,_sector] spawn flee_run;

    
};

removeAllWeapons _unit;


// _unit addEventHandler ["FiredNear", {
// 	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
//     if (side _firer != side _unit) then {
//         [ _unit , true, false ] spawn prisonner_ai;
//     };
// }];

_unit addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];
    if (side _instigator != side _unit) then {
            [ _unit , true, false ] spawn prisonner_ai;
    };
}];

[_unit,_sector] spawn flee_run;
