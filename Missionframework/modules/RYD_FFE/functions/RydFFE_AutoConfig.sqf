private["_allArty", "_vh", "_typeVh", "_mags", "_prim", "_rare", "_sec", "_smoke", "_illum", "_maxHit", "_ammo", "_ammoC", "_actHit", "_subM", "_mags0", "_illumChosen", "_smokechosen", "_rarechosen", "_secChosen",
"_hit", "_lc", "_sim", "_subM", "_arr"];

_allArty = _this select 0;

{
    _vh = _x;
    
    if not(_vh getVariable["RydFFE_Checkedout", false]) then {
        _vh setVariable["RydFFE_Checkedout", true];
        _typeVh = toLower(typeOf _vh);
        
        if not(_typeVh in _allArty) then {
            _mags = getArtilleryAmmo[_vh];
            
            if ((count _mags) > 0) then {
                _prim = "";
                _rare = "";
                _sec = "";
                _smoke = "";
                _illum = "";
                
                _maxHit = 10;
                
                {
                    _ammo = gettext(configFile >> "Cfgmagazines" >> _x >> "ammo");
                    _ammoC = configFile >> "Cfgammo" >> _ammo;
                    
                    _actHit = getNumber(_ammoC >> "indirectHitRange");
                    _subM = toLower(gettext(_ammoC >> "submunitionammo"));
                    
                    if (_actHit <= 10) then {
                        if not(_subM isEqualto "") then {
                            _ammoC = configFile >> "Cfgammo" >> _subM;
                            _actHit = getNumber(_ammoC >> "indirectHitRange")
                        }
                    };
                    
                    if ((_actHit > _maxHit) and {
                        _actHit < 100
                    }) then {
                        _maxHit = _actHit;
                        _prim = _x
                    }
                }
                forEach _mags;
                
                _mags = _mags - [_prim];
                _mags0 = +_mags;
                _illumChosen = false;
                _smokechosen = false;
                _rarechosen = false;
                _secChosen = false;
                
                {
                    _ammo = gettext(configFile >> "Cfgmagazines" >> _x >> "ammo");
                    _ammoC = configFile >> "Cfgammo" >> _ammo;
                    
                    _hit = getNumber(_ammoC >> "indirectHit");
                    _lc = _ammoC >> "lightColor";
                    _sim = toLower(gettext(_ammoC >> "simulation"));
                    _subM = toLower(gettext(_ammoC >> "submunitionammo"));
                    
                    if (_hit <= 10) then {
                        if not(_subM isEqualto "") then {
                            _ammoC = configFile >> "Cfgammo" >> _subM;
                            _hit = getNumber(_ammoC >> "indirectHit")
                        }
                    };
                    
                    switch (true) do {
                        case ((isArray _lc) and {
                            not(_illumChosen)
                        }):{
                            _illum = _x;
                            _mags = _mags - [_x];
                            _illumChosen = true
                        };
                        
                        case ((_hit <= 10) and {
                            (_subM isEqualto "smokeshellarty") and {
                                not(_smokechosen)
                            }
                        }):{
                            _smoke = _x;
                            _mags = _mags - [_x];
                            _smokechosen = true
                        };
                        
                        case ((_sim isEqualto "shotsubmunitions") and {
                            not(_rarechosen)
                        }):{
                            _rare = _x;
                            _mags = _mags - [_x];
                            _rarechosen = true
                        };
                        
                        case ((_hit > 10) and {
                            not((_secChosen) or {
                                (_rare == _x)
                            })
                        }):{
                            _sec = _x;
                            _mags = _mags - [_x];
                            _secChosen = true
                        }
                    }
                }
                forEach _mags0;
                
                if (_sec isEqualto "") then {
                    _maxHit = 10;
                    
                    {
                        _ammo = gettext(configFile >> "Cfgmagazines" >> _x >> "ammo");
                        _ammoC = configFile >> "Cfgammo" >> _ammo;
                        _subammo = _ammoC >> "subMunitionammo";
                        
                        if ((istext _subammo) and {
                            not((gettext _subammo) isEqualto "")
                        }) then {
                            _ammoC = configFile >> "Cfgammo" >> (gettext _subammo);
                        };
                        
                        _actHit = getNumber(_ammoC >> "indirectHit");
                        
                        if (_actHit > _maxHit) then {
                            _maxHit = _actHit;
                            _sec = _x
                        }
                    }
                    forEach _mags;
                };
                
                _arr = [_prim, _rare, _sec, _smoke, _illum];
                
                if (({
                    _x isEqualto ""
                }
                count _arr) < 5) then {
                    RydFFE_Other pushBack[[_typeVh], _arr];
                    _allArty pushBack _typeVh
                }
            }
        }
    }
}
forEach vehicles;

RydFFE_AllArty = _allArty;

_allArty