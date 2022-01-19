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
    
    ["Liberation", "Reinforce Sector (paratroopers)", {
        _pos = (_this select 0);
        _mark = [1000, _pos] call KPLIB_fnc_getNearestSector;
        [_mark] remoteExec['send_paratroopers', 2];
        // [_mark] spawn send_paratroopers;
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
    
    private _sector_control__spawn_civ_action = [
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



    [_sectror_control_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_sector_spawn_control_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    
    [_sector_control_auto_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_forced_spawn_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_forced_despawn_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control__spawn_civ_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sector_task_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_liberate_task_root_action, ["SectrorControlRoot", "SectorTasksRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_destroy_task_root_action, ["SectrorControlRoot", "SectorTasksRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_remove_tasks_root_action, ["SectrorControlRoot", "SectorTasksRoot"], 0] call zen_context_menu_fnc_addAction;

    [_sector_attack_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_attack_infantry_root_action, ["SectrorControlRoot", "SectorAttackRoot"], 0] call zen_context_menu_fnc_addAction;
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

    [_fob_control_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_root_action, ["FOBControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_infantry_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_sf_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_armoured_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_plane_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_attack_chopper_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_paratroopers_chopper_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    [_fob_paratroopers_plane_root_action, ["FOBControlRoot", "FOBAttackRoot"], 0] call zen_context_menu_fnc_addAction;
    
};