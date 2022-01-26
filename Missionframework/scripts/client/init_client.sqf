

[] call compile preprocessFileLineNumbers "scripts\client\misc\init_markers.sqf";


if (typeOf player == "VirtualSpectator_F") exitWith {
    execVM "scripts\client\markers\empty_vehicles_marker.sqf";
    execVM "scripts\client\markers\fob_markers.sqf";
    execVM "scripts\client\markers\group_icons.sqf";
    execVM "scripts\client\markers\hostile_groups.sqf";
    execVM "scripts\client\markers\sector_manager.sqf";
    execVM "scripts\client\markers\spot_timer.sqf";
    execVM "scripts\client\misc\synchronise_vars.sqf";
    execVM "scripts\client\ui\ui_manager.sqf";
};

// This causes the script error with not defined variable _display in File A3\functions_f_bootcamp\Inventory\fn_arsenal.sqf [BIS_fnc_arsenal], line 2122
// ["Preload"] call BIS_fnc_arsenal;
spawn_camera = compile preprocessFileLineNumbers "scripts\client\spawn\spawn_camera.sqf";
cinematic_camera = compile preprocessFileLineNumbers "scripts\client\ui\cinematic_camera.sqf";
write_credit_line = compile preprocessFileLineNumbers "scripts\client\ui\write_credit_line.sqf";
do_load_box = compile preprocessFileLineNumbers "scripts\client\ammoboxes\do_load_box.sqf";
kp_fuel_consumption = compile preprocessFileLineNumbers "scripts\client\misc\kp_fuel_consumption.sqf";
kp_vehicle_permissions = compile preprocessFileLineNumbers "scripts\client\misc\vehicle_permissions.sqf";

execVM "scripts\client\actions\intel_manager.sqf";
execVM "scripts\client\actions\recycle_manager.sqf";
execVM "scripts\client\actions\unflip_manager.sqf";
execVM "scripts\client\ammoboxes\ammobox_action_manager.sqf";
execVM "scripts\client\build\build_overlay.sqf";
execVM "scripts\client\build\do_build.sqf";
execVM "scripts\client\commander\enforce_whitelist.sqf";
if (KP_liberation_mapmarkers) then {execVM "scripts\client\markers\empty_vehicles_marker.sqf";};
execVM "scripts\client\markers\fob_markers.sqf";
if (!KP_liberation_high_command && KP_liberation_mapmarkers) then {execVM "scripts\client\markers\group_icons.sqf";};
execVM "scripts\client\markers\hostile_groups.sqf";
if (KP_liberation_mapmarkers) then {execVM "scripts\client\markers\huron_marker.sqf";} else {deleteMarkerLocal "huronmarker"};
execVM "scripts\client\markers\sector_manager.sqf";
execVM "scripts\client\markers\spot_timer.sqf";
execVM "scripts\client\misc\broadcast_squad_colors.sqf";
//execVM "scripts\client\misc\init_arsenal.sqf";
execVM "scripts\client\misc\permissions_warning.sqf";
if (!KP_liberation_ace) then {execVM "scripts\client\misc\resupply_manager.sqf";};
execVM "scripts\client\misc\secondary_jip.sqf";
execVM "scripts\client\misc\synchronise_vars.sqf";
execVM "scripts\client\misc\synchronise_eco.sqf";
execVM "scripts\client\misc\playerNamespace.sqf";
execVM "scripts\client\spawn\redeploy_manager.sqf";
execVM "scripts\client\ui\ui_manager.sqf";
execVM "scripts\client\ui\tutorial_manager.sqf";
execVM "scripts\client\markers\update_production_sites.sqf";

execVM "scripts\client\playerdata\player_data_events.sqf";
execVM "scripts\client\misc\clear_player_diary.sqf";

player addMPEventHandler ["MPKilled", {_this spawn kill_manager;}];

player addEventHandler ["GetInMan", {[_this select 2] spawn kp_fuel_consumption;}];
player addEventHandler ["GetInMan", {[_this select 2] call KPLIB_fnc_setVehiclesSeized;}];
player addEventHandler ["GetInMan", {[_this select 2] call KPLIB_fnc_setVehicleCaptured;}];
player addEventHandler ["GetInMan", {[_this select 2] call kp_vehicle_permissions;}];
player addEventHandler ["SeatSwitchedMan", {[_this select 2] call kp_vehicle_permissions;}];
player addEventHandler ["HandleRating", {if ((_this select 1) < 0) then {0};}];



// Disable stamina, if selected in parameter
if (!GRLIB_fatigue) then {
    player enableStamina false;
    player addEventHandler ["Respawn", {player enableStamina false;}];
};

// Reduce aim precision coefficient, if selected in parameter
if (!KPLIB_sway) then {
    player setCustomAimCoef 0.1;
    player addEventHandler ["Respawn", {player setCustomAimCoef 0.1;}];
};

player addEventHandler ["Respawn", {
    [player] remoteExec ["KPLIB_fnc_applyUnitAnimations", [0, -2] select isDedicated , player];
}];

execVM "scripts\client\ui\intro.sqf";


[player] joinSilent (createGroup [GRLIB_side_friendly, true]);

// Commander init
if (player isEqualTo ([] call KPLIB_fnc_getCommander)) then {
    // Start tutorial
    if (KP_liberation_tutorial) then {
        [] call KPLIB_fnc_tutorial;
    };
    // Request Zeus if enabled
    if (KP_liberation_commander_zeus) then {
        [] spawn {
            sleep 5;
            [] call KPLIB_fnc_requestZeus;
        };
    };
};

[] call compile preprocessFile "compatibility\compatibility_client_init.sqf";


//INC_undercover init
player setVariable ["isSneaky",true,true];
[player] execVM "modules\INC_undercover\Scripts\initUCR.sqf";

execVM "custom\scripts\client\init_client.sqf";