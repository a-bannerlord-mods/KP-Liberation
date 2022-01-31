
waitUntil {!isNil "save_is_loaded"};
waitUntil {save_is_loaded};

params ["_device"];

if(isnil "c130_flying_cargo" )then{
    c130_flying_cargo = objNull;
};
if(isnil "c130_flying_plane" )then{
    c130_flying_plane = objNull;
};
if (isnil "Plane_Drop_Height") then {
    Plane_Drop_Height = 4000;
};

_device addAction ["<img size='1' image='ca\air2\data\ui\icon_c130j_ca.paa'/><t color='#00ffa6'>Select Drop Zone</t>", {
    openMap true;
    hint 'Click on desired location.';
    onMapsingleClick {
        onMapsingleClick {};
        createMarkerLocal ["dz", _Pos];
        "dz" setMarkerTypeLocal "Mil_Start";
        hint 'Flight Plan set';
        openMap false;
        true;
    };
    },
    nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"
    isNull c130_flying_plane
    && player getUnitTrait 'officer'
    ", 	// condition
	50,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

_device addAction ["<img size='1' image='ca\air2\data\ui\icon_c130j_ca.paa'/><t color='#00ffa6'>Select Drop Height</t>", {
        [
            [
                [2000,10000],
                Plane_Drop_Height,
                [1,1]
            ],
            "Set Drop Height",
            {format["%1 Meter",(round _position)]},
            {
                if _confirmed then {
                    Plane_Drop_Height = (round _position);
                };
            },
            "Set Height",
            "Abort"
        ] call CAU_UserInputMenus_fnc_slider;
    },
    nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"
    isNull c130_flying_plane
    && !(getMarkerPos 'dz' isEqualTo [0,0,0])
    && player getUnitTrait 'officer'
    ", 	// condition
	50,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

Take_off = {
    params ["_planeDropHeight"];
    plane_status = "White";
    publicVariable "plane_status";
    _plane_name = gettext(configFile >> "Cfgvehicles" >> KPLIB_C130_halo_airplane_class >> "displayname");
    _dz = createvehicle ["O_diver_TL_F", getmarkerPos "dz", [], 0, "NONE"];
    _dz hideObjectglobal true;
    _dz disableAI "move";
    _dz disableAI "TARGET";
    _dz disableAI "AUTOTARGET";
    _dz disableAI "WEAPONAIM";
    _dz disableAI "ANIM";
    _plane = createvehicle [KPLIB_C130_halo_airplane_class, getmarkerPos "dz", [], 0, "NONE"];
    _plane allowdamage false;
    [_plane, ["hide_cargo",1,true]] remoteExec ["animate", 0];

    clearWeaponCargoGlobal _plane;
    clearMagazineCargoGlobal _plane;
    clearBackpackCargoGlobal _plane;
    clearItemCargoGlobal _plane;

    _plane enableSimulationGlobal false;
    _plane hideObjectglobal true;
    _plane attachto [_dz, [0, 0, _planeDropHeight] ];
    _plane engineOn true;
    _plane flyinHeight _planeDropHeight;

    c130_flying_plane = _plane;
    publicVariable "c130_flying_plane";
    _dz setvehicleVarName "dz";
    dz = _dz;
    publicVariable "dz";
    
    _whitelight = createvehicle ["land_Camping_Light_F", getmarkerPos "dz", [], 0, "NONE"];
    _redlight = createvehicle ["land_TentLamp_01_suspended_red_F", getmarkerPos "dz", [], 0, "NONE"];
    _greenlight = createvehicle ["Reflector_Cone_01_wide_green_F", getmarkerPos "dz", [], 0, "NONE"];
    _redlight attachto [_plane, [0, 10, 100] ];
    _greenlight attachto [_plane, [0, 10, 100] ];
    _whitelight attachto [_plane, [0, 10, 4] ];
    
    hint (_plane_name + "in the air, Please board it");
	//_plane  animate ["hide_cargo", 1];
    
    _plane hideObjectglobal false;
    
    _counter = 60;
    while {_counter>0} do {
        _counter =_counter-2;
        sleep 2;
        //_plane animate ["ramp_bottom", 0];
        //_plane animate ["ramp_top", 0];
    };
    
    
    _whitelight attachto [_plane, [0, 8, 100] ];
    _redlight attachto [_plane, [0, 3, 0] ];
    // [_plane, 'ramp_bottom',1] remoteExec ['animate', 0];
    // [_plane, 'ramp_top',1] remoteExec ['animate', 0];
    //_plane animate ["ramp_bottom", 1];
    //_plane animate ["ramp_top", 1];
    _plane enableSimulationGlobal true;
    [_plane, ["ramp_bottom",1]] remoteExec ["animate", 0];
    [_plane, ["ramp_top",1]] remoteExec ["animate", 0];

	plane_status = "Red";
    publicVariable "plane_status";
    
    sleep 10;

    
    _whitelight attachto [_plane, [0, 8, 100] ];
    _redlight attachto [_plane, [0, -6, 100] ];
    _greenlight attachto [_plane, [0, -15, 4] ];

	plane_status = "Green";
    publicVariable "plane_status";

    sleep 5;
    {
        if !(isplayer _x) then {
            _x action ["Eject", _plane];
        };
    } forEach units group player;
    
    {
        if !(isplayer _x) then {
            {
                waitUntil {
                    (getPosATL _x select 2) < 120
                };
                _x action ["openParachute", _x];
            } forEach units group player;
        };
    };

    sleep 80;

    deletevehicle _plane;
    deletevehicle _dz;
    deletevehicle _whitelight;
    deletevehicle _redlight;
    deletevehicle _greenlight;
    deleteMarker "dz";
    c130_flying_plane = objNull;
	publicVariable "c130_flying_plane";
};

_device addAction [format ["<img size='1' image='ca\air2\data\ui\icon_c130j_ca.paa'/><t color='#04ff00'>Give Order To %1 Take off</t>", gettext(configFile >> "Cfgvehicles" >> KPLIB_C130_halo_airplane_class >> "displayname")], {
    params ["_target", "_caller", "_actionId", "_arguments"];
    
    _plane_name = gettext(configFile >> "Cfgvehicles" >> KPLIB_C130_halo_airplane_class >> "displayname");
    _first_Avl_plane_after = 9999999999;
    _plane =objNull;
    
    {
        _last_halo_jump =_x getVariable ["last_halo_jump", -6000];
        if (( _last_halo_jump + ( KPLIB_C130_halo_param * 60)) >= servertime) then {
            _av_after= ceil ((( _last_halo_jump + ( KPLIB_C130_halo_param * 60)) - servertime ));
            if (_first_Avl_plane_after > _av_after) then {
                _first_Avl_plane_after = _av_after;
            };
        } else {
            _plane = _x;
        };
    } forEach ((getPosATL _target) nearEntities [KPLIB_C130_halo_airplane_class, 400]);
    
    if (_first_Avl_plane_after == 9999999999 && isNull _plane) exitwith {
        hint format ["No %1 available at all", _plane_name];
    };
    if (isNull _plane) exitwith {
        hint format ["No %1 available at this moment, First %1 will available after %2 minutes", _plane_name, ceil(_first_Avl_plane_after/60)];
    };
    
    _plane setVariable	["last_halo_jump", servertime, true];

    "dz" setmarkeralpha 1;  
    
    [Plane_Drop_Height] remoteExec ["Take_off", 2];
    addVehcileactionId = [] call addVehcileaction;
    },
    nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"
    !(getMarkerPos 'dz' isEqualTo [0,0,0])
    && isNull c130_flying_plane
    && player getUnitTrait 'officer'
    ", 	// condition
	50,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

_device addAction [format ["<img size='1' image='ca\air2\data\ui\icon_c130j_ca.paa'/><t color='#0040ff'>Board %1</t>", gettext(configFile >> "Cfgvehicles" >> KPLIB_C130_halo_airplane_class >> "displayname") ], {
    cuttext ["", "BLACK OUT", 3];
    player removeAction  addVehcileactionId;
    sleep 4;
    player attachto [c130_flying_plane, [0, 4, -4.5] ];
    player setDir 180;
    c130_flying_plane enableSimulation true;
    detach player;
    {
        if !(isplayer _x) then {
            _x moveInCargo c130_flying_plane;
        };
    } forEach units group player;
    cuttext ["", "BLACK in", 1];

    if (isNil "plane_status" || plane_status=="White") then {
        hint 'Standby for Red Light';
        waitUntil {plane_status=="Red" || isnull c130_flying_plane};
    };

    hint 'Standby for Green Light';
    waitUntil {plane_status=="Green" || isnull c130_flying_plane};
    // if !(isnull c130_flying_plane) then {
    //     c130_flying_plane animate ["ramp_bottom", 1];
    //     c130_flying_plane animate ["ramp_top", 1];
    // };

    hint 'Green Light';
    
	
    waitUntil {
        istouchingGround player or (getPosASL player select 2) <2
    };
    {
        if !(isplayer _x) then {
            waitUntil {
                istouchingGround _x
            };
            _x allowdamage true;
            _inv = name _x;
        }
    }forEach units group player;
    
    },
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"
    !(isNull c130_flying_plane)
    ", 	// condition
	50,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

addVehcileaction = {
    player addAction [format ["<img size='1' image='ca\air2\data\ui\icon_c130j_ca.paa'/><t color='#0040ff' >Add to Halo</t>",gettext(configFile >> "Cfgvehicles" >> typeof _c130_flying_cargo >> "displayname")], {
		params ["_target", "_caller", "_actionId", "_arguments"];
        _c130_flying_cargo =cursorObject;
        _caller removeAction _actionId;
        _units = units _c130_flying_cargo;
        {
            _x action ["eject", _c130_flying_cargo];
        } forEach _units;
        _c130_flying_cargo lock true;
        sleep 3;
		_name= gettext(configFile >> "Cfgvehicles" >> typeof _c130_flying_cargo >> "displayname");
        _c130_flying_cargo hideObjectglobal true;
        _c130_flying_cargo allowdamage false;
        _c130_flying_cargo attachto [c130_flying_plane, [0, -1.5, -3] ];
        _c130_flying_cargo setDir 180;
        _c130_flying_cargo setvehicleVarName "c130_flying_cargo";
        c130_flying_cargo = _c130_flying_cargo;
        publicVariable "c130_flying_cargo";
        
        _c130_flying_cargo hideObjectglobal false;
		
        
        
        c130_flying_plane addAction [format ["<img size='1' image='ca\air2\data\ui\icon_c130j_ca.paa'/><t color='#0040ff'>Drop %1</t>",_name], {
            [] call eject_v;
        },
	    nil,		// arguments
	    1.5,		// priority
	    true,		// showWindow
	    true,		// hideOnUse
	    "",			// shortcut
	    "
        !isNil 'plane_status'&& plane_status == 'Green'
        ", 	// condition
	    50,			// radius
	    false,		// unconscious
	    "",			// selection
	    ""			// memoryPoint
	    ];
        waitUntil {isnull c130_flying_plane}; 
        if !(isnull c130_flying_cargo) then {
            [] call eject_v;
        };
    },
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"
    (typeOf cursorObject) in (C130_halo_allowed_vehicles apply { _x select 0})
    && isNull c130_flying_cargo
    ", 	// condition
	50,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
	];
};
eject_v = {
    _c130_flying_cargo = c130_flying_cargo; 
            c130_flying_cargo = objNull;
	        publicVariable "c130_flying_cargo";
            {
                _c130_flying_cargo attachto [c130_flying_plane, [0, _x, -3] ];
                sleep 0.05;
            } forEach [-1.5,-2,-2.5,-3,-3.5,-4,-4.5,-5,-5.5,-6,-6.5,-7,-7.5,-8,-8.5,-9,-9.5];
            detach _c130_flying_cargo;
            _c130_flying_cargo setvelocity [0, -7, 0];
            
            sleep 5;
            waitUntil {
                (getPosATL _c130_flying_cargo select 2) < 200
            };
            
            para = createvehicle [KPLIB_C130_halo_parachute_class, [0, 0, 100], [], 0, ""];
            para setPos (getPos _c130_flying_cargo);
            _c130_flying_cargo attachto [para, [0, 0, 0]];
            
            waitUntil {
                ((((position _c130_flying_cargo) select 2) < 0.6) || (isnil "para"))
            };
            _c130_flying_cargo lock false;
			detach _c130_flying_cargo;
            _c130_flying_cargo setvelocity [0, 0, -5];
            sleep 0.3;
            _c130_flying_cargo setPos [(position _c130_flying_cargo) select 0, (position _c130_flying_cargo) select 1, 1];
            _c130_flying_cargo setvelocity [0, 0, 0];

			sleep 5;
			_c130_flying_cargo allowdamage true;

            _irstrobe = "NVG_TargetC" createvehicle position _c130_flying_cargo;
            _irstrobe attachto [_c130_flying_cargo, [0, 0, 1] ];
            
            _smoke = "SmokeShellBlue" createvehicle position _c130_flying_cargo;
            _smoke attachto [_c130_flying_cargo, [0, 0, -0.5]];
			sleep 60;
            
            _smoke = "SmokeShellBlue" createvehicle position _c130_flying_cargo;
            _smoke attachto [_c130_flying_cargo, [0, 0, -0.5]];
            
			sleep 60;
            
            _smoke = "SmokeShellBlue" createvehicle position _c130_flying_cargo;
            _smoke attachto [_c130_flying_cargo, [0, 0, -0.5]];
            deletevehicle _irstrobe;
}