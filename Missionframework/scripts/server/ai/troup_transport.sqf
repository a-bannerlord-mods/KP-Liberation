params [
    ["_transVeh", objNull, [objNull]],
    ["_pointToAttack", [0, 0, 0], [[]], [2, 3]]
];

if (isNull _transVeh) exitWith {};
sleep 1;

private _transGrp = (group (driver _transVeh));
private _start_pos = getpos _transVeh;
private _objPos =  [0,0,0];
if (_pointToAttack isEqualTo [0,0,0]) then {
    _objPos =[getpos _transVeh] call KPLIB_fnc_getNearestBluforObjective;
} else {
    _objPos = _pointToAttack;
};
private _unload_distance = 400;
private _crewcount = count crew _transVeh;

if (count((typeof _transVeh) call bis_fnc_allTurrets) > 0) then{
    _unload_distance = 150;
};

if ((alive _transVeh) && (alive (driver _transVeh))) then {
    _infGrp = createGroup [GRLIB_side_enemy, true];
    _type= "";
    if (combat_readiness > 60) then {
        _type = "specialForces";
    } else {
        _type = "army";
    };
    {
        [_x, _start_pos, _infGrp, "PRIVATE", 0.5] call KPLIB_fnc_createManagedUnit;
    } foreach ([_type] call KPLIB_fnc_getSquadComp);


    while {(count (waypoints _infGrp)) != 0} do {deleteWaypoint ((waypoints _infGrp) select 0);};

    {_x moveInCargo _transVeh} forEach (units _infGrp);


    sleep 3;

    private _transVehWp =  _transGrp addWaypoint [_objPos, 50];
    _transVehWp setWaypointType "MOVE";
    _transVehWp setWaypointSpeed "NORMAL";
    _transVehWp setWaypointBehaviour "SAFE";
    _transVehWp setWaypointCombatMode "YELLOW";
    _transVehWp setWaypointCompletionRadius 80;
    

    waitUntil {
    sleep 0.2;
    !(alive _transVeh) ||
    !(alive (driver _transVeh)) ||
    (((_transVeh distance _objPos) < _unload_distance) && !(surfaceIsWater (getpos _transVeh)))
    || (damage _transVeh > 0.2 )
    };

    deleteWaypoint [_transGrp,0];

    {unassignVehicle _x} forEach (units _infGrp);
    if (count((typeof _transVeh) call bis_fnc_allTurrets) > 0) then {
        [_transGrp,_objPos] spawn battlegroup_ai;
    } else {
        {unassignVehicle _x;} forEach (units _transGrp);
        (units _transGrp) joinSilent _infGrp;
    };

    _infGrp leaveVehicle _transVeh;
    (units _infGrp) allowGetIn false;

    [_infGrp,_objPos] spawn battlegroup_ai;
};
