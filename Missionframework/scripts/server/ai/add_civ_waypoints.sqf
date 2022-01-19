private _grp = _this select 0;
private _buildingPos = _this select 1;
private _basepos = getpos (leader _grp);

while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
{_x doFollow leader _grp} foreach units _grp;

private _wpPositions = [
    _basepos getPos [random 150, random 360],
    _basepos getPos [random 150, random 360],
    _basepos getPos [random 150, random 360],
    _basepos getPos [random 150, random 360],
    _basepos getPos [random 150, random 360]
];

if ((count _buildingPos) >10) then {
    _wpPositions = [
        selectrandom _buildingPos,
        selectrandom _buildingPos,
        selectrandom _buildingPos,
        selectrandom _buildingPos,
        selectrandom _buildingPos
    ];
};

{
    private _waypoint = _grp addWaypoint [_x, 10];
    if (_forEachIndex == ((count _wpPositions) - 1)) then {
        _waypoint setWaypointType "CYCLE";
    } else {
        _waypoint setWaypointType "MOVE";
    };
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointSpeed "LIMITED";
    _waypoint setWaypointCombatMode "BLUE";
    _waypoint setWaypointCompletionRadius 5;
} forEach _wpPositions;
