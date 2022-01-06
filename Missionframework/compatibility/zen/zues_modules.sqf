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
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
            _sector != "" && !((_sector in blufor_sectors) && (_sector in sectors_destroyable))
        }
    ] call zen_context_menu_fnc_createaction;
    
    private _sector_spawn_control_root_action = [
        "SectorspawnControlRoot",
        "Sector spawn",
        ["", [1, 1, 1, 1]],
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
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
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
            sectors_forced_despawn deleteAt (sectors_forced_despawn find _sector);
            sectors_forced_spawn deleteAt (sectors_forced_spawn find _sector);
            publicVariable "sectors_forced_spawn";
            publicVariable "sectors_forced_despawn";
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
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
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
            sectors_forced_despawn pushBack _sector;
            sectors_forced_spawn deleteAt (sectors_forced_spawn find _sector);
            publicVariable "sectors_forced_spawn";
            publicVariable "sectors_forced_despawn";
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
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
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
            sectors_forced_spawn pushBack _sector;
            sectors_forced_despawn deleteAt (sectors_forced_despawn find _sector);
            publicVariable "sectors_forced_spawn";
            publicVariable "sectors_forced_despawn";
        },
        {
            params["_position", "_objects", "_groups", "_waypoints", "_markers", "_hoveredEntity", "_args"];
            _sector = [30, _position] call KPLIB_fnc_getNearestSector;
            _sector != "" && !((_sector in blufor_sectors) && (_sector in sectors_destroyable))
            && !(_sector in sectors_forced_spawn)
        }
    ] call zen_context_menu_fnc_createaction;
    
    [_sectror_control_root_action, [], 0] call zen_context_menu_fnc_addAction;
    [_sector_spawn_control_root_action, ["SectrorControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_auto_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_forced_spawn_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
    [_sector_control_forced_despawn_action, ["SectrorControlRoot", "SectorspawnControlRoot"], 0] call zen_context_menu_fnc_addAction;
};