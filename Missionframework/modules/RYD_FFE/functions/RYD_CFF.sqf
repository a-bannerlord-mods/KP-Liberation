//[RydFFE_ArtG,RydFFE_KnEnemies,(RydFFE_EnHArmor + RydFFE_EnMArmor + RydFFE_EnLArmor),RydFFE_Friends,RydFFE_Debug] call RYD_CFF;
private["_artG", "_knEnemies", "_enArmor", "_friends", "_Debug", "_CFFMissions", "_tgt", "_ammo", "_bArr", "_possible", "_amount", "_amnt"];

_artG = _this select 0;
_knEnemies = _this select 1;
_enArmor = _this select 2;
_friends = _this select 3;
_Debug = _this select 4;
_amount = _this select 5;

_CFFMissions = ceil(random(count _artG));

for "_i"
from 1 to _CFFMissions do {
    _tgt = [_knEnemies] call RYD_CFF_TGT;

    if (RydFFE_Debug) then {
				systemChat format ["Artillery Command has %1 Artillery ready for firing and %2 knowen Enemies" ,str count _artG , str count _knEnemies];
	};
    

    if not(isNull _tgt) then {
        _ammo = "HE";
        _amnt = _amount;
        if ((random 100) > 85) then {
            _ammo = "SPECIAL";
            _amnt = (ceil(_amount / 3))
        };
        //if (_tgt in _enArmor) then {_ammo = "HE";_amnt = 6};

        _bArr = [(getPosATL _tgt), _artG, _ammo, _amnt, objNull] call RYD_ArtyMission;
        
        _possible = _bArr select 0;

        if (_possible) then {
            {
                if not(isNull _x) then {
                    _x setVariable["RydFFE_BatteryBusy", true]
                }
            }
            foreach(_bArr select 1);
            if (RydFFE_Debug) then {
				systemChat format ["Artillery requested on %1" ,name _tgt]; 
		    };
            [_bArr select 1, _tgt, _bArr select 2, _bArr select 3, _friends, _Debug, _ammo, _amnt min(_bArr select 4)] spawn RYD_CFF_FFE
        }
        else {
            switch (true) do {
                case (_ammo in ["SPECIAL", "SECONDARY"]):{
                        _ammo = "HE";
                        _amnt = _amount
                    };
                case (_ammo in ["HE"]):{
                        _ammo = "SECONDARY";
                        _amnt = _amount
                    };
            };

            _bArr = [(getPosATL _tgt), _artG, _ammo, _amnt, objNull] call RYD_ArtyMission;

            _possible = _bArr select 0;
            if (_possible) then {
                {
                    if not(isNull _x) then {
                        _x setVariable["RydFFE_BatteryBusy", true]
                    }
                }
                foreach(_bArr select 1);
                if (RydFFE_Debug) then {
				    systemChat format ["Artillery requested on %1" ,name _tgt]; 
		        };
                
                [_bArr select 1, _tgt, _bArr select 2, _bArr select 3, _friends, _Debug, _ammo, _amnt min(_bArr select 4)] spawn RYD_CFF_FFE
            }else{
            }
        }
    };

    sleep(5 + (random 5))
}