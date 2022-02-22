params ["_searchlight"];

[_searchlight] spawn {
	params ["_searchlight"];
    waitUntil {!isNil "IsNightTime"};
    _dir = getDir _searchlight;
	_gunner = gunner _searchlight;
    while {alive _searchlight} do {
        if (IsNightTime) then {
            waitUntil {
                _gunner = gunner _searchlight;
                sleep 1;
                !(isnull _gunner) && !(isPlayer _gunner)
            };
            _dir = getDir _searchlight;
            {
                _searchpos = _searchlight getpos [50,ceil((getDir _searchlight) + _x)];
                _gunner doWatch _searchpos;
                sleep 1;
                waitUntil {
                    _gunner = gunner _searchlight;
                    sleep 1;
                    !(isnull _gunner) && !(isPlayer _gunner)
                };
                // _target = assignedTarget _gunner;
                // if !(isNull _target) then {
                //     _gunner doWatch objNull; 
                //     waitUntil {             
                //         sleep 1;				
                //         _target = assignedTarget _gunner;				
                //         (isnull _target)
                //     };
                // };
            } forEach [5,10,15,20,25,30,35,40,45,40,35,30,25,20,15,10,5,0,-5,-10,-15,-20,-25,-30,-35,-40,-45,-40,-35,-30,-25,-20,-15,-10,-5,0];
        }else{
            _gunner action ["lightOff", _searchlight];
            _gunner moveOut _searchlight;
            _gunner disableAI "PATH";
            _gunner disableAI "MOVE";
            waitUntil {IsNightTime};
            _gunner moveInAny _searchlight;
            _gunner enableAI "PATH";
            _gunner enableAI "MOVE";
            _gunner action ["lightOn", _searchlight];
        };
        
    };
};