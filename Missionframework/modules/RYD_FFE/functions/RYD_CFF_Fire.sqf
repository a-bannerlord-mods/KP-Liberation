private["_battery", "_pos", "_ammo", "_amount", "_guns", "_vh", "_mags", "_amount0", "_eta", "_alive", "_available", "_perGun", "_rest", "_aGuns", "_perGun1", "_shots", "_tofire", "_rest0", "_bad", "_ammoC", "_ws", "_gun"];

_battery = _this select 0;
_pos = _this select 1;
_ammo = _this select 2;
_amount = _this select 3;

_eta = -1;

_guns = [];

{
    if not(isNull _x) then {
        {
            _vh = vehicle _x;
            if not(_vh in _guns) then {
                _shots = 0;
                
                {
                    if ((_x select 0) in _ammo) then {
                        _shots = _shots + (_x select 1)
                    }
                }
                forEach(magazinesAmmo _vh);
                
                _vh setVariable["RydFFE_Shotstofire", 0];
                _vh setVariable["RydFFE_MyShots", _shots];
                
                if (_shots > 0) then {
                    _guns set[(count _guns), _vh]
                }
            }
        }
        forEach(units _x)
    }
}
forEach _battery;

_aGuns = count _guns;

if (_aGuns < 1) exitwith {
    -1
};
if (_amount < 1) exitwith {
    -1
};

_perGun = floor(_amount / _aGuns);
_rest = _amount - (_perGun * _aGuns);

{
    _shots = _x getVariable["RydFFE_MyShots", 0];
    if not(_shots > _perGun) then {
        _x setVariable["RydFFE_Shotstofire", _shots];
        _amount = _amount - _shots;
        _rest = _rest + (_perGun - _shots);
        _x setVariable["RydFFE_MyShots", 0]
    } else {
        _x setVariable["RydFFE_Shotstofire", _perGun];
        _x setVariable["RydFFE_MyShots", _shots - _perGun]
    };
}
forEach _guns;

_bad = false;

while {(_rest > 0)} do {
    _rest0 = _rest;
    
    {
        if (_rest < 1) exitwith {};
        _shots = _x getVariable["RydFFE_MyShots", 0];
        
        if (_shots > 0) then {
            _tofire = _x getVariable["RydFFE_Shotstofire", 0];
            
            _rest = _rest - 1;
            
            _x setVariable["RydFFE_Shotstofire", _tofire + 1];
            _x setVariable["RydFFE_MyShots", _shots - 1]
        }
    }
    forEach _guns;
    
    if (not(_rest0 > _rest) and(_rest > 0)) exitwith {
        _bad = true
    }
};

if (_bad) exitwith {
    -1
};

