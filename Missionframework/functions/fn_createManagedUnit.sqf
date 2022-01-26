/*
    File: fn_createManagedUnit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-10-04
    Last Update: 2019-12-04
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Creates unit managed by kill tracker.

    Parameter(s):
        _type       - Type of unit              [STRING, defaults to ""]
        _spawnPos   - Where to spawn            [ARRAY|OBJECT|GROUP, defaults to [0, 0, 0]]
        _group      - Group to add the unit to  [GROUP, defaults to grpNull]
        _rank       - Unit rank                 [STRING, defaults to "PRIVATE"]
        _placement  - Placement radius          [NUMBER, defaults to 0]

    Returns:
        Created unit [OBJECT]
*/

params [
    ["_type", "", [""]],
    ["_spawnPos", [0, 0, 0], [[], objNull, grpNull], [2, 3]],
    ["_group", grpNull, [grpNull]],
    ["_rank", "PRIVATE", [""]],
    ["_placement", 0, [0]]
];


private ["_unit"];
isNil {
    // Create temp group, as we need to let the unit join the "correct side group".
    // If we use the "correct side group" for the createUnit, the group would switch to the side of the unit written in the config.
    private _groupTemp = createGroup [CIVILIAN, true];

    _unit = _groupTemp createUnit [_type, _spawnPos, [], _placement, "FORM"];
    _unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    _unit setRank _rank;

      // Process KP object init
    _unit spawn {
            sleep 1;
            [_this] call KPLIB_fnc_applyCustomUnitSettings;
            [_this] call KPLIB_fnc_addObjectInit;
        };

    [_unit] remoteExec ["KPLIB_fnc_applyUnitAnimations", [0, -2] select isDedicated , _unit];

    _unit setVariable ["original_side",side _group];
    if ((tolower _type ) in KPLIB_o_inf_classes ) then {
        _unit setVariable ["intel_value",random [1,2,3],true];
    };
    if ((tolower _type ) in KPLIB_o_sf_classes ) then {
        _unit setVariable ["intel_value",random [3,4,5],true];
    };
    if ((tolower _type ) == tolower opfor_team_leader) then {
        _unit setVariable ["intel_value",random [3,4,5],true];
    };
    if ((tolower _type ) == tolower opfor_squad_leader) then {
        _unit setVariable ["intel_value",random [5,6,7],true];
    };
    if ((tolower _type ) == tolower opfor_officer) then {
        _unit setVariable ["intel_value",10,true];
    };
    if ((tolower _type ) in (civilians apply{toLower _x})) then {
        _unit setVariable ["intel_value",random [-5,-8,-10],true];
    };
    // Join to target group to preserve Side
    [_unit] joinSilent _group;
    deleteGroup _groupTemp;
};

_unit
