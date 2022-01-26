params["_target", "_player", "_entity"];

[
    [
        ["SSS_SignalConfirm", "Confirm Signal", "z\SSS\addons\main\ui\icons\land_green.paa", {
            private _entity = _this# 2;
            _entity setVariable["SSS_signalApproved", true, true];
            _entity setVariable["SSS_needConfirmation", false, true];
        }, {
            (_this# 2) getVariable "SSS_needConfirmation"
        }, {}, _entity] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_SignalDeny", "Search for new Signal", "z\SSS\addons\main\ui\icons\search_yellow.paa", {
            private _entity = _this# 2;
            _entity setVariable["SSS_signalApproved", false, true];
            _entity setVariable["SSS_needConfirmation", false, true];
        }, {
            (_this# 2) getVariable "SSS_needConfirmation"
        }, {}, _entity] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_SlingLoadSelect", "Select object to sling load", ["z\SSS\addons\main\ui\icons\slingLoad.paa", "#20ca24"], {
            params["_target", "_player", "_entity"];

            private _vehicle = _entity getVariable "SSS_vehicle";
            private _position = _entity getVariable["SSS_slingLoadPosition", getPos _vehicle];
            private _objects = (nearestObjects[_position, SSS_slingLoadWhitelist, SSS_setting_slingLoadSearchRadius]) select {
                _vehicle canSlingLoad _x && {
                    side _vehicle getFriend side _x >= 0.6
                }
            };

            if (_objects isEqualTo[]) exitWith {
                [_entity, "No sling loadable objects nearby."] call SSS_common_fnc_notify;
            };

            private _cfgVehicles = configFile >> "CfgVehicles";
            private _rows = [];

            {
                private _cfg = _cfgVehicles >> typeOf _x;
                private _name = getText(_cfg >> "displayName");
                private _icon = getText(_cfg >> "picture");

                if (toLower _icon in ["", "picturething"]) then {
                    _icon = "z\SSS\addons\main\ui\icons\box.paa";
                };

                _rows pushBack[[_name, _icon], "", "", "", str(_x distance _position) + "m"];
            }
            forEach _objects;

            ["Select object", [
                    ["LISTNBOX", "Sling loadable objects:", [_rows, 0, 12]]
                ], {
                    params["_values", "_args"];
                    _values params["_index"];
                    _args params["_entity", "_objects"];

                    _entity setVariable["SSS_slingLoadObject", _objects# _index, true];
                    _entity setVariable["SSS_slingLoadReady", false, true];
                }, {},
                [_entity, _objects]
            ] call SSS_CDS_fnc_dialog;
        }, {
            (_this# 2) getVariable "SSS_slingLoadReady"
        }, {}, _entity] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Unhook", "Unhook", ["z\SSS\addons\main\ui\icons\slingLoad.paa", "#f5ca00"], {
                _this call SSS_interaction_fnc_selectPosition;
            }, {!isNull getSlingLoad(_this# 2# 0 getVariable "SSS_vehicle")
            }, {},
            [_entity, "UNHOOK"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_RTB", "RTB", "z\SSS\addons\main\ui\icons\home.paa", {
                (_this# 2) call SSS_support_fnc_requestTransportHelicopter;
            }, {
                (_this# 2# 0) getVariable "SSS_awayFromBase"
            }, {},
            [_entity, "RTB"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Pickup", "Pickup", "z\SSS\addons\main\ui\icons\smoke.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "PICKUP"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Land", "Land", "z\SSS\addons\main\ui\icons\land.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "LAND"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_LandEngOff", "Land - Engine Off", "z\SSS\addons\main\ui\icons\land_eng_off.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "LAND_ENG_OFF"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Move", "Move", "z\SSS\addons\main\ui\icons\move.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "MOVE"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Hover", "Hover/Fastrope", "z\SSS\addons\main\ui\icons\rope.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "HOVER"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Loiter", "Loiter", "z\SSS\addons\main\ui\icons\loiter.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "LOITER"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_SlingLoad", "Sling Load", "z\SSS\addons\main\ui\icons\slingLoad.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "SLINGLOAD"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Paradrop", "Paradrop", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "PARADROP"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Behavior", "Change Behavior", "z\SSS\addons\main\ui\icons\gear.paa", {
            private _entity = _this# 2;

            ["Change Behavior", [
                ["SLIDER", "Flying height", [
                    [40, 2000, 0], _entity getVariable "SSS_flyingHeight"
                ]],
                ["COMBOBOX", "Speed Mode", [
                    ["LIMITED", "NORMAL", "FULL"], _entity getVariable "SSS_speedMode"
                ]],
                ["COMBOBOX", "Combat Mode", [
                    ["Fire At will", "Hold Fire"], _entity getVariable "SSS_combatMode"
                ]],
                ["CHECKBOX", "Headlight", _entity getVariable "SSS_lightsOn"],
                ["CHECKBOX", "Collision lights", _entity getVariable "SSS_collisionLightsOn"],
                ["BUTTON", "Shut up!", {
                    params["_entity"];
                    private _vehicle = _entity getVariable "SSS_vehicle"; {
                        [_x, "NoVoice"] remoteExecCall["setSpeaker", 0]
                    }
                    forEach((crew _vehicle) arrayIntersect(units group _vehicle));
                    [_entity, "We'll be quiet."] call SSS_common_fnc_notify;
                }]
            ], {
                _this call SSS_common_fnc_changeBehavior;
            }, {}, _entity] call SSS_CDS_fnc_dialog;
        }, {
            true
        }, {}, _entity] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_SITREP", "SITREP", "\A3\Ui_f\data\IGUI\Cfg\simpleTasks\types\intel_ca.paa", {
            private _entity = _this# 2;
            private _vehicle = _entity getVariable["SSS_vehicle", objNull];
            _nearfobtext = "";
            if !(isnil "KPLIB_fnc_getNearestFob") then {
                _nearfob = [] call KPLIB_fnc_getNearestFob;
                _fobDist = _vehicle distance2d _fobPos;
                _nearfobtext = ["", ["Near FOB", [_nearfob] call KPLIB_fnc_getFobName] joinString " "] select (_fobDist < GRLIB_fob_range);
            };
        
            private _message = format["Location: Grid %1 %3 <br />%2<br />Fuel: %4% <br /> Ammo:  %5%", mapGridPosition _vehicle,
                switch true do {
                    case (!canMove _vehicle):{
                            "Status: Disabled"
                        };
                    case (damage _vehicle > 0):{
                            "Status: Damaged"
                        };
                    default {
                        "Status: Green"
                    };
                },_nearfobtext, str ((fuel _vehicle) *100 ), str ((getAmmoCargo _vehicle) *100 )];

            
            [_entity, _message] call SSS_common_fnc_notify;

            private _marker = createMarkerLocal[format["SSS_%1$%2$%3", _vehicle, CBA_missionTime, random 1], getPos _vehicle];
            _marker setMarkerShapeLocal "ICON";
            _marker setMarkerTypeLocal "mil_box";
            _marker setMarkerColorLocal "ColorGrey";
            _marker setMarkerTextLocal(_entity getVariable "SSS_callsign");
            _marker setMarkerAlphaLocal 1;

            [{
                params["_args", "_PFHID"];
                _args params["_vehicle", "_marker"];

                private _alpha = markerAlpha _marker - 0.005;
                _marker setMarkerAlphaLocal _alpha;

                if (alive _vehicle) then {
                    _marker setMarkerPosLocal getPosVisual _vehicle;
                };

                if (_alpha <= 0) then {
                    _PFHID call CBA_fnc_removePerFrameHandler;
                    deleteMarkerLocal _marker;
                };
            }, 0.1, [_vehicle, _marker]] call CBA_fnc_addPerFrameHandler;
        }, {
            true
        }, {}, _entity] call ace_interact_menu_fnc_createAction, [], _target
    ]
]