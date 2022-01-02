
/*
    File: fn_getBuildingRooftopPositions.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-11-25
    Last Update: 2019-11-25
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Returns list if rooftop positions on certin houses.

    Parameter(s):
        _positions

    Returns:
        ARRAY
*/

params ["_positions"];
_ontop= [];


_positions = [_positions, [], {
    _x select 2;
}, "DESCENDING", {}] call BIS_fnc_sortBy;


{
    if (_x select 2 >3) then {
        private _position = AGLtoASL _x;
        private _checkPos = +_position;
        _checkPos set[2, (_checkpos select 2) + 10];
        if (count lineIntersectsSurfaces[_position, _checkPos] == 0) then {
            _pos = (ASLtoAGL _position);
            _ontop pushBack _pos;
        };
    };
}
forEach _positions;

_ontop