/*
    File: fn_spawnCivilians.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2020-04-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Spawns civilians at given sector.

    Parameter(s):
        _sector - Sector to spawn the civilians at [STRING, defaults to ""]

    Returns:
        Spawned civilian units [ARRAY]
*/

params [
    ["_sector", "", [""]],
    ["_buildingPos", []]
];

if (_sector isEqualTo "") exitWith {["Empty string given"] call BIS_fnc_error; []};

private _civs = [];
private _sPos = markerPos _sector;

// Amount and spread depending if capital or city/factory
private _amount = round ((3 + (floor (random 7))) * GRLIB_civilian_activity);
private _spread = 1;
if (_sector in sectors_bigtown) then {
    _amount = _amount + 10;
    _spread = 2.5;
};
_amount = _amount * (sqrt (GRLIB_unitcap));

// Spawn civilians
private _grp = grpNull;
for "_i" from 1 to _amount do {
    _grp = createGroup [GRLIB_side_civilian, true];

    _civs pushBack (
        [
            selectRandom civilians,
            [(((_sPos select 0) + (75 * _spread)) - (random (150 * _spread))), (((_sPos select 1) + (75 * _spread)) - (random (150 * _spread))), 0],
            _grp
        ] call KPLIB_fnc_createManagedUnit
    );

    [_grp,_buildingPos] call add_civ_waypoints;
};

for "_i" from 1 to (ceil(_amount/2)) do {
    if ((count _buildingPos) > 0 ) then {
        _grp = createGroup [GRLIB_side_civilian, true];
        _pos = selectrandom  _buildingPos;
        _civ = [selectRandom civilians,_pos, _grp] call KPLIB_fnc_createManagedUnit;

        _civ disableAI "PATH";

        _buildingPos = _buildingPos - [_pos];
        _civs pushBack _civ;
    };
};

if (KP_liberation_civ_rep < -20) then {
    if (random 50 < (KP_liberation_civ_rep*-1)) then {
        _grp = createGroup [GRLIB_side_civilian, true];
        _suicide_bomber = (
                [
                    selectRandom civilians,
                    [(((_sPos select 0) + (75 * _spread)) - (random (150 * _spread))), (((_sPos select 1) + (75 * _spread)) - (random (150 * _spread))), 0],
                    _grp
                ] call KPLIB_fnc_createManagedUnit
            );
        _suicide_bomber setVariable ["lambs_danger_disableAI", true,true];
        [_suicide_bomber,10,false,true] spawn suicide_bomber;
        _civs pushBack  _suicide_bomber;
    };
};

if (KP_liberation_civ_rep < -60) then {
    if (random 90 < (KP_liberation_civ_rep*-1)) then {
        _grp = createGroup [GRLIB_side_civilian, true];
        _suicide_bomber = (
                [
                    selectRandom civilians,
                    [(((_sPos select 0) + (75 * _spread)) - (random (150 * _spread))), (((_sPos select 1) + (75 * _spread)) - (random (150 * _spread))), 0],
                    _grp
                ] call KPLIB_fnc_createManagedUnit
            );
        _suicide_bomber setVariable ["lambs_danger_disableAI", true,true];
        [_suicide_bomber,10,false,true] spawn suicide_bomber;
        _civs pushBack  _suicide_bomber;
    };
};

if (KP_liberation_civ_rep < -90) then {
    if (random 150 < (KP_liberation_civ_rep*-1)) then {
        _grp = createGroup [GRLIB_side_civilian, true];
        _suicide_bomber = (
                [
                    selectRandom civilians,
                    [(((_sPos select 0) + (75 * _spread)) - (random (150 * _spread))), (((_sPos select 1) + (75 * _spread)) - (random (150 * _spread))), 0],
                    _grp
                ] call KPLIB_fnc_createManagedUnit
            );
        _suicide_bomber setVariable ["lambs_danger_disableAI", true,true];
        [_suicide_bomber,10,false,true] spawn suicide_bomber;
        _civs pushBack  _suicide_bomber;
    };
};

_civs
