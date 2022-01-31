/*
    File: fn_addActionsPlayer.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-08-07
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Adds Liberation player actions to the given player.

    Parameter(s):
        _player - Player to add the actions to [OBJECT, defaults to player]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_player", player, [objNull]]
];

if !(isPlayer _player) exitWith {["No player given"] call BIS_fnc_error; false};

if (isNil "KP_liberation_resources_global") then {KP_liberation_resources_global = false;};

// Tutorial
_player addAction [
    ["<img size='1' image='a3\3den\data\displays\display3den\toolbar\help_tutorial_ca.paa'/><t color='#80FF80'> ", localize "STR_TUTO_ACTION", "</t>"] joinString "",
    {howtoplay = 1;},
    nil,
    -700,
    false,
    true,
    "",
    "
        alive _originalTarget
        && {_originalTarget getVariable ['KPLIB_isNearStart', false]}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];

// HALO
_player addAction [
    ["<img size='1' image='res\ui_redeploy.paa'/><t color='#80FF80'> ", localize "STR_HALO_ACTION", "</t>"] joinString "",
    "scripts\client\spawn\do_halo.sqf",
    nil,
    -710,
    false,
    true,
    "",
    "
        GRLIB_halo_param > 0
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_fobDist', 99999] < 20
            || {_originalTarget getVariable ['KPLIB_isNearStart', false]}
        }
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];

// Redeploy
if (!GRLIB_replaceRespawnButtonWithRedeploy) then {

    _player addAction [
        ["<img size='1' image='res\ui_redeploy.paa'/><t color='#80FF80'> ", localize "STR_DEPLOY_ACTION", "</t>"] joinString "",
        {GRLIB_force_redeploy = true;},
        nil,
        -720,
        false,
        true,
        "",
        "
            isNull (objectParent _originalTarget)
            && {alive _originalTarget}
            && {
                _originalTarget getVariable ['KPLIB_fobDist', 99999] < 20
                || {_originalTarget getVariable ['KPLIB_isNearMobRespawn', false]}
                || {_originalTarget getVariable ['KPLIB_isNearStart', false]}
            }
            && {build_confirmed isEqualTo 0}
        "
    ];
};


// Squad management
_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", localize "STR_SQUAD_MANAGEMENT_ACTION", "</t>"] joinString "",
    "scripts\client\ui\squad_management.sqf",
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject > 10 )
        && {alive _originalTarget}
        && {!((units group _originalTarget) isEqualTo [_originalTarget])}
        && {(leader group _originalTarget) isEqualTo _originalTarget}
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
        && !(_originalTarget getVariable ['KPLIB_hasDirectAccess', false])
    "
];

// Units management
_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/> <t color='#80FF80'>", "Units Management", "</t>"] joinString "",
    "scripts\client\ui\squad_management.sqf",
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject > 10 )
        && {alive _originalTarget}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
        && {build_confirmed isEqualTo 0}
        && _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
    "
];

// Build
_player addAction [
    ["<img size='1' image='res\ui_build.paa'/><t color='#FFFF00'> ", localize "STR_BUILD_ACTION", "</t>"] joinString "",
    "scripts\client\build\open_build_menu.sqf",
    nil,
    -750,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject > 10 )
        && {alive _originalTarget}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {build_confirmed isEqualTo 0}
    "
];

// Secondary missions
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa'/><t color='#FFFF00'> ", localize "STR_SECONDARY_OBJECTIVES", "</t>"] joinString "",
    "scripts\client\ui\secondary_ui.sqf",
    nil,
    -760,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_fobDist', 99999] < 20
            || {_originalTarget getVariable ['KPLIB_isNearStart', false]}
        }
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[5] call KPLIB_fnc_hasPermission}
        }
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];

// Build sector storage
_player addAction [
    ["<img size='1' image='res\ui_build.paa'/><t color='#FFFF00'><t color='#FFFF00'> ", localize "STR_SECSTORAGEBUILD_ACTION", "</t>"] joinString "",
    "scripts\client\build\do_sector_build.sqf",
    [KP_liberation_small_storage_building],
    -770,
    false,
    true,
    "",
    "
        !(_originalTarget getVariable ['KPLIB_nearProd', []] isEqualTo [])
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {(_originalTarget getVariable ['KPLIB_nearProd', []] select 3) isEqualTo []}
        && {build_confirmed isEqualTo 0}
    "
];

// Build supply facility
_player addAction [
    ["<img size='1' image='res\ui_build.paa'/><t color='#FFFF00'><t color='#FFFF00'> ", localize "STR_SECSUPPLYBUILD_ACTION", "</t>"] joinString "",
    "scripts\client\build\do_sector_build.sqf",
    ["supply"],
    -780,
    false,
    true,
    "",
    "
        !(_originalTarget getVariable ['KPLIB_nearProd', []] isEqualTo [])
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {!((_originalTarget getVariable ['KPLIB_nearProd', []] select 3) isEqualTo [])}
        && {!((_originalTarget getVariable ['KPLIB_nearProd', []]) select 4)}
        && {build_confirmed isEqualTo 0}
    "
];

// Build ammo facility
_player addAction [
    ["<img size='1' image='res\ui_build.paa'/><t color='#FFFF00'><t color='#FFFF00'> ", localize "STR_SECAMMOBUILD_ACTION", "</t>"] joinString "",
    "scripts\client\build\do_sector_build.sqf",
    ["ammo"],
    -790,
    false,
    true,
    "",
    "
        !(_originalTarget getVariable ['KPLIB_nearProd', []] isEqualTo [])
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {!((_originalTarget getVariable ['KPLIB_nearProd', []] select 3) isEqualTo [])}
        && {!((_originalTarget getVariable ['KPLIB_nearProd', []]) select 5)}
        && {build_confirmed isEqualTo 0}
    "
];

// Build fuel facility
_player addAction [
    ["<img size='1' image='res\ui_build.paa'/><t color='#FFFF00'><t color='#FFFF00'> ", localize "STR_SECFUELBUILD_ACTION", "</t>"] joinString "",
    "scripts\client\build\do_sector_build.sqf",
    ["fuel"],
    -800,
    false,
    true,
    "",
    "
        !(_originalTarget getVariable ['KPLIB_nearProd', []] isEqualTo [])
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {!((_originalTarget getVariable ['KPLIB_nearProd', []] select 3) isEqualTo [])}
        && {!((_originalTarget getVariable ['KPLIB_nearProd', []]) select 6)}
        && {build_confirmed isEqualTo 0}
    "
];

// Switch global/local resources
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\container_ca.paa'/><t color='#FFFF00'><t color='#FFFF00'> ", localize "STR_RESOURCE_GLOBAL_ACTION", "</t>"] joinString "",
    {KP_liberation_resources_global = !KP_liberation_resources_global},
    nil,
    -810,
    false,
    true,
    "",
    "
        alive _originalTarget
        && (isNull cursorObject || _originalTarget distance cursorObject > 10 )
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
        && {build_confirmed isEqualTo 0}
    "
];

// Production
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\container_ca.paa'/><t color='#FF8000'> ", localize "STR_PRODUCTION_ACTION", "</t>"] joinString "",
    "scripts\client\commander\open_production.sqf",
    nil,
    -820,
    false,
    true,
    "",
    "
        ( 
			(_originalTarget getVariable ['KPLIB_hasDirectAccess', false]) 
			|| ([3] call KPLIB_fnc_hasPermission) 
		) 
        && (isNull cursorObject || _originalTarget distance cursorObject > 10 )
		&& {alive _originalTarget} 
		&& {!(KP_liberation_production isEqualTo [])} 
		&& { 
			([_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob) 
			|| !(_originalTarget getVariable ['KPLIB_nearProd', []] isEqualTo []) 
		} 
		&& {build_confirmed isEqualTo 0}
    "
];

// Logistic
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa'/><t color='#FF8000'> ", localize "STR_LOGISTIC_ACTION", "</t>"] joinString "",
    "scripts\client\commander\open_logistic.sqf",
    nil,
    -830,
    false,
    true,
    "",
    "
        KP_liberation_ailogistics
        && (
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        )
        && (isNull cursorObject || _originalTarget distance cursorObject > 10 )
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
        && {!(
            GRLIB_all_fobs isEqualTo []
            || KP_liberation_production isEqualTo []
        )}
        && {build_confirmed isEqualTo 0}
    "
];

// Save progress
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_saveas_ca.paa'/><t color='#FFFF00'> ", localize "STR_SAVE_PROGRESS_ACTION", "</t>"] joinString "",
    {[] remoteExec ["KPLIB_fnc_doSave", 2];},
    nil,
    -760,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_fobDist', 99999] < 20
            || {_originalTarget getVariable ['KPLIB_isNearStart', false]}
        }
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[5] call KPLIB_fnc_hasPermission}
        }
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];


// Resupply Store
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\container_ca.paa'/><t color='#FFFF00'>", " Open Resupply Store", "</t>"] joinString "",
    {
        params ["_trader", "_caller", "_actionId", "_arguments"];
		[cursorObject] call HALs_store_fnc_openStore;
    },
    nil,
    -760,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && {alive _originalTarget}
        && {
            _originalTarget getVariable ['KPLIB_fobDist', 99999] < 20
            || {_originalTarget getVariable ['KPLIB_isNearStart', false]}
        }
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {build_confirmed isEqualTo 0}
        && cursorObject == supplies_radio
        && cursorObject distance player < 5
    "
];



// Permissions
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa'/><t color='#FF8000'> ", localize "STR_COMMANDER_ACTION", "</t><img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>"] joinString "",
    "scripts\client\commander\open_permissions.sqf",
    nil,
    -840,
    false,
    true,
    "",
    "
        GRLIB_permissions_param
        && {_originalTarget getVariable ['KPLIB_hasDirectAccess', false]}
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];



// qualifications
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa'/><t color='#FF8000'> ", localize "STR_QUALIFICATIONS_ACTION", "</t><img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>"] joinString "",
    "scripts\client\commander\open_qualification.sqf",
    nil,
    -840,
    false,
    true,
    "",
    "
        _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];

//skip time
_player addAction [
    ["<img size='1' image='a3\modules_f_curator\data\iconskiptime_ca.paa'/><t color='#FF8000'> ", "Skip To night", "</t>"] joinString "",
    {
        private _result = ["Are you sure you want to skip to night, enemy readiness will increase?", "Confirm", true, true] call BIS_fnc_guiMessage;
        if (_result) then {
            [20] remoteExec ["KPLIB_fnc_skipTimeTo", 2];
        };
    },
    nil,
    -840,
    false,
    true,
    "",
    "
        (
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            ||
            ['Officer'] call KPLIB_fnc_hasQualification
        )
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];

_player addAction [
    ["<img size='1' image='a3\modules_f_curator\data\iconskiptime_ca.paa'/><t color='#FF8000'> ", "Skip To morning", "</t>"] joinString "",
    {
        private _result = ["Are you sure you want to skip to morning, enemy readiness will increase?", "Confirm", true, true] call BIS_fnc_guiMessage;
        if (_result) then {
            [6] remoteExec ["KPLIB_fnc_skipTimeTo", 2];
        };

    },
    nil,
    -840,
    false,
    true,
    "",
    "
        (
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            ||
            ['Officer'] call KPLIB_fnc_hasQualification
        )
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && toLower(typeof cursorObject) in KP_liberation_Command_Devices
        && cursorObject distance player < 5
    "
];

// Reassign Zeus
if (player == ([] call KPLIB_fnc_getCommander)) then {
    _player addAction [
        ["<t color='#FF0000'> ", localize "STR_REASSIGN_ZEUS", "</t>"] joinString "",
        {[] call KPLIB_fnc_requestZeus},
        nil,
        -870,
        false,
        true,
        "",
        "
            alive _originalTarget
            && {isNull (_originalTarget getVariable ['KPLIB_ownedZeusModule', objNull])}
            && {build_confirmed isEqualTo 0}
        "
    ];
};

// Create FOB clearance
_player addAction [
    ["<img size='1' image='\A3\ui_f\data\map\mapcontrol\Rock_CA.paa'/><t color='#FFFF00'><t color='#FFFF00'> ", localize "STR_CLEARANCE_ACTION", "</t>"] joinString "",
    {[player getVariable ["KPLIB_fobPos", [0, 0, 0]], GRLIB_fob_range * 0.9, true] call KPLIB_fnc_createClearanceConfirm;},
    nil,
    -850,
    false,
    true,
    "",
    "
        _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
        && {build_confirmed isEqualTo 0}
        && !([_originalTarget getVariable ['KPLIB_fobPos', [0,0,0]]] call KPLIB_fnc_isStartBase)
    "
];


// Trigger alarm
_player addAction [
    ["<img size='1' image='DBUG\pictures\sounds.paa'/><t color='#FFFF00'><t color='#FFFF00'>", " Trigger the Alarm", "</t>"] joinString "",
    {
        _nearfob = [] call KPLIB_fnc_getNearestFob;
        [_nearfob] call KPLIB_fnc_raiseAlarm;
    },
    nil,
    -850,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && alive _originalTarget
        && build_confirmed isEqualTo 0
        && ((typeOf cursorObject) in ([KPLIB_alarm_speaker] + KP_liberation_Command_Devices))
    "
];


// Turn Off alarm
_player addAction [
    ["<img size='1' image='DBUG\pictures\sounds.paa'/><t color='#FFFF00'>", " Turn Off the Alarm", "</t>"] joinString "",
    {
        _nearfob = [] call KPLIB_fnc_getNearestFob;
        [_nearfob] call KPLIB_fnc_turnOffAlarm;
    },
    nil,
    -850,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && alive _originalTarget
        && build_confirmed isEqualTo 0
        && ((typeOf cursorObject) in ([KPLIB_alarm_speaker] + KP_liberation_Command_Devices))
    "
];


// interrogate
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Talk_ca.paa'/><t color='#FFFF00'>", " Interrogate", "</t>"] joinString "",
    {
        _intelValue =  cursorObject getVariable ['intel_value',0];
        if (_intelValue>0) then {
            resources_intel = resources_intel +_intelValue;
            publicVariable "resources_intel";
            hint "Here is what i know";
        };
        if (_intelValue<0) then {
            KP_liberation_civ_rep = ceil( (KP_liberation_civ_rep+_intelValue) max (-100) );
            publicVariable "KP_liberation_civ_rep";
            hint "I am just an innocent";
        };
        cursorObject setVariable ["intel_value",0,true]; 
    },
    nil,
    -850,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (!isNull cursorObject)
        && (alive cursorObject)
        && (cursorObject getVariable ['intel_value',0]) != 0
        && cursorObject getVariable ['ace_captives_isHandcuffed', false] 
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[5] call KPLIB_fnc_hasPermission}
        }
        
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && [_originalTarget getVariable ['KPLIB_fobPos', [0,0,0]]] call KPLIB_fnc_isStartBase
    "
];


// Rename vehicle
_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\truck_ca.paa'/><t color='#FFFF00'>", " Rename vehicle", "</t>"] joinString "",
    {
        params ["_trader", "_caller", "_actionId", "_arguments"];
		    ace_cargo_interactionVehicle = cursorObject;
            createDialog "ace_cargo_renameMenu";
    },
    nil,
    -760,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && {alive _originalTarget}
        &&  [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
        && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        }
        && {build_confirmed isEqualTo 0}
        && (tolower typeof cursorObject) in KPLIB_b_allVeh_classes
        && cursorObject distance player < 12
    "
];



_player addAction [
    ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa'/><t color='#FF8000'> ", "Show/Hide SAM Ranges", "</t>"] joinString "",
    {
        if (isnil "SAM_Ranges_Markers") then {
            SAM_Ranges_Markers = [];
        };
        if (count SAM_Ranges_Markers > 0) then {
            {
                deleteMarkerLocal _x;
            }
            forEach SAM_Ranges_Markers;
            SAM_Ranges_Markers = [];
        } else {
            {
                if !(_x in blufor_sectors) then {
                    _markerstr = createMarkerLocal [_x +"_range", markerPos _x]; 
                    _markerstr setMarkerShapeLocal "ELLIPSE"; 
                    _markerstr setMarkerSizeLocal [3000, 3000];
                    SAM_Ranges_Markers pushBack _markerstr;
                };
            }forEach sectors_SAM;
        };
    },
    nil,
    -840,
    false,
    true,
    "",
    "
        GRLIB_permissions_param
        && {[2] call KPLIB_fnc_hasPermission}
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && typeof cursorObject in ['USMC_WarfareBUAVterminal']
        && cursorObject distance player < 10
    "
];

_player execVM "compatibility\add_compatibility_actions.sqf";

[] call KPLIB_fnc_addLogisticsActions;
true
