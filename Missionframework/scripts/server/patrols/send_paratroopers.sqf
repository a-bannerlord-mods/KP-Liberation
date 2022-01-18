params [
    ["_targetsector", "", ["",[]]],
    ["_chopper_type", objNull, [objNull]],
    ["_isPlane",false]
];

if (_targetsector isEqualTo "" || opfor_choppers isEqualTo []) exitWith {false};

private _targetpos = _targetsector;
if (_targetpos isEqualType "") then {
    _targetpos = markerPos _targetsector;
};

private _spawnsector = ([sectors_airspawn, [_targetpos], {(markerpos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
if (_isPlane) then {
    _spawnsector = ([(sectors_airports select {!(_x in blufor_sectors)&& !(_x in active_sectors)}) , [_targetpos], {(markerpos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
} else {
    _spawnsector = ([(sectors_heliports select {!(_x in blufor_sectors) && !(_x in active_sectors)}) , [_targetpos], {(markerpos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
};


private _newvehicle = objNull;
private _pilot_group = grpNull;
private _flyInHeight = 100;
if (typename _chopper_type != "STRING" && isNull _chopper_type) then {
    if (_isPlane) then {
        _chopper_type = selectRandom (opfor_air arrayIntersect opfor_troup_transports);
        _flyInHeight = 500;
    } else {
        _chopper_type = selectRandom (opfor_choppers arrayIntersect opfor_troup_transports);
        while {!(_chopper_type in opfor_troup_transports)} do {
            _chopper_type = selectRandom opfor_choppers;
        };
    };


    _newvehicle = createVehicle [_chopper_type, markerpos _spawnsector, [], 0, "FLY"];
    createVehicleCrew _newvehicle;
    sleep 0.1;

    _pilot_group = createGroup [GRLIB_side_enemy, true];
    (crew _newvehicle) joinSilent _pilot_group;

    _newvehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    {_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];} forEach (crew _newvehicle);
} else {
    _newvehicle = _chopper_type;
    _pilot_group = group _newvehicle;
};

private _para_group = createGroup [GRLIB_side_enemy, true];

while {(count (units _para_group)) < 8} do {
    [opfor_paratrooper, markerPos _spawnsector, _para_group] call KPLIB_fnc_createManagedUnit;
};



while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
sleep 0.2;
{_x doFollow leader _pilot_group} forEach units _pilot_group;
{_x doFollow leader _para_group} forEach units _para_group;
sleep 0.2;

{removeBackpack _x; _x addBackPack "B_parachute"; _x moveInCargo _newvehicle;} forEach (units _para_group);

sleep 0.2;

_newvehicle flyInHeight _flyInHeight;

_waypoint = _pilot_group addWaypoint [_targetpos, 25];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 25];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 700];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 700];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;
_waypoint = _pilot_group addWaypoint [_targetpos, 700];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;
_pilot_group setCurrentWaypoint [_pilot_group, 1];

_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointCompletionRadius 50;
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 50;
_pilot_group setCurrentWaypoint [_para_group, 1];

_newvehicle flyInHeight _flyInHeight;

_distToJump = 300;
if (_isPlane) then {
    _distToJump = 500;
} else {
    _distToJump = 300;
};

waitUntil {sleep 1;
    !(alive _newvehicle) || (damage _newvehicle > 0.2 ) || (_newvehicle distance2d _targetpos < _distToJump)
};

_newvehicle flyInHeight _flyInHeight;

{
    unassignVehicle _x;
    moveout _x;
    if (_isPlane) then {
        sleep 0.2;
    } else {
        sleep 0.5;
    };
    
} forEach (units _para_group);

_newvehicle flyInHeight _flyInHeight;

sleep 0.2;
while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
sleep 0.2;
{_x doFollow leader _pilot_group} foreach units _pilot_group;
{_x doFollow leader _para_group} foreach units _para_group;
sleep 0.2;

_completionRadius = 100;
if (count((typeof _newvehicle) call bis_fnc_allTurrets) >  1) then {
    _newvehicle flyInHeight _flyInHeight;
    _completionRadius = 100;
    _waypoint = _pilot_group addWaypoint [_targetpos, 200];
    _waypoint setWaypointBehaviour "COMBAT";
    _waypoint setWaypointCombatMode "RED";
    _waypoint setWaypointType "SAD";
    _waypoint setWaypointCompletionRadius _completionRadius;
    _waypoint = _pilot_group addWaypoint [_targetpos, 200];
    _waypoint setWaypointBehaviour "COMBAT";
    _waypoint setWaypointCombatMode "RED";
    _waypoint setWaypointType "SAD";
    _waypoint setWaypointCompletionRadius _completionRadius;
    _waypoint = _pilot_group addWaypoint [_targetpos, 200];
    _waypoint setWaypointBehaviour "COMBAT";
    _waypoint setWaypointCombatMode "RED";
    _waypoint setWaypointType "SAD";
    _waypoint setWaypointCompletionRadius _completionRadius;
    _waypoint = _pilot_group addWaypoint [_targetpos, 200];
    _waypoint setWaypointType "SAD";
    _waypoint setWaypointCompletionRadius _completionRadius;
    _waypoint = _pilot_group addWaypoint [_targetpos, 200];
    _waypoint setWaypointBehaviour "COMBAT";
    _waypoint setWaypointCombatMode "RED";
    _waypoint setWaypointType "CYCLE";

    _pilot_group setCurrentWaypoint [_pilot_group, 1];
} else {
    _newvehicle flyInHeight (_flyInHeight*1.5);
    _completionRadius = 200;
    _waypoint = _pilot_group addWaypoint [getMarkerPos _spawnsector, 100];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointSpeed "FULL";
    _waypoint setWaypointBehaviour "CARELESS";
    _waypoint setWaypointCombatMode "BLUE";
    _waypoint setWaypointCompletionRadius _completionRadius;
    _pilot_group setCurrentWaypoint [_pilot_group, 1];
};


_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_waypoint = _para_group addWaypoint [_targetpos, 100];
_waypoint setWaypointType "SAD";
_pilot_group setCurrentWaypoint [_para_group, 1];


waitUntil {sleep 1;
    !(alive _newvehicle) || (_newvehicle distance2d (getMarkerPos _spawnsector) < 200)
};


{
    deleteVehicle _x;
} forEach (crew _newvehicle);
deleteVehicle _newvehicle;