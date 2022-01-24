/*
    Specific object init codes depending on classnames.

    Format:
    [
        Array of classnames as strings <ARRAY>,
        Code to apply <CODE>,
        Allow inheritance <BOOL> (default false)
    ]
    _this is the reference to the object with the classname

    Example:
        KPLIB_objectInits = [
            [
                ["O_soldierU_F"],
                {systemChat "CSAT urban soldier was spawned!"}
            ],
            [
                ["CAManBase"],
                {systemChat format ["Some human named '%1' was spawned!", name _this]},
                true
            ]
        ];
*/

KPLIB_objectInits = [
    // Set KP logo on white flag
    [
        ["Flag_White_F"],
        {_this setFlagTexture blufor_flag_texture;}
    ],

    // Add helipads to zeus, as they can't be recycled after built
    [
        ["Helipad_base_F", "LAND_uns_Heli_pad", "Helipad", "LAND_uns_evac_pad", "LAND_uns_Heli_H"],
        {{[_x, [[_this], true]] remoteExecCall ["addCuratorEditableObjects", 2]} forEach allCurators;},
        true
    ],

    // Add ViV and build action to FOB box/truck
    [
        [FOB_box_typename, FOB_truck_typename],
        {
            [_this] spawn {
                params ["_fobBox"];
                waitUntil {sleep 0.1; time > 0};
                [_fobBox] call KPLIB_fnc_setFobMass;
                if ((typeOf _fobBox) isEqualTo FOB_box_typename) then {
                    [_fobBox] call KPLIB_fnc_setFobMass;
                    [_fobBox] remoteExecCall ["KPLIB_fnc_setLoadableViV", 0, _fobBox];
                };
                [_fobBox] remoteExecCall ["KPLIB_fnc_addActionsFob", 0, _fobBox];
            };
        }
    ],

    // Add limited Arsnal to loadout box
    [
        [KP_liberation_loadoutbox_classname],
        {
            if (KPLIB_firstTime) then {
                _this call jn_fnc_arsenal_addInitialArsenalItems;
            };

            _t= createVehicle ["CBA_B_InvisibleTargetVehicle",getPosATL _this]; 
            createVehicleCrew _t;
            _t attachTo [_this, [0, 0, 0.5]];
            if (KP_liberation_ace) then {
                [_t, false, [0, 1.5, 0], 0] remoteExec ["ace_dragging_fnc_setCarryable",0,true];
                [_t, false, [0, 2, 0], 0] remoteExec ["ace_dragging_fnc_setDraggable",0,true];
            };
            _this setVariable ["attached_target",_t,true];
            _this addMPEventHandler ["MPKilled", {
                params ["_unit", "_killer", "_instigator", "_useEffects"];
                _attached_target = _unit getVariable ["attached_target",objNull];
                    if !(isnull _attached_target) then {
                        deleteVehicle _attached_target;
                    };
                }];
            _this setMass 500;
            if (KP_liberation_ace) then {
                [_this, true, [0, 1.5, 0], 0] remoteExec ["ace_dragging_fnc_setCarryable",0,true];
                [_this, true, [0, 2, 0], 0] remoteExec ["ace_dragging_fnc_setDraggable",0,true];
                };
            [_this, []] call jn_fnc_arsenal_initPersistent; 
        }
    ],

    // Add FOB building damage handler override and repack action
    [
        [FOB_typename],
        {
            _this addEventHandler ["HandleDamage", {0}];
            [_this] spawn {
                params ["_fob"];
                waitUntil {sleep 0.1; time > 0};
                [_fob] remoteExecCall ["KPLIB_fnc_addActionsFob", 0, _fob];
            };
        }
    ],
    // Add storage type variable to built storage areas (only for FOB built/loaded ones)
    [
        [KP_liberation_small_storage_building, KP_liberation_large_storage_building],
        {_this setVariable ["KP_liberation_storage_type", 0, true];}
    ],

    // Add ACE variables to corresponding building types
    [
        [KP_liberation_recycle_building],
        {_this setVariable ["ace_isRepairFacility", 1, true];}
    ],
    [
        KP_liberation_medical_facilities,
        {_this setVariable ["ace_medical_isMedicalFacility", true, true];}
    ],
    [
        KP_liberation_medical_vehicles,
        {_this setVariable ["ace_medical_isMedicalVehicle", true, true];}
    ],

    // Hide Cover on big GM trucks
    [
        ["gm_ge_army_kat1_454_cargo", "gm_ge_army_kat1_454_cargo_win"],
        {_this animateSource ["cover_unhide", 0, true];}
    ],

    // Make sure a slingloaded object is local to the helicopter pilot (avoid desync and rope break)
    [
        ["Helicopter"],
        {if (isServer) then {[_this] call KPLIB_fnc_addRopeAttachEh;} else {[_this] remoteExecCall ["KPLIB_fnc_addRopeAttachEh", 2];};},
        true
    ],

    // Add valid vehicles to support module, if system is enabled
    [
        KP_liberation_suppMod_artyVeh,
        {if (KP_liberation_suppMod > 0) then {KPLIB_suppMod_arty synchronizeObjectsAdd [_this];};}
    ],

    // Disable autocombat (if set in parameters) and fleeing
    [
        ["Man"],
        {
            if (!(GRLIB_autodanger) && {(side _this) isEqualTo GRLIB_side_friendly}) then {
                _this disableAI "AUTOCOMBAT";
            };
            _this allowFleeing 0;
        },
        true
    ],
    // Disable enable Radars based on combat_readiness
    [
        (opfor_SAM apply {_x select 0}),
        {
            if (combat_readiness > KP_Radars_Enable_On_Combat_Readiness_Above) then {
                _this setvehicleRadar 1;
            } else {
                _this setvehicleRadar 0;
            };
        },
        true
    ],
     // add halo actions to halo devices
    [
        KPLIB_C130_halo_devices,
        {
            _this execVM "scripts\client\group_halo\add_helo_actions.sqf";
        },
        true
    ],
     // add map
    [
        ["Land_MapBoard_F"],
        {
            _this setObjectTextureGlobal [0, "res\map.paa"]; 
        },
        true
    ],
    //special forces fixing
    [
        (KPLIB_o_sf_classes + ["UK3CB_ARD_O_SF_LAT"]),
        {
            _this setSkill 1;
            _this addGoggles "G_Bandanna_tan"; 
            _this addHeadgear "PO_H_PASGT_M81_3"; 
            _this additem "UK3CB_ANPVS7";
            _this assignitem "UK3CB_ANPVS7";
        },
        true
    ]
];
