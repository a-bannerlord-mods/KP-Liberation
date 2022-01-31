#define DEPLOY_DISPLAY (findDisplay 5201)
#define DEPLOY_LIST_IDC 201
#define DEPLOY_BUTTON_IDC 202

KPLIB_respawnPositionsList = [];
KPLIB_firstTimeRespawn = true;


fullmap = 0;
private _old_fullmap = 0;
private _oldsel = -999;
private _standard_map_pos = [];
private _frame_pos = [];

GRLIB_force_redeploy = false;

waitUntil {!isNil "GRLIB_all_fobs"};
waitUntil {!isNil "blufor_sectors"};
waitUntil {!isNil "save_is_loaded"};
waitUntil {save_is_loaded};

_playerVarName = "player"+ getPlayerUID player +"data";

waitUntil {!isNil _playerVarName};

_lastplayerjoineddata = missionNamespace getVariable [_playerVarName,[[],[],[]]];

private _lastPlayerPos = _lastplayerjoineddata select 0;
private _lastPlayerGear = _lastplayerjoineddata select 1;
private _extraData = _lastplayerjoineddata select 2;

private _spawn_str = "";

waitUntil {!isNil "introDone"};
waitUntil {introDone};
waitUntil {!isNil "cinematic_camera_stop"};
waitUntil {cinematic_camera_stop};

private _basenamestr = "Operation Base";

KP_liberation_respawn_time = time;
KP_liberation_respawn_mobile_done = false;
_preciseDeployment = false;