{
    if not(isNull _x) then {
        _vh = vehicle _x;
        
        if ((_vh getVariable["RydFFE_Shotstofire", 0]) > 0) then {
  
            _mags = getArtilleryAmmo[_vh];
            
            _ammoC = (magazines _vh) select 0;
            
            {
                if (_x in _ammo) exitwith {
                    _ammoC = _x
                }
            }
            forEach(magazines _vh);
            
            if (_ammoC in _mags) then {
                _amount = _amount - 1;
                
                _newEta = _vh getArtilleryETA[_pos, _ammoC];
                
                if (not(isnil "_newEta") and {
                    ((_newEta < _eta) or(_eta < 0))
                }) then {
                    _eta = _newEta
                };
                
                [_vh, _pos, _ammoC] spawn {
                    _vh = _this select 0;
                    _pos = _this select 1;
                    _ammo = _this select 2;

                    _range= 0;
                    _min_range= 0;
                    if (typeof _vh in opfor_light_artillery) then {
                        _range = RydFFE_Light_Artillery_Max_Range;
                    };
                    if (typeof _vh in opfor_heavy_artillery) then {
                        _range = RydFFE_Heavy_Artillery_Max_Range;
                    };

                    if (typeof _vh in opfor_light_artillery) then {
                        _min_range = RydFFE_Light_Artillery_Min_Range;
                    };
                    if (typeof _vh in opfor_heavy_artillery) then {
                        _min_range = RydFFE_Heavy_Artillery_Min_Range;
                    };
                    _inRange = _pos inRangeOfArtillery[[_vh], _ammo];
                    _inRange =  _inRange && ((_pos distance _vh) < _range);
                    _inRange =  _inRange && ((_pos distance _vh) > _min_range);

                    if (_inRange) then {
                        
                        if (_ammo in (getArtilleryAmmo[_vh])) then {
                            
                            _vh setVariable["RydFFE_GunFree", false];
                            
                            if not((currentMagazine _vh) in [_ammo]) then {
                                _vh loadMagazine[[0], currentWeapon _vh, _ammo];
                                
                                _ct = time;
                                
                                waitUntil {
                                    sleep 0.1;
                                    _ws = weaponState[_vh, [0]];
                                    _ws = _ws select 3;
                                    ((_ws in [_ammo]) or((time - _ct) > 30))
                                };
                                
                                sleep((getNumber(configFile >> "cfgweapons" >> (currentWeapon _vh) >> "magazinereloadtime")) + 0.1)
                            };
                            _range= 0;
                            _min_range = 0;
                            if (typeof _vh in opfor_light_artillery) then {
                                _range = RydFFE_Light_Artillery_Max_Range;
                            };
                            if (typeof _vh in opfor_heavy_artillery) then {
                                _range = RydFFE_Heavy_Artillery_Max_Range;
                            };

                            if (typeof _vh in opfor_light_artillery) then {
                                _min_range = RydFFE_Light_Artillery_Min_Range;
                            };
                            if (typeof _vh in opfor_heavy_artillery) then {
                            _min_range = RydFFE_Heavy_Artillery_Min_Range;
                            };

                            _inRange = _pos inRangeOfArtillery[[_vh], _ammo];
                            _inRange =  _inRange && ((_pos distance _vh) < _range);
                            _inRange =  _inRange && ((_pos distance _vh) > _min_range);

                            if (_inRange) then {
                                if (_ammo in (getArtilleryAmmo[_vh])) then {
                                    if (((toLower(typeOf _vh)) in ["uss_iowa_turret_c", "uss_iowa_turret_b", "uss_iowa_turret_a"]) or {
                                        RydFFE_Iowamode
                                    }) then {
                                        {
                                            _gun = vehicle _x;
                                            if not((toLower(typeOf _gun)) isEqualto "uss_iowa_battleship") then {
                                                _gun doArtilleryfire[_pos, _ammo, (_vh getVariable["RydFFE_Shotstofire", 1])]
                                            }
                                        }
                                        forEach(units(group _vh))
                                    } else {
                                            
                                        _vh doArtilleryfire[_pos, _ammo, (_vh getVariable["RydFFE_Shotstofire", 1])]
                                    };
                                    
                                    _ct = time;
                                    
                                    waitUntil {
                                        sleep 0.1;
                                        (not((_vh getVariable["RydFFE_Shotfired2", 0]) < (_vh getVariable["RydFFE_Shotstofire", 1])) or((time - _ct) > 15))
                                    };
                                    
                                    _vh setVariable["RydFFE_Shotfired", true];
                                    _vh setVariable["RydFFE_Shotfired2", 0];
                                };
                            };
                            
                            sleep((getNumber(configFile >> "cfgweapons" >> (currentWeapon _vh) >> "reloadtime")) + 0.5);
                            
                            _vh setVariable["RydFFE_GunFree", true]
                        }
                    }
                }
            }
        }
    }
}
forEach _guns;

/*{
    if not (isNull _x) then
    {
        {
            (vehicle _x) setVariable ["RydFFE_GunFree", true]
        }
        forEach (units _x)
    }
}
forEach _battery;
*/

_eta