
KPLIB_init = false;

// Version of the KP Liberation framework
KP_liberation_version = [0, 96, "7a"];

enableSaving [ false, false ];

if (isDedicated) then {debug_source = "Server";} else {debug_source = name player;};

if (hasInterface) then {
    titleText ["Server Loading... ", "BLACK FADED", 600];
};

[] call KPLIB_fnc_initSectors;
if (!isServer) then {waitUntil {!isNil "KPLIB_initServer"};};

if (hasInterface) then {
    titleText ["Loading... ", "BLACK FADED", 600];
};

[] call compile preprocessFileLineNumbers "scripts\shared\fetch_params.sqf";
[] call compile preprocessFileLineNumbers "kp_liberation_config.sqf";
[] call compile preprocessFileLineNumbers "compatibility\compatibility_config.sqf";
[] call compile preprocessFileLineNumbers "presets\init_presets.sqf";
[] call compile preprocessFileLineNumbers "arsenal_presets\arsenal_items_init.sqf";
[] call compile preprocessFileLineNumbers "kp_objectInits.sqf";

[] call compile preprocessFileLineNumbers "scripts\shared\init_shared.sqf";
[] call compile preprocessFileLineNumbers "kb_objectives.sqf";
[] call compile preprocessFile "modules\command_and_control_center\init.sqf";
if (isServer) then {
    [] call compile preprocessFileLineNumbers "scripts\server\init_server.sqf";
    [] spawn KPLIB_fnc_removeUselessSectorMarkers;
};


if (!isDedicated && !hasInterface && isMultiplayer) then {
    execVM "scripts\server\offloading\hc_manager.sqf";
};

if (!isDedicated && hasInterface) then {
    // Get mission version and readable world name for Discord rich presence
    [
        ["UpdateDetails", [localize "STR_MISSION_VERSION", "on", getText (configfile >> "CfgWorlds" >> worldName >> "description")] joinString " "]
    ] call (missionNamespace getVariable ["DiscordRichPresence_fnc_update", {}]);

    // Add EH for curator to add kill manager and object init recognition for zeus spawned units/vehicles
    {
        _x addEventHandler ["CuratorObjectPlaced", {[_this select 1] call KPLIB_fnc_handlePlacedZeusObject;}];
    } forEach allCurators;

    waitUntil {alive player};
    if (debug_source != name player) then {debug_source = name player};
    [] call compile preprocessFileLineNumbers "scripts\client\init_client.sqf";
} else {
    setViewDistance 1600;
};

// Execute fnc_reviveInit again (by default it executes in postInit)
if ((isNil {player getVariable "bis_revive_ehHandleHeal"} || isDedicated) && !(bis_reviveParam_mode == 0)) then {
    [] call bis_fnc_reviveInit;
};

KPLIB_init = true;

// Notify clients that server is ready
if (isServer) then {
    KPLIB_initServer = true;
    publicVariable "KPLIB_initServer";
};


[] execVM "modules\VAM_GUI\VAM_GUI_init.sqf";

//AI artillery
[] execVM "modules\RYD_FFE\FFE.sqf";

execVM "custom\scripts\shared\init_shared.sqf";

