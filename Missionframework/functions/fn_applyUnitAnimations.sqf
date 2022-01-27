
params ["_unit"];

headParts = ["face_hub",
            "neck",
            "head",
            "head_hit"
        ];

bodyParts = ["pelvis",
            "spine1",
            "spine2",
            "spine3",
            "body",
            "leg_l", "legs"
        ];

armsParts = ["arms", "head_hit", "hand_r", "hands", "hand_l"];

[_unit] spawn {
params ["_unit"];
    sleep 5;
    _unit addEventHandler ["AnimDone", {
                params ["_unit", "_anim"];
                if ((KPLIB_Allow_AI_Unconscious_Animations && !(isplayer _unit))  || (KPLIB_Allow_Player_Unconscious_Animations  && (isplayer _unit) )) then {
                        if ( alive _unit && (isNull objectParent _unit) && (_unit getVariable["ACE_isUnconscious", false])) then {
                            _bodyPartStatus= _unit getvariable ["ace_medical_bodyPartStatus", [0,0,0,0,0,0]];
                            _ind =  _bodyPartStatus find (selectmax _bodyPartStatus);
                            switch (_ind) do {
                                case 0: { 
                                    //head
                                    _unit switchMove "Acts_CivilInjuredHead_1";
                                };
                                case 1: { 
                                    //Torso
                                    _unit switchMove "Acts_CivilInjuredChest_1";
                                };
                                case 2: { 
                                    //ArmLeft
                                    _unit switchMove "Acts_CivilInjuredArms_1";
                                };
                                case 3 : { 
                                    //ArmRight 
                                    _unit switchMove "Acts_CivilInjuredArms_1";
                                };
                                case 4 : { 
                                    //LegLeft
                                    _unit switchMove "acts_civilinjuredlegs_1";
                                };
                                case 5 : { 
                                    //LegRight
                                    _unit switchMove "acts_civilinjuredlegs_1";
                                };
                                default  { 
                                    //none
                                    _unit switchMove "Acts_CivilInjuredGeneral_1";
                                };
                            };
                        };
                };
            }];


    if (local _unit) then {
        _unit addEventHandler["HitPart", {
            (_this select 0) params["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
                if ((KPLIB_Allow_AI_Hit_Animations && !(isplayer _target))  || (KPLIB_Allow_Player_Hit_Animations  && (isplayer _target) )) then {
                    [_target,_selection] spawn {
                    params ["_target","_selection"];
                    _part = "";
                    if ((isNull objectParent _target) && (stance  _target != "PRONE") && alive _target && !(_target getVariable["ACE_isUnconscious", false])) then {

                        if (count(_selection arrayIntersect headParts) > 0) then {
                            _part = "head";
                        } else {
                            if (count(_selection arrayIntersect armsParts) > 0) then {
                                _part = "arms";
                            } else {
                                if (count(_selection arrayIntersect bodyParts) > 0) then {
                                    _part = "body";
                                };
                            };
                        };
                        switch ("body") do {
                            case "head":{
                                    [_target, 'kka3_injured_head1'] remoteExec['playActionNow', 0];
                                    //_target playActionNow  'kka3_injured_head1';
                                    _target setVariable["inInjGesture", true, true];
                                    sleep(2);
                                    [_target, 'GestureNod'] remoteExec['playActionNow', 0];
                                    //_target playActionNow  'GestureNod';
                                    sleep(10);
                                    _target setVariable["inInjGesture", false, true];
                                };
                            case "body":{
                                    [_target, 'kka3_injured_chest1'] remoteExec['playActionNow', 0];
                                    //_target playActionNow  'kka3_injured_chest1';
                                    _target setVariable["inInjGesture", true, true];
                                    sleep(3);
                                    [_target, 'GestureNod'] remoteExec['playActionNow', 0];
                                    //_target playActionNow  'GestureNod';
                                    sleep(10);
                                    _target setVariable["inInjGesture", false, true];
                                };
                            case "arms":{
                                    [_target, 'kka3_injured_arms1'] remoteExec['playActionNow', 0];
                                    //_target playActionNow  'kka3_injured_arms1';
                                    _target setVariable["inInjGesture", true, true];
                                    sleep(3);
                                    [_target, 'GestureNod'] remoteExec['playActionNow', 0];
                                    //_target playActionNow  'GestureNod';
                                    sleep(10);
                                    _target setVariable["inInjGesture", false, true];
                                };
                        };
                    };
                };
            }; 
            
        }];
    };
};