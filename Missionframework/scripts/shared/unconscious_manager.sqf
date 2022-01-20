["ace_unconscious", {
    params ["_unit", "_isUnconscious"];
    if (_isUnconscious) then {
        if (isplayer _unit) then {
            _unconscious_time= _unit getVariable ["unconscious_time",0];
            if (_unconscious_time>3) then {
                _unit setVariable ["ace_medical_deathblocked", false, true ];
                _unit setVariable ["unconscious_time", 0, true ];
            } else {
                _unit setVariable ["unconscious_time", (_unconscious_time +1), true ];
            };
        } else {
            if (isServer || (local _unit)) then {
                _ace_killer  = _unit getVariable ["ace_medical_lastinstigator",objNull];
                if (isNull _ace_killer) then {
                    _ace_killer  = _unit getVariable ["ace_medical_lastDamageSource",objNull];
                };
                if !(isNull _ace_killer) then {
                    _unit setVariable ["ace_killer", vehicle _ace_killer, true ];
                };
                if ((toLower (typeOf (vehicle _ace_killer))) in KPLIB_allLandVeh_classes || (vehicle _ace_killer ) isKindOf "Tank") then  {
                        _unit setVariable ["ace_killer_type","land", true ];
                    }else{
                        if ((toLower (typeOf (vehicle _ace_killer))) in KPLIB_allAirVeh_classes || (vehicle _ace_killer ) isKindOf "Plane" || (vehicle _ace_killer ) isKindOf "Helicopter" ) then  {
                            _unit setVariable ["ace_killer_type","air", true ];
                        }else{
                            if (_ace_killer isKindOf "Man") then {
                                _unit setVariable ["ace_killer_type","man", true ];
                            };
                        };
                    };
            };
        };
    };
}] call CBA_fnc_addEventHandler;

