params[
    ["_player", player, [objNull]]
];
repairable_vehicles = (support_vehicles + light_vehicles + heavy_vehicles + air_vehicles);
repair_vehicle = {
    params["_vehicle"];
    _hipoints = getAllHitPointsDamage _vehicle; 
	_hipointsWithoutWheels1=[]; 
	_hipointsWithoutWheels2 =[]; 
	_hipointsWithoutWheels3 =[]; 
	{ 
		if ((tolower(_x)) find "wheel" == -1 && (tolower _x) find "track" == -1) then { 
			_hipointsWithoutWheels1 pushBack ((_hipoints select 0) select _forEachIndex); 
			_hipointsWithoutWheels2 pushBack ((_hipoints select 1) select _forEachIndex); 
			_hipointsWithoutWheels3 pushBack ((_hipoints select 2) select _forEachIndex); 
		}; 
	} 
	forEach(_hipoints select 0); 
	_hipointsWithoutWheels = [_hipointsWithoutWheels1,_hipointsWithoutWheels2,_hipointsWithoutWheels3];

    if (count((_hipointsWithoutWheels select 2) select {
            _x > 0
        }) > 0) then {

        _avgdmage = ((_hipointsWithoutWheels select 2) select {
            _x > 0
        }) call BIS_fnc_arithmeticMean;
        _damage = (ceil((_avgdmage) * 100) min 20);
        _price = 0;
        _itemIndex = (repairable_vehicles apply {
            tolower(_x select 0)
        }) find tolower(typeOf _vehicle);
        if (_itemIndex == -1) then {
            switch (true) do {
                case (_vehicle isKindOf "Car"):{
                        _price = 300;
                    };
                case (_vehicle isKindOf "Tank"):{
                        _price = 1000;
                    };
                case (_vehicle isKindOf "Helicopter"):{
                        _price = 1200;
                    };
                case (_vehicle isKindOf "Plane"):{
                        _price = 2200;
                    };
                case (_vehicle isKindOf "Boat"):{
                        _price = 300;
                    };
                default {
                    _price = 200;
                };
            };
        } else {
            _price = (repairable_vehicles select _itemIndex) select 1;
        };

        _cost = _price * (_damage / 100);
        _nearfob = [] call KPLIB_fnc_getNearestFob;
        _actual_fob = KP_liberation_fob_resources select {
            ((_x select 0) distance _nearfob) < GRLIB_fob_range
        };
        _suppliesRes = (_actual_fob select 0) select 1;
        if (_cost < _suppliesRes) then {
            private _result = [format["Are you sure you want to spend %1 supplies to fully repair this vehicle?", str _cost], "Confirm", true, true] call BIS_fnc_guiMessage;
            if (_result) then {
                _storage_areas = (_nearfob nearObjects(GRLIB_fob_range * 2)) select {
                    (_x getVariable["KP_liberation_storage_type", -1]) == 0
                };
                [_cost, 0, 0, "", 0, _storage_areas] remoteExec["build_remote_call", 2];

                {
                    if ((tolower _x) find "wheel" == -1 && (tolower _x) find "track" == -1) then {
                        _vehicle setHitIndex[_forEachIndex, 0];
                    };
                }
                forEach((getAllHitPointsDamage _vehicle) select 0);
            };

        } else {
            [format["Not Enough supplies (%1 supplies needed)", _cost], "Not Enough supplies", true, false] call BIS_fnc_guiMessage;
        };
    } else {
        ["No Repairs Needed For Vehicle", "No Repairs Needed", true, false] call BIS_fnc_guiMessage;
    };
};

//Repair actions
_player addAction[
    ["<t color='#FFFF00'>", "-- Full Repair Vehicle", "</t>"] joinString "", {
        [cursorObject] call repair_vehicle;
    },
    nil, -850,
    false,
    true,
    "",
    "
    _originalTarget distance cursorObject < 10 && {
        alive _originalTarget
    } && {
        alive cursorObject
    } &&
    (
        _originalTarget getVariable['KPLIB_hasDirectAccess', false] || {
            [3] call KPLIB_fnc_hasPermission
        }
    ) &&
    tolower (typeof cursorObject) in KPLIB_b_allVeh_classes && {
        isNull(objectParent _originalTarget)
    } && {
        _originalTarget getVariable['KPLIB_fobDist', 99999] < (GRLIB_fob_range * 0.8)
    }
    "
];