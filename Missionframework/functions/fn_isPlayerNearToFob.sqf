/*
    File: fn_isPlayerNearToFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-12-03
    Last Update: 2019-12-11
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Gets the marker of the nearest sector from given position inside given radius.

    Parameter(s):
        _radius - Radius in which to look for the nearest sector    [NUMBER, defaults to 1000]
        _pos    - Position to look from for the nearest sector      [POSITION, defaults to getPos player]

    Returns:
        Marker of nearest sector [STRING]
		[_player,1] call  KPLIB_fnc_isPlayerNearToFob;
		
*/

params [
    ["_player",  player],
	["_rangeMultib", 1]
];

_KPLIB_fobPos = _player getVariable ['KPLIB_fobPos', [0,0,0]];

if ([_KPLIB_fobPos] call  KPLIB_fnc_isStartBase ) then {
    if (getMarkerType "startbase_range" == "") then {
              _player getVariable ['KPLIB_fobDist', 99999] < (GRLIB_base_range * _rangeMultib)
        } else {
                _player inArea "startbase_range";
        };
	

} else {
	_player getVariable ['KPLIB_fobDist', 99999] < (GRLIB_fob_range * _rangeMultib)
};

