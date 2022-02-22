[] spawn {

    sleep 5;
    ["Liberation", "Add opfor flag", {
        _ob = (_this select 1);
        if (!isNull _ob) then {
            _ob forceFlagtexture opfor_flag_texture;
        };
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Add resistance flag", {
        _ob = (_this select 1);
        if (!isNull _ob) then {
            _ob forceFlagtexture guerilla_flag_texture;
        };
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Add blufor flag", {
        _ob = (_this select 1);
        if (!isNull _ob) then {
            _ob forceFlagtexture blufor_flag_texture;
        };
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Remove flag", {
        _ob = (_this select 1);
        if (!isNull _ob) then {
            _ob forceFlagtexture '';
        };
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Unflip vehicle", {
        _ob = (_this select 1);
        if (!isNull _ob) then {
            _vehicle  = _ob;
            _vehicle setPosATL[(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, ((getPosATL _vehicle) select 2) + 1]; 
            _vehicle setVectorUp surfaceNormal position _vehicle;
        };
    }] call zen_custom_modules_fnc_register;

    ["Liberation", "Add blufor Crew To", {
        _ob = (_this select 1);
        if (!isNull _ob) then {
            //[_ob] call KPLIB_fnc_forceBluforCrew;
            [_ob] remoteExec ["KPLIB_fnc_forceBluforCrew", 2];
        };
    }] call zen_custom_modules_fnc_register;
    
    if (!(isnil "acex_field_rations_enabled") && acex_field_rations_enabled) then {
        ["Liberation", "Fill Rations (Hunger/Thirst)", {
            _ob = (_this select 1);
            if (!isNull _ob) then {
                _ob setVariable["acex_field_rations_hunger", 0, true];
                _ob setVariable["acex_field_rations_thirst", 0, true];
            };
        }] call zen_custom_modules_fnc_register;
    };
    ["Liberation", "Add Limited Zues", {
            _ob = (_this select 1);
            if (!(isNull _ob) && isPlayer _ob) then {
                [true, "KPLIB_createZeus", [_ob, true]] remoteExecCall ["BIS_fnc_callScriptedEventHandler", 2];
            };
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Add Note/Document", {
            _pos = (_this select 0);
            ["Add Note", [
                                        ["EDIT:MULTI", "Text", ["",{},10]],
                                        ["COMBO", "Text", [["note","topSecret"],[["Note"],["Top Secret Document"]],0]]
                                    ],
                                    {
                                        params ["_dialog", "_args"];
                                        _dialog params ["_report","_type"];
                                        _args params ["_pos"];
                                        [_pos, 90, _report, ["",["","TahomaB"]],_type] remoteExec ["GRAD_leaveNotes_fnc_spawnNote", 2, false];
                                    }, {}, [_pos]
                ] call zen_dialog_fnc_create;
    }] call zen_custom_modules_fnc_register;


    if (GRLIB_hideMarkers) then {
        ["Liberation", "Show Zues Markers", {
            {
                _x setMarkerAlphaLocal 1;
            }
            forEach(sectors_allSectors);
        }] call zen_custom_modules_fnc_register;
        
        ["Liberation", "Hide Zues Markers", {
            {
                _x setMarkerAlphaLocal 0;
            }
            forEach(sectors_allSectors);
        }] call zen_custom_modules_fnc_register;
    };
    
    ["Liberation", "Save Progress", {
        [] remoteExec ["KPLIB_fnc_doSave", 2];
    }] call zen_custom_modules_fnc_register;

    ["Liberation", "Backup Save", {
        [] remoteExec ["KPLIB_fnc_doBackupSave", 2];
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Toggle Auto Civilian Patrol", {
        GRLIB_enable_auto_civilian_patrol = !GRLIB_enable_auto_civilian_patrol;
        if (GRLIB_enable_auto_civilian_patrol) then {
            hint "Auto Civilian Patrol Enabled";
        } else {
            hint "Auto Civilian Patrol Disabled";
        };
        publicVariable "GRLIB_enable_auto_civilian_patrol";
    }] call zen_custom_modules_fnc_register;

    ["Liberation", "Add Civilian Patrol", {
        _pos = (_this select 0);
        ["Add Civilian Patrol", [
                                        ["EDIT", "Civilians Number", [GRLIB_civilians_amount,{}]],
                                        ["EDIT", "Range", [2500,{}]]
                                    ],
                                    {
                                        params ["_dialog", "_args"];
                                        _dialog params ["_number","_range"];
                                        _args params ["_position"];
                                        _rangeint = (parseNumber _range);

                                        [[_number,_range,_position,_rangeint], 	
                                            {
                                                params ["_number","_range","_position","_rangeint"];
                                                _usable_sectors = [];
                                                { 
                                                    if (getMarkerPos _x distance  _position < _rangeint) then { 
                                                        _usable_sectors pushback _x; 
                                                    };
                                                } foreach ((sectors_bigtown + sectors_capture + sectors_factory) - (active_sectors));					 
                                                for [ {_i=0}, {_i < (parseNumber _number)}, {_i=_i+1} ] do { [_usable_sectors,_rangeint] spawn manage_one_civilian_patrol; };
                                            }
                                        ] remoteExec ["call", 2];
                                    }, {}, [_pos]] call zen_dialog_fnc_create;

    }] call zen_custom_modules_fnc_register;



    ["Liberation", "Toggle Auto Opfor Patrol", {
        GRLIB_enable_auto_opfor_patrol = !GRLIB_enable_auto_opfor_patrol;
        if (GRLIB_enable_auto_opfor_patrol) then {
            hint "Auto Enemy Patrol Enabled";
        } else {
            hint "Auto Enemy Patrol Disabled";
        };
        publicVariable "GRLIB_enable_auto_civilian_patrol";
    }] call zen_custom_modules_fnc_register;

    ["Liberation", "Toggle Auto Opfor Random Battlegroup", {
        GRLIB_enable_auto_random_battlegroup = !GRLIB_enable_auto_random_battlegroup;
        if (GRLIB_enable_auto_random_battlegroup) then {
            hint "Auto Enemy Random Battlegroup Enabled";
        } else {
            hint "Auto Enemy Random Battlegroup Disabled";
        };
        publicVariable "GRLIB_enable_auto_random_battlegroup";
    }] call zen_custom_modules_fnc_register;


    ["Liberation", "Toggle Auto Opfor Counter Battlegroup", {
        GRLIB_enable_auto_counter_battlegroup = !GRLIB_enable_auto_counter_battlegroup;
        if (GRLIB_enable_auto_counter_battlegroup) then {
            hint "Auto Enemy Counter Battlegroup Enabled";
        } else {
            hint "Auto Enemy Counter Battlegroup Disabled";
        };
        publicVariable "GRLIB_enable_auto_counter_battlegroup";
    }] call zen_custom_modules_fnc_register;


    ["Liberation", "Restor Backup", {
            [] spawn {
            private _result = ["Are you sure you want to restore Backup", "Confirm", true, true] call BIS_fnc_guiMessage; 
            if (_result) then {
                ["Backup Number", [
                                        ["EDIT", "Number", ["",{}]]
                                    ],
                                    {
                                        params ["_dialog", "_args"];
                                        _dialog params ["_number"];
                                        [_number] remoteExec ["KPLIB_fnc_doRestorPackupSave", 2];
                                    }, {}, []
                ] call zen_dialog_fnc_create;

                    
            };
        };
    }] call zen_custom_modules_fnc_register;

    ["Liberation", "Start Fireworks", {
            _pos = (_this select 0);
            ["Backup Number", [
                            ["EDIT", "Number", [40,{}]],
                            ["EDIT", "Source", ["Land_Fire_barrel",{},10]]
                        ],
                        {
                            params ["_dialog", "_args"];
                            _dialog params ["_number","_objectClassName"];
                            _args params ["_position"];
                            [_number,_objectClassName,_position] spawn {
                                params ["_number","_objectClassName","_position"];
                                _source = _position nearObjects [_objectClassName,500]; 
                                for "_i" from 1 to (parseNumber _number) do {  
                                    sleep (.5 + random 2);
                                    [[getPos (selectRandom _source) , 'random','random'] ,"callFireworks",true,true] spawn BIS_fnc_MP;                                            
                                };  
                            };
                        }, {}, [_pos]
            ] call zen_dialog_fnc_create;
        
    }] call zen_custom_modules_fnc_register;

    ["Liberation", "Force Despawn All Sectors", {
        {
            sectors_forced_despawn pushBackUnique _x;
        } forEach(sectors_allSectors);
        publicVariable "sectors_forced_despawn";
    }] call zen_custom_modules_fnc_register;
    
    ["Liberation", "Reset spawn All Sectors to Auto", {
        sectors_forced_despawn = [];
        sectors_forced_spawn =[];
        publicVariable "sectors_forced_despawn";
        publicVariable "sectors_forced_spawn";
    }] call zen_custom_modules_fnc_register;
    
    // context Menu
    private _sectror_control_root_action = [
        "SectrorControlRoot",
        "Sector Control",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _sector != "" && !((_sector in blufor_sectors) && (_sector in sectors_destroyable))
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_spawn_control_root_action = [
        "SectorspawnControlRoot",
        "Sector spawn",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_task_root_action = [
        "SectorTasksRoot",
        "Tasks",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_liberate_task_root_action = [
        "SectorCreateLiberateTaskRoot",
        "Create Liberate Task",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _name = markerText _sector;
            _markerstr = createMarkerLocal [format ["marker_task_liberate_%1",_sector],getMarkerPos _sector];
            _markerstr setMarkerShapeLocal "ICON";
            _markerstr setMarkerType "SELECT"; 
            [west, ["operation_task"], ["Operation" , "Operation",""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
            [west, [format ["task_liberate_%1",_sector],"operation_task"], ["" ,format ["Liberate %1",_name],""], _sector, "CREATED", 0, true,"attack"] call BIS_fnc_taskCreate;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            (!(_sector in blufor_sectors) && !(_sector in sectors_destroyable))
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_destroy_task_root_action = [
        "SectorCreateDestroyTaskRoot",
        "Create Destroy Task",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _name = markerText _sector;
            _markerstr = createMarkerLocal [format ["marker_task_liberate_%1",_sector],getMarkerPos _sector];
            _markerstr setMarkerShapeLocal "ICON";
            _markerstr setMarkerType "SELECT"; 
            [west, ["operation_task"], ["Operation" , "Operation",""], objNull, 1, 3, true] call BIS_fnc_taskCreate;
            [west, [format ["task_destroy_%1",_sector],"operation_task"], ["" ,format ["Destroy %1",_name],""], _sector, "CREATED", 0, true,"destroy"] call BIS_fnc_taskCreate;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            (!(_sector in blufor_sectors) && (_sector in sectors_destroyable))
        }
    ] call zen_context_menu_fnc_createaction;
    //scout
    private _sector_remove_tasks_root_action = [
        "SectorRemoveTasksRoot",
        "Remove All Sector Tasks",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;

            _taskId= format ["task_destroy_%1",_sector];
            _exists = [_taskId] call BIS_fnc_taskExists;
            if (_exists) then {
                [_taskId,west,true] call BIS_fnc_deleteTask;
                deleteMarker (format ["marker_task_liberate_%1",_sector]);
            };

            _taskId= format ["task_liberate_%1",_sector];
            _exists = [_taskId] call BIS_fnc_taskExists;
            if (_exists) then {
                [_taskId,west,true] call BIS_fnc_deleteTask;
                deleteMarker (format ["marker_task_liberate_%1",_sector]);
            };

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_control_auto_action = [
        "SectorspawnControlAuto",
        "Auto spawn",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            sectors_forced_despawn deleteAt (sectors_forced_despawn find _sector);
            sectors_forced_spawn deleteAt (sectors_forced_spawn find _sector);
            publicVariable "sectors_forced_spawn";
            publicVariable "sectors_forced_despawn";
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _sector != "" && !((_sector in blufor_sectors) && (_sector in sectors_destroyable))
            && (_sector in sectors_forced_despawn || _sector in sectors_forced_spawn)
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_control_forced_despawn_action = [
        "SectorspawnControlDespawn",
        "force to Despawn",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            sectors_forced_despawn pushBack _sector;
            sectors_forced_spawn deleteAt (sectors_forced_spawn find _sector);
            publicVariable "sectors_forced_spawn";
            publicVariable "sectors_forced_despawn";
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _sector != "" && !((_sector in blufor_sectors) && (_sector in sectors_destroyable))
            && !(_sector in sectors_forced_despawn)
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_control_show_action = [
        "SectorShowUnits",
        "Show Sector Units",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [[_sector], 	
                {
                    params ["_sector"];
                    _managed_units =  missionNamespace getVariable [format ["%1_managed_units",_sector],[]];
                    if (count _managed_units > 0) then {
                        {
                            _x enableSimulation true;
		                    _x hideObjectGlobal false;
		                    _x hideObject false;
                        } forEach _managed_units;
                    };
                }
            ] remoteExec ["call"];
            
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _sector != ""  && (_sector in active_sectors)
        }
    ] call zen_context_menu_fnc_createaction;
    
    
    private _sector_control_hide_action = [
        "SectorHideUnits",
        "Hide Sector Units",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [[_sector], 	
                {
                    params ["_sector"];
                    _managed_units =  missionNamespace getVariable [format ["%1_managed_units",_sector],[]];
                    _ambush_managed_units =  missionNamespace getVariable [format ["%1_ambush_managed_units",_sector],[]];

                    if (count _managed_units > 0) then {
                        {
                            _type= tolower (typeof _x);
                            _typev= tolower (typeof vehicle _x);
                            if !(_type in KPLIB_strategic_vehiclesClasses && _typev in KPLIB_strategic_vehiclesClasses) then {
                                _x enableSimulation false;
		                        _x hideObjectGlobal true;
		                        _x hideObject true;
                            };
                        } forEach _managed_units;
                    };
                    if (count _ambush_managed_units > 0) then {
                        {
                            _x enableSimulation false;
		                    _x hideObjectGlobal true;
		                    _x hideObject true;
                        } forEach _ambush_managed_units;
                    };
                }
            ] remoteExec ["call"];
            
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _sector != ""  && (_sector in active_sectors || _sector  in KP_liberation_asymmetric_sectors)
        }
    ] call zen_context_menu_fnc_createaction;
    

    private _sector_control_forced_spawn_action = [
        "SectorspawnControlspawn",
        "force to spawn",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            sectors_forced_spawn pushBack _sector;
            sectors_forced_despawn deleteAt (sectors_forced_despawn find _sector);
            publicVariable "sectors_forced_spawn";
            publicVariable "sectors_forced_despawn";
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _sector != "" && !((_sector in blufor_sectors) && (_sector in sectors_destroyable))
            && !(_sector in sectors_forced_spawn)
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_control_spawn_civ_action = [
        "SectorspawnControlspawn",
        "Spawn Civilians",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [_sector]  remoteExec ["KPLIB_fnc_spawnCivilians", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_attack_root_action = [
        "SectorAttackRoot",
        "Attack Sector",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            ((_sector in blufor_sectors) && !(_sector in sectors_destroyable))
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_ambush_root_action = [
        "SectorAmbushRoot",
        "Setup Ambush",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            //["", true , getMarkerPos _sector] spawn spawn_battlegroup;
            KP_liberation_asymmetric_sectors pushBack _sector;
            publicVariable "KP_liberation_asymmetric_sectors";
            
            [_sector,true] remoteExec ["asym_sector_ambush", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_ied_root_action = [
        "SectorIEDRoot",
        "Setup IEDs",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            ["Add IEDs", [
                                        ["EDIT", "IED Number", [10,{}]],
                                        ["EDIT", "Range", [300,{}]]
                                    ],
                                    {
                                        params ["_dialog", "_args"];
                                        _dialog params ["_number","_range"];
                                        _args params ["_sector"];                                   
                                        [_sector, parseNumber _range, ceil((parseNumber _number)/3)] remoteExec ["ied_manager", 2];
            }, {}, [_sector]] call zen_dialog_fnc_create;

            
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_attack_infantry_root_action = [
        "SectorAttackInfantryRoot",
        "Attack Sector (Infantry only)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            //["", true , getMarkerPos _sector] spawn spawn_battlegroup;
            ["", true , getMarkerPos _sector] remoteExec ["spawn_battlegroup", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_attack_sf_root_action = [
        "SectorAttackInfantryRoot",
        "Attack Sector (Special Forces only)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            //["", true , getMarkerPos _sector] spawn spawn_battlegroup;
            ["", true , getMarkerPos _sector,true] remoteExec ["spawn_battlegroup", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_attack_armoured_root_action = [
        "SectorAttackArmouredRoot",
        "Attack Sector (Infantry and Armoured)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            //["", false , getMarkerPos _sector] spawn spawn_battlegroup;
            ["", false , getMarkerPos _sector]  remoteExec ["spawn_battlegroup", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_attack_plane_root_action = [
        "SectorAttackPlaneRoot",
        "Attack Sector (Plane)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector,1]  remoteExec ["spawn_air", 2];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_attack_chopper_root_action = [
        "SectorAttackChopperRoot",
        "Attack Sector (Chopper)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector,1,true]  remoteExec ["spawn_air", 2];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_paratroopers_chopper_root_action = [
        "SectorChopperParatroopersRoot",
        "Paratroopers Sector (chopper)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector] remoteExec['send_paratroopers', 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_paratroopers_plane_root_action = [
        "SectorPlaneParatroopersRoot",
        "Paratroopers Sector (Plane)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector,objNull,true] remoteExec['send_paratroopers', 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;


    private _sector_reinforce_root_action = [
        "SectorReinforceRoot",
        "Reinforce Sector",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            (!(_sector in blufor_sectors))
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_reinforce_plane_root_action = [
        "SectorReinforcementPlaneRoot",
        "Reinforce Sector (Plane)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector,1]  remoteExec ["spawn_air", 2];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_reinforce_chopper_root_action = [
        "SectorReinforcementChopperRoot",
        "Reinforce Sector (Chopper)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector,1,true]  remoteExec ["spawn_air", 2];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_reinforce_paratroopers_chopper_root_action = [
        "SectorChopperParatroopersRoot",
        "Paratroopers Sector (chopper)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector] remoteExec['send_paratroopers', 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_reinforce_paratroopers_plane_root_action = [
        "SectorPlaneParatroopersRoot",
        "Paratroopers Sector (Plane)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            [getMarkerPos _sector,objNull,true] remoteExec['send_paratroopers', 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;


    private _sector_other_root_action = [
        "SectorOtherRoot",
        "Other",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            (_sector in sectors_allSectors)
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_copy_root_action = [
        "SectorCopyRoot",
        "Copy Sector Id",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            systemChat _sector;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _sector_clearcache_root_action = [
        "SectorSectorCacheRoot",
        "Clear Sector Cache",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
            _cached_index =  KP_liberation_Sector_Cache findif { (_x select 0) == _sector };
            if (_cached_index > -1) then {
                KP_liberation_Sector_Cache deleteAt _cached_index;
                publicVariable "KP_liberation_Sector_Cache";
            };
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;
    


    private _fob_control_root_action = [
        "FOBControlRoot",
        "FOB Actions",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [50, _position] call KPLIB_fnc_getNearestSector;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            ((_position distance _nearfob) < GRLIB_base_range) || ( getMarkerType "startbase_range" != "" && _position inArea "startbase_range")
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _fob_attack_root_action = [
        "FOBAttackRoot",
        "Attack FOB",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        }
    ] call zen_context_menu_fnc_createaction;

    private _fob_attack_infantry_root_action = [
        "FOBAttackInfantryRoot",
        "Attack FOB (Infantry only)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            //["", true , _nearfob] spawn spawn_battlegroup;
            ["", true , _nearfob] remoteExec ["spawn_battlegroup", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _fob_attack_sf_root_action = [
        "FOBAttackInfantryRoot",
        "Attack FOB (Special Forces only)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            //["", true , _nearfob] spawn spawn_battlegroup;
            ["", true , _nearfob,true] remoteExec ["spawn_battlegroup", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _fob_attack_armoured_root_action = [
        "FOBAttackArmouredRoot",
        "Attack FOB (Infantry and Armoured)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            //["", false , _nearfob] spawn spawn_battlegroup;
            ["", false , _nearfob] remoteExec ["spawn_battlegroup", 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;
        
    private _fob_attack_plane_root_action = [
        "FOBAttackPlaneRoot",
        "Attack FOB (Plane)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            [_nearfob,1]  remoteExec ["spawn_air", 2];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _fob_attack_chopper_root_action = [
        "FOBAttackChopperRoot",
        "Attack FOB (Chopper)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            [_nearfob,1,true]  remoteExec ["spawn_air", 2];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _fob_paratroopers_chopper_root_action = [
        "FOBChopperParatroopersRoot",
        "Paratroopers FOB (chopper)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            [_nearfob] remoteExec['send_paratroopers', 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _fob_paratroopers_plane_root_action = [
        "FOBPlaneParatroopersRoot",
        "Paratroopers FOB (Plane)",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _nearfob = [_position] call KPLIB_fnc_getNearestFob;
            [_nearfob,objNull,true] remoteExec['send_paratroopers', 2];
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _spawn_template_root_action = [
        "TemplateSpawnControlRoot",
        "Spawn Template",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
        }
    ] call zen_context_menu_fnc_createaction;

    private _spawn_template_blufor_action = [
        "TemplateSpawnBluforControlRoot",
        "Blufor",
        ["", [1, 1, 1, 1]],
        {
            _pos = (_this select 0);
            _ids = [];
            _names = [];
            {
                if ((_y select 4) == GRLIB_side_friendly ) then {
                    _ids pushBack _x;
                    _names pushBack (_y select 0)
                };
            } forEach GRLIB_Templates;
            ["Spawn Blufor Template", [
                                        ["LIST", "Templates", [_ids,_names,0]]
                                    ],
                                    {
                                        params ["_dialog", "_args"];
                                        _dialog params ["_template"];
                                        _args params ["_position"];
                                        //[_template,_position,0] call SpawnTemplate;     
                                        [_template,_position,0] remoteExec ["SpawnTemplate", 2];                      
                                    }, {}, [_pos]] call zen_dialog_fnc_create;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    private _spawn_template_opfor_action = [
        "TemplateSpawnOpforControlRoot",
        "Opfor",
        ["", [1, 1, 1, 1]],
        {
            _pos = (_this select 0);
            _ids = [];
            _names = [];
            {
                if ((_y select 4) == GRLIB_side_enemy ) then {
                    _ids pushBack _x;
                    _names pushBack (_y select 0)
                };
            } forEach GRLIB_Templates;
            ["Spawn Blufor Template", [
                                        ["LIST", "Templates", [_ids,_names,0]]
                                    ],
                                    {
                                        params ["_dialog", "_args"];
                                        _dialog params ["_template"];
                                        _args params ["_position"];
                                        //[_template,_position,0] call SpawnTemplate;     
                                        [_template,_position,0] remoteExec ["SpawnTemplate", 2];                      
                                    }, {}, [_pos]] call zen_dialog_fnc_create;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            true
        }
    ] call zen_context_menu_fnc_createaction;

    [_spawn_template_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_spawn_template_blufor_action, ["TemplateSpawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_spawn_template_opfor_action, ["TemplateSpawnControlRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sectror_control_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_sector_spawn_control_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    
    [_sector_control_auto_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_forced_spawn_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_forced_despawn_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_spawn_civ_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_show_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_hide_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sector_task_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_liberate_task_root_action, ["SectrorControlRoot", "SectorTasksRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_destroy_task_root_action, ["SectrorControlRoot", "SectorTasksRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_remove_tasks_root_action, ["SectrorControlRoot", "SectorTasksRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sector_attack_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_attack_infantry_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_ambush_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_attack_sf_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_attack_armoured_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_attack_plane_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_attack_chopper_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_paratroopers_chopper_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_paratroopers_plane_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sector_reinforce_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_reinforce_plane_root_action, ["SectrorControlRoot", "SectorReinforceRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_reinforce_chopper_root_action, ["SectrorControlRoot", "SectorReinforceRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_reinforce_paratroopers_chopper_root_action, ["SectrorControlRoot", "SectorReinforceRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_reinforce_paratroopers_plane_root_action, ["SectrorControlRoot", "SectorReinforceRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sector_other_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_copy_root_action, ["SectrorControlRoot", "SectorOtherRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_clearcache_root_action, ["SectrorControlRoot", "SectorOtherRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_ied_root_action, ["SectrorControlRoot", "SectorOtherRoot"], 0] call zen_context_menu_fnc_addAction;

    [_fob_control_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_root_action, ["FOBControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_infantry_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_sf_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_armoured_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_plane_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_chopper_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_paratroopers_chopper_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_paratroopers_plane_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    

    private _ai_root_action = [
        "AIRoot",
        "AI",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];

        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            count _objects > 0 || count _groups > 0
        }
    ] call zen_context_menu_fnc_createaction;

    private _stationary_vehicle_root_action = [
        "StationaryVehicle",
        "Stationary Vehicle",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            {
                [_x] spawn stationary_vehicle;
            } forEach (_objects select { (_x isKindOf "LandVehicle" || _x isKindOf "Air") && (count (crew _x) > 0)});
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            (({ (_x isKindOf "LandVehicle" || _x isKindOf "Air") && (count (crew _x) > 0)} count _objects) > 0)
        }
    ] call zen_context_menu_fnc_createaction;

    private _overwatch_sniper_root_action = [
        "OverwatchSniper",
        "Overwatch Sniper",
        ["", [1, 1, 1, 1]],
        {
            _sector = [999999, _position] call KPLIB_fnc_getNearestSector;
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            {
                [_x, _sector] spawn sniper_ai;
            } forEach (_objects select {_x isKindOf "Man" && !(isPlayer _x)});
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            ({_x isKindOf "Man" && !(isPlayer _x) } count _objects) > 0
        }
    ] call zen_context_menu_fnc_createaction;

    private _flee_root_action = [
        "Flee",
        "Flee",
        ["", [1, 1, 1, 1]],
        {
            _sector = [999999, _position] call KPLIB_fnc_getNearestSector;
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            {
                [_x,_sector] call KPLIB_fnc_makeUnitFlee;
            } forEach (_objects select {_x isKindOf "Man" && (side _x == GRLIB_side_enemy) && !(isPlayer _x)});
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            ({_x isKindOf "Man" && (side _x == GRLIB_side_enemy) && !(isPlayer _x) } count _objects) > 0
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _search_light_root_action = [
        "SearchLight",
        "Search Light",
        ["", [1, 1, 1, 1]],
        {
            
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            {
                [_x] spawn search_light_ai;
            } forEach (_objects select { (_x isKindOf "LandVehicle") && (count (crew _x) > 0)});
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            (({ (_x isKindOf "LandVehicle") && (count (crew _x) > 0)} count _objects) > 0)
        }
    ] call zen_context_menu_fnc_createaction;

    [_ai_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_stationary_vehicle_root_action, ["AIRoot"], 0] call zen_context_menu_fnc_addAction;
    [_overwatch_sniper_root_action, ["AIRoot"], 0] call zen_context_menu_fnc_addAction;
    [_flee_root_action, ["AIRoot"], 0] call zen_context_menu_fnc_addAction;
    [_search_light_root_action, ["AIRoot"], 0] call zen_context_menu_fnc_addAction;
};