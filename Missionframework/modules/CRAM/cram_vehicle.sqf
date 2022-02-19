params["_cram", "_range"];



_null = [_cram, _range] spawn {
    private["_cram", "_range", "_incoming", "_target", "_targetTime"];
    _cram = _this select 0;
    _range = _this select 1;
    if (FSG_DEBUG) then {
        systemChat ("CRAM vehicle init " + str _cram);
    };
    while {
        alive _cram
    }
    do {
        _incoming = _cram nearObjects["ShellBase", _range * 2];
        _incoming = _incoming + (_cram nearObjects["MissileBase", _range * 2]);
        _incoming = _incoming + (_cram nearObjects["RocketBase", _range * 2]);
        _coutInc = count _incoming;
        _incoming = _incoming select {
                _shooters = (getShotParents _x); 
                if (count _shooters > 0 ) then {
                    (side ((getShotParents _x) select 1)) != East
                } else {
                    false
                };
            };
        _incoming = [_incoming, [_cram], { _input0  distance _x }, "ASCEND"] call BIS_fnc_sortBy;
        if (count _incoming > 0) then {
            if (FSG_DEBUG) then {
                systemChat("CRAM Target = " + str count _incoming + "/" + str _coutInc);
            };
            _target = _incoming select 0;
            _fromTarget = _target getDir _cram;
            _dirTarget = direction _target;
            if (_dirTarget < _fromTarget + 25 && _dirTarget > _fromTarget - 25 && ((getPos _target) select 2) > 20 && alive _target) then {

                while {
                    alive _cram && alive _target && (_cram weaponDirection(currentWeapon _cram)) select 2 < 0.15
                }
                do {
                    _cram doWatch _target;
                    sleep 0.1;
                };
                waitUntil { (_cram distance2d  _target) < _range || !alive _cram || !alive _target };
                _targetTime = time + 3;
                while {
                        alive _cram && alive _target && _targetTime > time && (_cram weaponDirection(currentWeapon _cram)) select 2 > 0.15
                }
                do {
                    _cram doWatch _target;
                    if ((_cram weaponDirection(currentWeapon _cram)) select 2 > 0.15) then {
                        
                        _cram fireAtTarget[_target, (currentWeapon _cram)];
                    };
                };
            };
            if (alive _target && alive _cram && _target distance _cram < FSG_CRAMDIS && _target distance _cram > 40 && (getPos _target) select 2 > 20) then {
                _null = [_target, _cram] spawn {
                    private["_target", "_cram", "_expPos", "_exp"];

                    _target = _this select 0;
                    _cram = _this select 1;
                    if (FSG_DEBUG) then {
                        systemChat ("CRAM Target destroyed " + str _target);
                    };
                    _expPos = getPos _target;
                    deleteVehicle _target;
                    sleep 1;
                    _exp = "helicopterexplosmall"
                    createVehicle _expPos;
                };
            };
        };
        if (count _incoming == 0) then {
            sleep 1;
        };
    };
};