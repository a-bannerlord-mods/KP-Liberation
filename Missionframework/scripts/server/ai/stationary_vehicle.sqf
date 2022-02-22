params [
    ["_transVeh", objNull, [objNull]]
];


if (isNull _transVeh) exitWith {};

_crew  = crew _transVeh;
_grp = group (_crew select 0);
{
    _x setBehaviour "SAFE";
    _x moveOut _transVeh;
    _x disableAI "PATH";
    _x disableAI "MOVE";
} forEach _crew;

_transVeh engineOn false;

waitUntil { ( {behaviour _x == "COMBAT" || behaviour _x == "AWARE" }  count _crew) > 0 };
_transVeh setFuel 1;
sleep 1;
{
    _x moveInAny _transVeh;
    _x enableAI "PATH";
    _x enableAI "MOVE";
} forEach _crew;
sleep 3;
_transVeh engineOn true;

waitUntil { ( {behaviour _x == "COMBAT"}  count _crew) > 0 };

private _waypoint = _grp addWaypoint [getPos _transVeh, 200];
_waypoint setWaypointType "SAD";
_waypoint setWaypointCompletionRadius 10;
_waypoint = _grp addWaypoint [getPos _transVeh, 200];
_waypoint setWaypointType "SAD";
_waypoint setWaypointCompletionRadius 10;
_waypoint = _grp addWaypoint [getPos _transVeh, 200];
_waypoint setWaypointType "SAD";
_waypoint setWaypointCompletionRadius 10;
_waypoint = _grp addWaypoint [getPos _transVeh, 200];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 10;