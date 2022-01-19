params ["_first_objective",["_planes_number",-1],["_is_attack_chopper",false]];

if (opfor_air isEqualTo []) exitWith {false};

if (_planes_number == -1) then {
    _planes_number = ((floor linearConversion [30, 100, combat_readiness, 1, 3]) min 3) max 0;
};

if (_planes_number < 1) exitWith {};

private _class = "";
if (_is_attack_chopper) then {
    _class = selectRandom opfor_choppers;
    while {(_class in opfor_troup_transports)} do {
        _class = selectRandom opfor_choppers;
    };
    
}else{
    _opfor_air_bool =opfor_air;
    if (air_weight > 0.4) then {
        _opfor_air_bool =opfor_air arrayIntersect opfor_air_fighter;
        if ((count _opfor_air_bool)==0) then {
            _opfor_air_bool =opfor_air;
        };
    };
    _class = selectRandom _opfor_air_bool;
    while {(_class in opfor_troup_transports)} do {
        _class = selectRandom _opfor_air_bool;
    };
};

private _spawnPoint = ([sectors_airspawn, [_first_objective], {(markerPos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
if (_is_attack_chopper) then {
    _spawnPoint = ([(sectors_heliports select {!(_x in blufor_sectors)&& !(_x in active_sectors)}) , [_first_objective], {(markerpos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
} else {
    _spawnPoint = ([(sectors_airports select {!(_x in blufor_sectors) && !(_x in active_sectors)}) , [_first_objective], {(markerpos _x) distance _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
};

private _spawnPos = [];
private _plane = objNull;
private _grp = createGroup [GRLIB_side_enemy, true];

for "_i" from 1 to _planes_number do {
    _spawnPos = markerPos _spawnPoint;
    _spawnPos = [(((_spawnPos select 0) + 500) - random 1000), (((_spawnPos select 1) + 500) - random 1000), 200];
    _plane = createVehicle [_class, _spawnPos, [], 0, "FLY"];
    createVehicleCrew _plane;
    _plane flyInHeight (120 + (random 180));
    _plane addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    [_plane] call KPLIB_fnc_addObjectInit;
    {
        _x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
    } forEach (crew _plane);
    (crew _plane) joinSilent _grp;
    sleep 1;
};

while {!((waypoints _grp) isEqualTo [])} do {deleteWaypoint ((waypoints _grp) select 0);};
sleep 1;
{_x doFollow leader _grp} forEach (units _grp);
sleep 1;

private _waypoint = _grp addWaypoint [_first_objective, 500];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";

_waypoint = _grp addWaypoint [_first_objective, 500];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";

_waypoint = _grp addWaypoint [_first_objective, 500];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";

for "_i" from 1 to 6 do {
    _waypoint = _grp addWaypoint [_first_objective, 500];
    _waypoint setWaypointType "SAD";
};

_waypoint = _grp addWaypoint [_first_objective, 500];
_waypoint setWaypointType "CYCLE";

_grp setCurrentWaypoint [_grp, 2];
