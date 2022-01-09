/*
    File: fn_spawnBuildingSquad.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2020-04-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Spawns given amount of infantry in buildings of given sector at given building positions.

    Parameter(s):
        _type       - Type of infantry. Either "militia" or "army"  [STRING, defaults to "army"]
        _amount     - Amount of infantry units to spawn             [NUMBER, defaults to 0]
        _positions  - Array of building positions                   [ARRAY, defaults to []]
        _sector     - Sector where to spawn the units               [STRING, defaults to ""]

    Returns:
        Spawned units [ARRAY]
*/

params [
    ["_cache", []]
];


private _units = [];

// Spawn units
_grp = createGroup [GRLIB_side_enemy, true];
{

    private _pos = _x select 0;
    private _unit = objNull;
        // Create new group, if current group has 10 units
    if (count (units _grp) >= 10) then {
        _grp = createGroup [GRLIB_side_enemy, true];
    };
    _unit = [_x select 1, _pos, _grp] call KPLIB_fnc_createManagedUnit;
    _unit setDir (random 360);
    [_unit, _sector] spawn building_defence_ai;
    _units pushBack _unit;

} forEach _cache;



_units
