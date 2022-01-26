params["_target", "_player", "_entity"];

[
    [
        ["SSS_RTB", "RTB", "z\SSS\addons\main\ui\icons\home.paa", {
                (_this# 2) call SSS_support_fnc_requestTransportLandVehicle;
            }, {
                (_this# 2# 0) getVariable "SSS_awayFromBase"
            }, {},
            [_entity, "RTB"]
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
        ["SSS_MoveEngOff", "Move - Engine Off", "z\SSS\addons\main\ui\icons\move_eng_off.paa", {
                _this call SSS_interaction_fnc_selectPosition;
            }, {
                true
            }, {},
            [_entity, "MOVE_ENG_OFF"]
        ] call ace_interact_menu_fnc_createAction, [], _target
    ],

    [
        ["SSS_Behavior", "Change Behavior", "z\SSS\addons\main\ui\icons\gear.paa", {
            private _entity = _this# 2;

            ["Change Behavior", [
                ["COMBOBOX", "Speed Mode", [
                    ["LIMITED", "NORMAL", "FULL"], _entity getVariable "SSS_speedMode"
                ]],
                ["COMBOBOX", "Combat Mode", [
                    ["Fire At will", "Hold Fire"], _entity getVariable "SSS_combatMode"
                ]],
                ["CHECKBOX", "Headlight", _entity getVariable "SSS_lightsOn"],
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