/*
    File: fn_getUnitsCount.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2020-05-08
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Gets the amount of units of given side inside given radius of given position.

    Parameter(s):
        _pos - Description [POSITION, defaults to [0, 0, 0]
        _radius - Description [NUMBER, defaults to 100]
        _side - Description [SIDE, defaults to GRLIB_side_friendly]

    Returns:
        Amount of units [NUMBER]
*/

params [
    ["_pos", [0, 0, 0], [[]], [2, 3]],
    ["_radius", 100, [0]],
    ["_side", GRLIB_side_friendly, [sideEmpty]],
    ["_sector",""]
];

if (_sector!="") then {
    if (_sector in sectors_longRange) then {
        _radius = _radius * GRLIB_long_range_sector_spawn_radius_multiplier;
    };
    if (_sector in sectors_heavyArtillery && combat_readiness > RydFFE_Heavy_Artillery_Enable_On_Combat_Readiness_Above) then {
        _radius = _radius * 3;
    };
};

private _amount = _side countSide ((_pos nearEntities ["Man", _radius]) select {!(captive _x) && ((getpos _x) select 2 < 800)});
{
    _amount = _amount + (_side countSide (crew _x));
} forEach ((_pos nearEntities [["Car", "Tank", "Air", "Boat"], _radius]) select {((getpos _x) select 2 < 800) && count (crew _x) > 0});

//civ  players
if (_side ==GRLIB_side_friendly) then {
    _amount = _amount + (civilian countSide ((_pos nearEntities ["Man", _radius]) select {isplayer _x  && ((getpos _x) select 2 < 800)}));
};

_amount