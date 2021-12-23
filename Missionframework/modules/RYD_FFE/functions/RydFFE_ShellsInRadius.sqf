private["_center", "_radius", "_shells", "_inRange", "_pos1", "_shell", "_pos2"];

_center = _this select 0;
_radius = _this select 1;

_pos1 = [_center select 0, _center select 1, 0];

_shells = missionnamespace getVariable["RydFFE_firedShells", []];

_inRange = [];

{
    _shell = _x;
    if not(isnil "_shell") then {
        if not(isNull _x) then {
            _pos2 = getPosASL _x;
            _pos2 = [_pos2 select 0, _pos2 select 1, 0];
            
            if ((_pos1 distance _pos2) < _radius) then {
                _inRange set[(count _inRange), _x]
            }
        }
    }
}
forEach _shells;

_inRange