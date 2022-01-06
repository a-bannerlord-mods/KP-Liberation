params [
    ["_player", player, [objNull]]
];

buy_ammo={
	params ["_vehicle","_amount"];
	_cost = _amount*1.5;
	_nearfob = [] call KPLIB_fnc_getNearestFob;
    _actual_fob = KP_liberation_fob_resources select {((_x select 0) distance _nearfob) < GRLIB_fob_range};
    _ammoRes = (_actual_fob select 0) select 2;
                if (_cost<_ammoRes) then {
                    private _result = [format ["Are you sure you want to spend %1 ammo to add to this vehicle %2 ammo points?",str _cost,str _amount], "Confirm", true, true] call BIS_fnc_guiMessage;
                    if (_result) then {
                        _storage_areas = (_nearfob nearObjects (GRLIB_fob_range * 2)) select {
                        (_x getVariable ["KP_liberation_storage_type", -1]) == 0 };                   
                        [0, _cost, 0, "", 0, _storage_areas] remoteExec ["build_remote_call", 2];
                        _amount = _amount + (_vehicle getVariable ['ace_rearm_currentsupply', 0]);
                        _vehicle setVariable ['ace_rearm_currentsupply', _amount,true];
                    };

                } else {
                    [format ["Not Enough Ammo (%1 Ammo needed)",_cost], "Not Enough Ammo", true, false] call BIS_fnc_guiMessage;
                };
};

//buy ammo actions
_player addAction [
    ["<t color='#FFFF00'>", "-- Buy Ammo to Fill vehicle", "</t>"] joinString "",
    {
		_amount = 1200 - (cursorObject getVariable ["ace_rearm_currentsupply", 0]);
    	[cursorObject,_amount] call buy_ammo;
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
        && (cursorObject getVariable ['ace_rearm_currentsupply', -1]) > -1
        && 1200 > (cursorObject getVariable ['ace_rearm_currentsupply', 0])
        && {isNull (objectParent _originalTarget)}
        && {alive _originalTarget}  && {alive cursorObject}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<t color='#FFFF00'>", "-- Buy 600 Ammo ", "</t>"] joinString "",
    {
		_amount = 600;
    	[cursorObject,_amount] call buy_ammo;
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
		&& (cursorObject getVariable ['ace_rearm_currentsupply', -1]) > -1 
		&& 1200 - (cursorObject getVariable ['ace_rearm_currentsupply', 0]) >= 600 
		&& {isNull (objectParent _originalTarget)} 
		&& {alive _originalTarget}   && {alive cursorObject}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
    "
];


_player addAction [
    ["<t color='#FFFF00'>", "-- Buy 300 Ammo ", "</t>"] joinString "",
    {
		_amount = 300;
    	[cursorObject,_amount] call buy_ammo;
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
		&& (cursorObject getVariable ['ace_rearm_currentsupply', -1]) > -1
		&& 1200 - (cursorObject getVariable ['ace_rearm_currentsupply', 0]) >= 300 
		&& {isNull (objectParent _originalTarget)} 
		&& {alive _originalTarget}  && {alive cursorObject}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
    "
];



_player addAction [
    ["<t color='#FFFF00'>", "-- Buy 100 Ammo ", "</t>"] joinString "",
    {
		_amount = 100;
    	[cursorObject,_amount] call buy_ammo;
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
		&& (cursorObject getVariable ['ace_rearm_currentsupply', -1]) > -1
		&& 1200 - (cursorObject getVariable ['ace_rearm_currentsupply', 0]) >= 100 
		&& {isNull (objectParent _originalTarget)} 
		&& {alive _originalTarget}  && {alive cursorObject}
        && [_originalTarget,0.8] call  KPLIB_fnc_isPlayerNearToFob
    "
];
