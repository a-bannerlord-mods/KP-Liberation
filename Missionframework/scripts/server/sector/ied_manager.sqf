params ["_sector", "_radius", "_number"];

if (_number <= 0) exitWith {};

if (KP_liberation_asymmetric_debug > 0) then {[format ["ied_manager.sqf for %1 spawned on: %2", markerText _sector, debug_source], "ASYMMETRIC"] remoteExecCall ["KPLIB_fnc_log", 2];};

_number = round _number;

private _activation_radius_infantry = 6.66;
private _activation_radius_vehicles = 10;

private _spread = 6;
private _infantry_trigger = 1 + (ceil (random 2));
private _ultra_strong = false;
if (random 100 < 12) then {
    _ultra_strong = true;
};
private _vehicle_trigger = 1;
private _ied_type= selectRandom ["ACE_IEDLandSmall_Range_Ammo","ACE_IEDUrbanSmall_Range_Ammo","ACE_IEDLandBig_Range_Ammo","ACE_IEDUrbanBig_Range_Ammo"];
//private _ied_type = selectRandom ["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F"];
private _ied_obj = objNull;
private _roadobj = [(markerPos _sector) getPos [random _radius, random 360], _radius, []] call BIS_fnc_nearestRoad;
private _goes_boom = false;
private _ied_marker = "";

if (KP_liberation_asymmetric_debug > 0) then {[format ["ied_manager.sqf -> spawning IED %1 at %2", _number, markerText _sector], "ASYMMETRIC"] remoteExecCall ["KPLIB_fnc_log", 2];};

if (_number > 0) then {
    [_sector, _radius, _number - 1] spawn ied_manager;
};

if (!(isnull _roadobj)) then {
    _dis = (random _spread) max 3;
    _roadpos = getpos _roadobj;
    //_ied_obj = createMine [_ied_type, _roadpos getPos [_spread, random 360], [], 0];
    _ied_obj = _ied_type createVehicle (_roadpos getPos [_dis ,90]);
    _ied_obj2 = _ied_type createVehicle (_roadpos);
    _ied_obj3 = _ied_type createVehicle (_roadpos getPos [_dis, 270]);

    _ied_obj setdir (random 360);
     east revealMine _ied_obj; //Red force
     civilian revealMine _ied_obj; //Civ population
     resistance revealMine _ied_obj; //Green force

     east revealMine _ied_obj2; //Red force
     civilian revealMine _ied_obj2; //Civ population
     resistance revealMine _ied_obj2; //Green force

     east revealMine _ied_obj3; //Red force
     civilian revealMine _ied_obj3; //Civ population
     resistance revealMine _ied_obj3; //Green force

    if (KP_liberation_asymmetric_debug > 0) then {[format ["ied_manager.sqf -> IED %1 spawned at %2", _number, markerText _sector], "ASYMMETRIC"] remoteExecCall ["KPLIB_fnc_log", 2];};
    _ied_obj_loc = getPos _ied_obj;
    _ied_obj2_loc = getPos _ied_obj2;
    _ied_obj3_loc = getPos _ied_obj3;
    waitUntil  {
        !(mineActive _ied_obj) 
        && !(mineActive _ied_obj2)
        && !(mineActive _ied_obj3)
        };
        _defused_count = 0;

        _defused_obj =  _ied_obj_loc nearObjects ["GroundWeaponHolder",1];
        if (count _defused_obj > 0) then {
            _defused_count = _defused_count +1;
        };
        _defused_obj =  _ied_obj2_loc nearObjects ["GroundWeaponHolder",1];
        if (count _defused_obj > 0) then {
            _defused_count = _defused_count +1;
        };
        _defused_obj =  _ied_obj3_loc nearObjects ["GroundWeaponHolder",1];
        if (count _defused_obj > 0) then {
            _defused_count = _defused_count +1;
        };

        if (_defused_count > 0) then {
            [6, str _defused_count] remoteExec ["KPLIB_fnc_crGlobalMsg"];
            KP_liberation_civ_rep = KP_liberation_civ_rep + _defused_count;
            KP_liberation_civ_rep = -100 max (KP_liberation_civ_rep min 100);
            publicVariable "KP_liberation_civ_rep";
        };
        
    // while {_sector in active_sectors && mineActive _ied_obj && !_goes_boom} do {
    //     _nearinfantry = ((getpos _ied_obj) nearEntities ["Man", _activation_radius_infantry]) select {side _x == GRLIB_side_friendly};
    //     _nearvehicles = ((getpos _ied_obj) nearEntities [["Car", "Tank", "Air"], _activation_radius_vehicles]) select {side _x == GRLIB_side_friendly};
    //     if (count _nearinfantry >= _infantry_trigger || count _nearvehicles >= _vehicle_trigger) then {
    //         if (_ultra_strong) then {
    //             "Bomb_04_F" createVehicle (getpos _ied_obj);
    //             deleteVehicle _ied_obj;
    //         } else {
    //             _ied_obj setDamage 1;
    //         };
    //         stats_ieds_detonated = stats_ieds_detonated + 1; publicVariable "stats_ieds_detonated";
    //         _goes_boom = true;
    //     };
    //     sleep 1;
    // };
} else {
    if (KP_liberation_asymmetric_debug > 0) then {[format ["ied_manager.sqf -> _roadobj is Null for IED %1 at %2", _number, markerText _sector], "ASYMMETRIC"] remoteExecCall ["KPLIB_fnc_log", 2];};
};

if ((KP_liberation_asymmetric_debug > 0) && !(isNull _roadobj)) then {[format ["ied_manager.sqf -> exited IED %1 loop at %2", _number, markerText _sector], "ASYMMETRIC"] remoteExecCall ["KPLIB_fnc_log", 2];};

sleep 1800;

if (!(isNull _ied_obj)) then {deleteVehicle _ied_obj;};