while {true} do {
    waitUntil {
        sleep 0.2;
        (GRLIB_force_redeploy || (player distance (markerPos GRLIB_respawn_marker) < 50)) && vehicle player == player && alive player && !dialog && howtoplay == 0
    };

    private _backpack = backpack player;

    fullmap = 0;
    _old_fullmap = 0;

    GRLIB_force_redeploy = false;



    createDialog "liberation_deploy";
    deploy = 0;
    _oldsel = -999;

    showCinemaBorder false;
    camUseNVG false;
    respawn_camera = "camera" camCreate (getposATL startbase);
    respawn_object = "Sign_Arrow_Blue_F" createVehicleLocal (getposATL startbase);
    respawn_object hideObject true;
    respawn_camera camSetTarget respawn_object;
    respawn_camera cameraEffect ["internal","back"];
    respawn_camera camcommit 0;

    waitUntil {dialog};

    (DEPLOY_DISPLAY displayCtrl DEPLOY_LIST_IDC) ctrlAddEventHandler ["mouseButtonDblClick", {
        if (ctrlEnabled (DEPLOY_DISPLAY displayCtrl DEPLOY_BUTTON_IDC)) then {
            deploy = 1;
        };
    }];

    _standard_map_pos = ctrlPosition (DEPLOY_DISPLAY displayCtrl 251);
    _frame_pos = ctrlPosition (DEPLOY_DISPLAY displayCtrl 198);

    // Get loadouts either from ACE or BI arsenals
    private ["_loadouts_data"];
    if (KP_liberation_ace && KP_liberation_arsenal_type) then {
        _loadouts_data = +(profileNamespace getVariable ["ace_arsenal_saved_loadouts", []]);
    } else {
        private _saved_loadouts = +(profileNamespace getVariable "bis_fnc_saveInventory_data");
        _loadouts_data = [];
        private _counter = 0;
        if (!isNil "_saved_loadouts") then {
            {
                if (_counter % 2 == 0) then {
                    _loadouts_data pushback _x;
                };
                _counter = _counter + 1;
            } forEach _saved_loadouts;
        };
    };

    lbAdd [203, "--"];
    {lbAdd [203, _x param [0]]} forEach _loadouts_data;
    lbSetCurSel [203, 0];

    while {dialog && alive player && deploy == 0} do {
        // ARRAY - [[NAME, POSITION(, OBJECT)], ...]

        if (count _lastPlayerPos > 0 && KPLIB_firstTimeRespawn && GRLIB_enableSaveLocation) then {
            KPLIB_respawnPositionsList = [["Last Known Postion", _lastPlayerPos]];
            // Last vehicle 

            if !(isnil "GRLIB_Players_Disconnect_Vehicles") then { 
                _vi = GRLIB_Players_Disconnect_Vehicles findIf {(_x select 0) == (getPlayerUID player)}; 
                if (_vi != -1) then { 
                    _v = (GRLIB_Players_Disconnect_Vehicles select _vi) select 1; 
                    if (!(isNull _v) && alive _v) then { 
                        KPLIB_respawnPositionsList pushBack [ 
                            format ["Last vehicle - %1 ", mapGridPosition getPosATL _v], 
                            getPosATL _v, 
                            _v 
                        ]; 
                    }; 
                };   
            }else{ 
                GRLIB_Players_Disconnect_Vehicles = []; 
            }; 
            if !(isnil "GRLIB_Players_Disconnect_SquadMate") then { 
                _vi = GRLIB_Players_Disconnect_SquadMate findIf {(_x select 0) == (getPlayerUID player)}; 
                if (_vi != -1) then { 
                    _v = (GRLIB_Players_Disconnect_SquadMate select _vi) select 1; 
                    if (!(isNull _v) && alive _v) then { 
                        KPLIB_respawnPositionsList pushBack [ 
                            format ["Near Last Squadmate (%1) - %2 ",name _v , mapGridPosition getPosATL _v], 
                            getPosATL _v, 
                            _v 
                        ]; 
                    }; 
                };   
            }else{ 
                GRLIB_Players_Disconnect_SquadMate = []; 
            }; 
            _preciseDeployment = true;
        }
        else
        {
            _preciseDeployment = false;
            KPLIB_respawnPositionsList = [[_basenamestr, getposATL startbase]];
            {
                if !(ceil(_x select 0) == ceil((getposATL startbase) select 0)
                    && ceil(_x select 1)== ceil((getposATL startbase) select 1)
                    && ceil(_x select 2)== ceil((getposATL startbase) select 2)) then {
                    KPLIB_respawnPositionsList pushBack [
                    format ["FOB %1 - %2", (military_alphabet select _forEachIndex), mapGridPosition _x],
                    _x
                ];
                };
                //bug
            } forEach GRLIB_all_fobs;

            if (KP_liberation_mobilerespawn) then {
                if (KP_liberation_respawn_time <= time) then {
                    private _mobileRespawns = [] call KPLIB_fnc_getMobileRespawns;

                    {
                        KPLIB_respawnPositionsList pushBack [
                            format ["%1 - %2", localize "STR_RESPAWN_TRUCK", mapGridPosition getPosATL _x],
                            getPosATL _x,
                            _x
                        ];
                    } forEach _mobileRespawns
                };
            };
        };

        lbClear DEPLOY_LIST_IDC;
        {
            lbAdd [DEPLOY_LIST_IDC, (_x select 0)];
        } foreach KPLIB_respawnPositionsList;

        
        
        if (lbCurSel DEPLOY_LIST_IDC == -1) then {
            lbSetCurSel [201, 0];
        };

        if (lbCurSel DEPLOY_LIST_IDC != _oldsel) then {
            _oldsel = lbCurSel DEPLOY_LIST_IDC;
            private _objectpos = [0,0,0];
            if (dialog) then {
                _objectpos = ((KPLIB_respawnPositionsList select _oldsel) select 1);
            };
            respawn_object setPosATL ((KPLIB_respawnPositionsList select _oldsel) select 1);
            private _startdist = 120;
            private _enddist = 120;
            private _alti = 35;
            if (dialog) then {
                if (((KPLIB_respawnPositionsList select (lbCurSel DEPLOY_LIST_IDC)) select 0) == _basenamestr) then {
                    _startdist = 200;
                    _enddist = 300;
                    _alti = 30;
                };
                // Disable if sector is under attack
                if (!KPLIB_respawnOnAttackedSectors && {_objectpos in KPLIB_sectorsUnderAttack}) then {
                    (DEPLOY_DISPLAY displayCtrl DEPLOY_BUTTON_IDC) ctrlSetText localize "STR_DEPLOY_UNDERATTACK";
                    (DEPLOY_DISPLAY displayCtrl DEPLOY_BUTTON_IDC) ctrlEnable false;
                } else {
                    (DEPLOY_DISPLAY displayCtrl DEPLOY_BUTTON_IDC) ctrlSetText localize "STR_DEPLOY_BUTTON";
                    (DEPLOY_DISPLAY displayCtrl DEPLOY_BUTTON_IDC) ctrlEnable true;
                };
            };

            "spawn_marker" setMarkerPosLocal (getpos respawn_object);
            ctrlMapAnimClear (DEPLOY_DISPLAY displayCtrl 251);
            private _transition_map_pos = getpos respawn_object;
            private _fullscreen_map_offset = 4000;
            if(fullmap % 2 == 1) then {
                _transition_map_pos = [(_transition_map_pos select 0) - _fullscreen_map_offset,  (_transition_map_pos select 1) + (_fullscreen_map_offset * 0.75), 0];
            };
            (DEPLOY_DISPLAY displayCtrl 251) ctrlMapAnimAdd [0, 0.3,_transition_map_pos];
            ctrlMapAnimCommit (DEPLOY_DISPLAY displayCtrl 251);

            respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object select 1) + _startdist, (getpos respawn_object select 2) + _alti];
            respawn_camera camcommit 0;
            respawn_camera camSetPos [(getpos respawn_object select 0) - 70, (getpos respawn_object select 1) - _enddist, (getpos respawn_object select 2) + _alti];
            respawn_camera camcommit 90;
        };

        if (_old_fullmap != fullmap) then {
            _old_fullmap = fullmap;
            if (fullmap % 2 == 1) then {
                (DEPLOY_DISPLAY displayCtrl 251) ctrlSetPosition [ (_frame_pos select 0) + (_frame_pos select 2), (_frame_pos select 1), (0.6 * safezoneW), (_frame_pos select 3)];
            } else {
                (DEPLOY_DISPLAY displayCtrl 251) ctrlSetPosition _standard_map_pos;
            };
            (DEPLOY_DISPLAY displayCtrl 251) ctrlCommit 0.2;
            _oldsel = -1;
        };
        uiSleep 0.1;
    };

    if (dialog && deploy == 1) then {
        private _idxchoice = lbCurSel DEPLOY_LIST_IDC;
        _spawn_str = (KPLIB_respawnPositionsList select _idxchoice) select 0;

        if (count (KPLIB_respawnPositionsList select _idxchoice) == 3) then {
            private _truck = (KPLIB_respawnPositionsList select _idxchoice) select 2;
            player setposATL (_truck getPos [5 + (random 3), random 360]);
            if (_preciseDeployment) then {
                [_truck, {player moveInCargo _this}] remoteExec ["call", 0];
            } else {
                KP_liberation_respawn_mobile_done = true;
            };
        } else {
            private _destpos = ((KPLIB_respawnPositionsList select _idxchoice) select 1);
            if (_preciseDeployment) then {
                player setposATL _destpos;
            } else {
                player setposATL [((_destpos select 0) + 5) - (random 10),((_destpos select 1) + 5) - (random 10),(_destpos select 2)];
            };
            
        };

        _vi = GRLIB_Players_Disconnect_Vehicles findIf {(_x select 0) == (getPlayerUID player)};
        if (_vi != -1) then {
            GRLIB_Players_Disconnect_Vehicles deleteat _vi;
            publicVariable "GRLIB_Players_Disconnect_Vehicles";
        };

        _vi = GRLIB_Players_Disconnect_SquadMate findIf {(_x select 0) == (getPlayerUID player)};
        if (_vi != -1) then {
            GRLIB_Players_Disconnect_SquadMate deleteat _vi;
            publicVariable "GRLIB_Players_Disconnect_SquadMate";
        };

        [player] call KPLIB_fnc_setUnitTraits;

        if (count _lastPlayerGear > 0 && KPLIB_firstTimeRespawn  && GRLIB_enableSaveLoadout) then {
            //[player, _lastPlayerGear] call KPLIB_fnc_setLoadout;
            player setUnitLoadout _lastPlayerGear;
        };

        if (count _lastPlayerGear == 0 && KPLIB_firstTimeRespawn) then{
            player forceAddUniform GRLIB_default_uniform;
        };

        if (count _extraData>0) then {
            
            [player, _extraData] call KPLIB_fnc_setobjectextradatafromSave;
            // _rations_hunger=  _lastPlayerACEXValues select 0; 
            // _field_rations_thirst = _lastPlayerACEXValues select 1;
            // if (_rations_hunger < 25) then {
            //     _rations_hunger = 25;
            // };
            // if (_field_rations_thirst < 25) then {
            //     _field_rations_thirst = 25;
            // };
            // player setVariable ["acex_field_rations_hunger",_rations_hunger,true];
            // player setVariable ["acex_field_rations_thirst",_field_rations_thirst,true];
        };
        

        player setVariable ["deployed",true,true];
        KPLIB_firstTimeRespawn= false;        
    };

    respawn_camera cameraEffect ["Terminate","back"];
    camDestroy respawn_camera;
    deleteVehicle respawn_object;
    camUseNVG false;
    "spawn_marker" setMarkerPosLocal markers_reset;

    if (dialog) then {
        closeDialog 0;
    };

    if (alive player && deploy == 1) then {
        [_spawn_str] spawn spawn_camera;
        if (KP_liberation_respawn_mobile_done) then {
            KP_liberation_respawn_time = time + KP_liberation_respawn_cooldown;
            KP_liberation_respawn_mobile_done = false;
        };
    };

    // if (KP_liberation_arsenalUsePreset) then {
    //     [_backpack] call KPLIB_fnc_checkGear;
    // };

    if (KP_liberation_mobilerespawn && (KP_liberation_respawn_time > time)) then {
        hint format [localize "STR_RESPAWN_COOLDOWN_HINT", ceil ((KP_liberation_respawn_time - time) / 60)];
        uiSleep 12;
        hint "";
    };
};
