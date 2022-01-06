
/*
    File: fn_isStartBase.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2019-12-11
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Gets the marker of the nearest sector from given position inside given radius.

    Parameter(s):
        _pos    - Position to look from for the nearest sector      [POSITION, defaults to getPos player]

    Returns:
        Marker of nearest sector [STRING]
	
	[_fop] call KPLIB_fnc_isStartBase;
*/

params [
    ["_pos", [0,0,0], [[]], [2, 3]]
];

(ceil (_pos select 0) == ceil((getposATL startbase) select 0)
&& ceil(_pos select 1)== ceil((getposATL startbase) select 1)
&& ceil(_pos select 2)== ceil((getposATL startbase) select 2))