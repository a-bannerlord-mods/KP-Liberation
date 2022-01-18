params [
    ["_grp", grpNull, [grpNull]],
    ["_pointToAttack", [0, 0, 0], [[]], [2, 3]]
];

if (isNull _grp) exitWith {};
if (isNil "reset_battlegroups_ai") then {reset_battlegroups_ai = false};

sleep (5 + (random 5));

private _objPos = [0,0,0];

if (_pointToAttack isEqualTo [0,0,0]) then {
    _objPos = [getPos (leader _grp)] call KPLIB_fnc_getNearestBluforObjective;
} else {
    _objPos = _pointToAttack;
};

[_objPos] remoteExec ["remote_call_incoming"];

private _startpos = getPos (leader _grp);

private _waypoint = [];
while {((getPos (leader _grp)) distance _startpos) < 100} do {

    while {!((waypoints _grp) isEqualTo [])} do {deleteWaypoint ((waypoints _grp) select 0);};
    {_x doFollow leader _grp} forEach units _grp;

    _startpos = getPos (leader _grp);

    _waypoint = _grp addWaypoint [_objPos, 300];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointSpeed "NORMAL";
    if (vehicle (leader _grp) == leader _grp) then {
        _waypoint setWaypointBehaviour "AWARE";
    } else {
        _waypoint setWaypointBehaviour "SAFE";
    };
    _waypoint setWaypointCombatMode "YELLOW";
    _waypoint setWaypointCompletionRadius 30;

    _waypoint = _grp addWaypoint [_objPos, 100];
    _waypoint setWaypointType "SAD";
    _waypoint = _grp addWaypoint [_objPos, 100];
    _waypoint setWaypointType "SAD";
    _waypoint = _grp addWaypoint [_objPos, 100];
    _waypoint setWaypointType "SAD";
    _waypoint = _grp addWaypoint [_objPos, 100];
    _waypoint setWaypointType "CYCLE";

    sleep 50;
};

waitUntil {
    sleep 5;
    (((units _grp) select {alive _x}) isEqualTo []) || reset_battlegroups_ai
};

sleep (5 + (random 5));
reset_battlegroups_ai = false;

if (!((units _grp) isEqualTo []) && (GRLIB_endgame == 0)) then {
    [_grp,_pointToAttack] spawn battlegroup_ai;
};
