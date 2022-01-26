params[["_pos", [0, 0, 0]], ["_range", worldSize]];

if (isnil "elevatedCheck") then {
    elevatedCheck = compile "
    _posHigh = _this select 0;
    _posTest = ATLtoASL _posHigh;
    _radius = _this select 1;
    if (_radius == worldSize) then {
        _posTest = ASLtoATL[worldSize / 2, worldSize / 2, 0];
        _radius = worldSize / 2
    };
    _rangeSqr = MGI_range ^ 2;
    _bestHigh = _posTest select 2;
    _n = (round _radius) min(worldSize / 10);
    _c = _radius / (sqrt(_n - 1));
    for '_i'
    from _n to 0 step - 1 do {
            _rho = _c * sqrt(_i + 0.5);
            _theta = 137.508 * (_i + 0.5);
            _ckPos = _posTest getPos[_rho, _theta];
            call {
                if (_ckPos distanceSqr MGI_posRef > _rangeSqr) exitWith {};
                if ((getTerrainHeightASL _ckPos) > _bestHigh) exitWith {
                    _posHigh = ASLtoATL _ckPos;
                    _bestHigh = getTerrainHeightASL _ckPos
                };
            };
        };
        _posHigh ";
};


MGI_posRef = _pos;
MGI_range = _range;
_posHigh = [_pos, _range] call elevatedCheck;
_posHigh = [_posHigh, _range / 10] call elevatedCheck;
_posHigh