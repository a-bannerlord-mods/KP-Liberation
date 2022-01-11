private["_arty", "_amount", "_vh", "_handled", "_magtypes", "_mags", "_tp", "_cnt"];

_arty = _this select 0;
_amount = _this select 1;

_amount = ceil _amount;
// if (_amount < 2) exitwith {};

{
    {
        _vh = vehicle _x;
        _handled = _vh getVariable["RydFFEArtyammoHandled", false];
        
        if not(_handled) then {
            _vh setVariable["RydFFEArtyammoHandled", true];
            
            _vh addEventHandler["fired", {
                (_this select 0) setVariable["RydFFE_Shotfired", true];
                (_this select 0) setVariable["RydFFE_Shotfired2", ((_this select 0) getVariable["RydFFE_Shotfired2", 0]) + 1];
                
                if (typeof (_this select 0) in RydFFE_Ace_Mortar) then {
                        //systemChat "Rearming Mortar";
                        (_this select 0) setVehicleAmmo 1;
                    };

                // if ((RydFFE_SVStart) and (RydFFE_Debug)) then
                // {
                    _shells = missionnamespace getVariable["RydFFE_firedShells", []];
                    _shells set [(count _shells), (_this select 6)];
                    missionnamespace setVariable["RydFFE_firedShells", _shells];
                // }
            }];
            
            _magtypes = getArtilleryAmmo[_vh];
            _mags = magazines _vh;
            
            {
                // _tp = _x;
                // _cnt = {
                //     _x in [_tp]
                // }
                // count _mags;
                _vh addmagazines[_x,20];
            }
            forEach _magtypes
        }
    }
    forEach(units _x)
}
forEach _arty;