params [
    ["_player", player, [objNull]]
];

buy_fuel={
	params ["_vehicle","_amount"];
	_cost = _amount/3;
	_nearfob = [] call KPLIB_fnc_getNearestFob;
    _actual_fob = KP_liberation_fob_resources select {((_x select 0) distance _nearfob) < GRLIB_fob_range};
    _fuelRes = (_actual_fob select 0) select 3;
                if (_cost<_fuelRes) then {
                    private _result = [format ["Are you sure you want to spend %1 fuel to add to this vehicle %2 liter of fuel?",str _cost,str _amount], "Confirm", true, true] call BIS_fnc_guiMessage;
                    if (_result) then {
                        _storage_areas = (_nearfob nearObjects (GRLIB_fob_range * 2)) select {
                        (_x getVariable ["KP_liberation_storage_type", -1]) == 0 };                   
                        [0, 0, _cost, "", 0, _storage_areas] remoteExec ["build_remote_call", 2];
                        _amount = _amount + ([_vehicle] call ace_refuel_fnc_getFuel);
                        [_vehicle, _amount] call ace_refuel_fnc_setFuel;
                    };

                } else {
                    [format ["Not Enough Fuel (%1 Fuel needed)",_cost], "Not Enough Ammo", true, false] call BIS_fnc_guiMessage;
                };
};

//buy fuel actions
_player addAction [
    ["<t color='#FFFF00'>", "-- Buy Fuel to Fill Fuel Tank", "</t>"] joinString "",
    {
		_amount = getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') - ([cursorObject] call ace_refuel_fnc_getFuel);
    	[cursorObject,_amount] call buy_fuel;
    },
    nil,
    -850,
    false,
    true,
    "",
    "
        _originalTarget distance cursorObject < 10 &&
        (
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
        )
        && getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') > 0
        && getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') > [cursorObject] call ace_refuel_fnc_getFuel
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget} && {alive cursorObject}
        && {_originalTarget getVariable ['KPLIB_fobDist', 99999] < (GRLIB_fob_range * 0.8)}
    "
];

_player addAction [
    ["<t color='#FFFF00'>", "-- Buy 900 liter Fuel ", "</t>"] joinString "",
    {
		_amount = 900;
    	[cursorObject,_amount] call buy_fuel;
    },
    nil,
    -850,
    false,
    true,
    "",
    "
        _originalTarget distance cursorObject < 10 &&
        ( 
			_originalTarget getVariable ['KPLIB_hasDirectAccess', false] 
			|| {[3] call KPLIB_fnc_hasPermission} 
		)
		&& getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') > 0 
		&& (getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') - ([cursorObject] call ace_refuel_fnc_getFuel)) >= 900 
		&& {isNull (objectParent _originalTarget)} 
		&& {alive _originalTarget}  && {alive cursorObject}
        && {_originalTarget getVariable ['KPLIB_fobDist', 99999] < (GRLIB_fob_range * 0.8)} 
    "
];

_player addAction [
    ["<t color='#FFFF00'>", "-- Buy 3000 liter Fuel ", "</t>"] joinString "",
    {
		_amount = 3000;
    	[cursorObject,_amount] call buy_fuel;
    },
    nil,
    -850,
    false,
    true,
    "",
    "   
        _originalTarget distance cursorObject < 10 &&
        ( 
			_originalTarget getVariable ['KPLIB_hasDirectAccess', false] 
			|| {[3] call KPLIB_fnc_hasPermission} 
		)
		&& getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') > 0 
		&& (getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') - ([cursorObject] call ace_refuel_fnc_getFuel)) >= 3000 
		&& {isNull (objectParent _originalTarget)} 
		&& {alive _originalTarget} && {alive cursorObject}
		&& {_originalTarget getVariable ['KPLIB_fobDist', 99999] < (GRLIB_fob_range * 0.8)} 
    "
];

_player addAction [
    ["<t color='#FFFF00'>", "-- Buy 6000 liter Fuel ", "</t>"] joinString "",
    {
		_amount = 6000;
    	[cursorObject,_amount] call buy_fuel;
    },
    nil,
    -850,
    false,
    true,
    "",
    "   
        _originalTarget distance cursorObject < 10 &&
        ( 
			_originalTarget getVariable ['KPLIB_hasDirectAccess', false] 
			|| {[3] call KPLIB_fnc_hasPermission} 
		)
		&& getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') > 0 
		&& (getNumber (configFile >> 'CfgVehicles' >> typeof cursorObject >> 'ace_refuel_fuelCargo') - ([cursorObject] call ace_refuel_fnc_getFuel)) >= 6000 
		&& {isNull (objectParent _originalTarget)} 
		&& {alive _originalTarget}  && {alive cursorObject}
		&& {_originalTarget getVariable ['KPLIB_fobDist', 99999] < (GRLIB_fob_range * 0.8)} 
    "
];