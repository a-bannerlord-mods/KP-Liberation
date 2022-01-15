params["_unit", "_sniper", ["_sector", ""]];


_unit setUnitPos "MIDDLE";
_unit disableAI "PATH";
_unit addWeapon "Binocular";
_unit disableAI "FSM";

_unit setSkill 1;
_target = objNull;
_target_shoots = 0;
while {
    alive _unit && alive _sniper
}
do {

    _Dtargets = []; {
        if ((_x distance2D _unit) < 100 && (side _x == GRLIB_side_friendly) && (alive _x)) then {
            _Dtargets pushBack _x;
        }
    }
    forEach allunits;
    if (count _Dtargets == 0) then {
        _unit selectWeapon "Binocular";
        _target = assignedTarget _sniper;
        if !(isNull _target) then {
            _unit doTarget _target;
            _unit doWatch _target;
        } else {
            _unit doWatch(getMarkerPos _sector);
        };

    } else {
        _unit selectWeapon (primaryWeapon _unit);
    };
    sleep 7;
};

_unit selectWeapon(primaryWeapon _unit);
_unit enableAI "PATH";
_unit enableAI "FSM";
_unit setUnitPos "AUTO";