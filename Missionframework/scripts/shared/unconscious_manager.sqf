["ace_unconscious", {
    params["_unit", "_isUnconscious"];
    if (local _unit) then {
        if (_isUnconscious) then {
            if (isplayer _unit) then {
                _unconscious_time = _unit getVariable["unconscious_time", 0];
                if (_unconscious_time > 3) then {
                    _unit setVariable["ace_medical_deathblocked", false, true];
                    _unit setVariable["unconscious_time", 0, true];
                } else {
                    _unit setVariable["unconscious_time", (_unconscious_time + 1), true];
                };
            } else {

                _ace_killer = _unit getVariable["ace_medical_lastinstigator", objNull];
                if (isNull _ace_killer) then {
                    _ace_killer = _unit getVariable["ace_medical_lastDamageSource", objNull];
                };
                if !(isNull _ace_killer) then {
                    _unit setVariable["ace_killer", vehicle _ace_killer, true];
                };
                if ((toLower(typeOf(vehicle _ace_killer))) in KPLIB_allLandVeh_classes || (vehicle _ace_killer) isKindOf "Tank") then {
                    _unit setVariable["ace_killer_type", "land", true];
                } else {
                    if ((toLower(typeOf(vehicle _ace_killer))) in KPLIB_allAirVeh_classes || (vehicle _ace_killer) isKindOf "Plane" || (vehicle _ace_killer) isKindOf "Helicopter") then {
                        _unit setVariable["ace_killer_type", "air", true];
                    } else {
                        if (_ace_killer isKindOf "Man") then {
                            _unit setVariable["ace_killer_type", "man", true];
                        };
                    };
                };

            };
        };
    };
    [_unit, _isUnconscious] spawn {
        params["_unit", "_isUnconscious"];
        if ((KPLIB_Allow_AI_Unconscious_Animations && !(isplayer _unit))  || (KPLIB_Allow_Player_Unconscious_Animations  && (isplayer _unit) ))  then {
            if (_isUnconscious && (isNull objectParent _unit)) then {
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
    };

}] call CBA_fnc_addEventHandler;