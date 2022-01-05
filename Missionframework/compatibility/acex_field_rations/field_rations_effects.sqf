[] spawn {
    _updateCounter = 0;
    while {true} do {
        sleep 20;
        _rations_hunger= ACE_player getVariable "acex_field_rations_hunger";
        _field_rations_thirst = ACE_player getVariable "acex_field_rations_thirst";
        
        if (_rations_hunger > 80 || _field_rations_thirst >80) then {

            "colorCorrections" ppEffectAdjust [1, 0.4, 0, [0, 0, 0, 0], [1, 1, 1, 0], [1, 1, 1, 0]];
            "colorCorrections" ppEffectCommit 0;
            "colorCorrections" ppEffectEnable true;

            _ppColor = ppEffectCreate ["ColorCorrections", 1001];
            _ppColor ppEffectEnable true;
            _ppColor ppEffectForceInNVG true;
            _ppColor ppEffectAdjust [0.26, 1, 0, [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
            _ppColor ppEffectCommit 0.2;
            sleep 0.15;
            _ppColor ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.5, 0.5, 0.5, 0.5]];
            _ppColor ppEffectCommit 0.15;
            sleep 0.15;
            _ppColor ppEffectEnable false;
            ppEffectDestroy _ppColor;
			
            "colorCorrections" ppEffectAdjust [1, 0.4, 0, [0, 0, 0, 0], [1, 1, 1, 0], [1, 1, 1, 0]];
            "colorCorrections" ppEffectCommit 0;
            "colorCorrections" ppEffectEnable true;
        } else {
            "colorCorrections" ppEffectEnable false;
        };
        if(_updateCounter>=1) then {
            if ((getPlayerUID player) in KPLIB_acex_field_rations_execluded_players) then {
                player setVariable ["acex_field_rations_hunger",0,true];
                player setVariable ["acex_field_rations_thirst",0,true];
            }else{
                _rations_hunger= ACE_player getVariable "acex_field_rations_hunger";
                _field_rations_thirst = ACE_player getVariable "acex_field_rations_thirst";
                player setVariable ["acex_field_rations_hunger",_rations_hunger,true];
                player setVariable ["acex_field_rations_thirst",_field_rations_thirst,true];
            };
        };
        _updateCounter =_updateCounter+1;
    };
};