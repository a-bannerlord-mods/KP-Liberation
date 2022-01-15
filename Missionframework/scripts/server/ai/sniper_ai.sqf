params["_unit", ["_sector", ""]];



Dlos = {

    params[["_looker", objNull, [objNull]], ["_target", objNull, [objNull]], ["_FOV", 350, [0]]];
    if ([position _looker, getdir _looker, _FOV, position _target] call BIS_fnc_inAngleSector) then {
        if (count(lineIntersectsSurfaces[(AGLtoASL(_looker modelToWorldVisual(_looker selectionPosition "pilot"))), getPosASL _target, _target, _looker, true, 1, "GEOM", "NONE"]) > 0) exitWith {
            false
        };
        true
    } else {
        false
    };
};

_unit setUnitPos "MIDDLE";
_unit disableAI "PATH";

_unit disableAI "FSM";

_unit setSkill 1;
_target = objNull;
_target_shoots = 0;
while {
    alive _unit
}
do {
    _unit selectWeapon (primaryWeapon _unit);
    _Dtargets = []; {
        if ((_x distance2D _unit) < 1200 && (side _x == GRLIB_side_friendly) && (alive _x)) then {
            _unit_cansee = [_unit,_x,350] call Dlos;
            if (_unit knowsAbout _x > 1.5 && _unit_cansee) then {
                _Dtargets pushBack _x;
            };
        }
    }
    forEach allunits;

    _Tcount = count _Dtargets;
    if (_Tcount > 0) then {
        if (isnull _target || !(_target in _Dtargets) || !(alive _target) || (_target getVariable["ACE_isUnconscious", false]) ) then {
            _Target = (selectRandom _Dtargets);
            _unit enableAI "AIMINGERROR";
            _target_shoots = 0;
        };
        if (_target_shoots >(15 /(_unit knowsAbout _Target))) then {
            _unit disableAI "AIMINGERROR";
        };

        _unit doTarget _Target;
        _unit doSuppressiveFire _Target;
        uiSleep 0;
        if ([_unit, _Target] call Dlos) then {
            _unit forceWeaponFire[(currentWeapon _unit), "Single"];
        };

        _target_shoots = _target_shoots + 1;
    };

    sleep 7;
};