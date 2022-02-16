params ["_searchlight"];

[_searchlight] spawn {
	params ["_searchlight"];
    _dir = getDir _searchlight;
	_gunner = gunner _searchlight;
    // while {alive _searchlight} do {
    //     _scanningright = true;
    //     _scanningleft = false;
		
    //     waitUntil {
	// 		_gunner = gunner _searchlight;
	// 		sleep 1;
	// 		!(isnull _gunner) && !(isPlayer _gunner)
    //     };
		
    //     while {_scanningright and ((getDir _searchlight) < _dir + 45)} do {

    //         _searchlight setDir ceil((getDir _searchlight) + 5);

    //         sleep 1;
    //         // waitUntil {
	// 		// 	_gunner = gunner _searchlight;
	// 		// 	sleep 1;
	// 		// 	!(isnull _gunner) && !(isPlayer _gunner)
    //     	// };
    //         if ((getDir _searchlight) > _dir + 45) then {
    //             _scanningright = false;
    //             _scanningleft = true;
    //         };
    //     };
        
    //     sleep 4;
    //     waitUntil {
	// 		_gunner = gunner _searchlight;
	// 		sleep 1;
	// 		!(isnull _gunner) && !(isPlayer _gunner)
    //     };
    //     while {_scanningleft and ((getDir _searchlight) > _dir - 45)} do {
			
    //         _searchlight setDir ceil((getDir _searchlight) - 5);

    //         sleep 1;
    //         // waitUntil {
	// 		// 	_gunner = gunner _searchlight;
	// 		// 	sleep 1;
	// 		// 	!(isnull _gunner) && !(isPlayer _gunner)
    //     	// };
    //         if ((getDir _searchlight) < _dir - 45) then {
    //             _scanningleft = false;
    //             _scanningright = true
    //         };
    //     };
        
    //     sleep 4;
    // };
};