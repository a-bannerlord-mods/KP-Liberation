
switch (KP_liberation_arsenal) do {
    case  1: {[] call compile preprocessFileLineNumbers "arsenal_presets\custom.sqf";};
    case  2: {[] call compile preprocessFileLineNumbers "arsenal_presets\rhsusaf.sqf";};
    case  3: {[] call compile preprocessFileLineNumbers "arsenal_presets\3cbBAF.sqf";};
    case  4: {[] call compile preprocessFileLineNumbers "arsenal_presets\gm_west.sqf";};
    case  5: {[] call compile preprocessFileLineNumbers "arsenal_presets\gm_east.sqf";};
    case  6: {[] call compile preprocessFileLineNumbers "arsenal_presets\csat.sqf";};
    case  7: {[] call compile preprocessFileLineNumbers "arsenal_presets\unsung.sqf";};
    case  8: {[] call compile preprocessFileLineNumbers "arsenal_presets\sfp.sqf";};
    case  9: {[] call compile preprocessFileLineNumbers "arsenal_presets\bwmod.sqf";};
    case  10: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_nato_mtp.sqf";};
    case  11: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_nato_tropic.sqf";};
    case  12: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_nato_wdl.sqf";};
    case  13: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_csat_hex.sqf";};
    case  14: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_csat_ghex.sqf";};
    case  15: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_aaf.sqf";};
    case  16: {[] call compile preprocessFileLineNumbers "arsenal_presets\vanilla_ldf.sqf";};
    case  17: {[] call compile preprocessFileLineNumbers "arsenal_presets\eaf.sqf";};
    default  {GRLIB_arsenal_weapons = [];GRLIB_arsenal_magazines = [];GRLIB_arsenal_items = [];GRLIB_arsenal_backpacks = [];};
};

_weapon_varinant = []; 
{ 
	_weapon = _x select 0; 
	_weapon_data = _x ; 
	{ 
		_indx= (_x apply { toLower (_x select 0) }) find  (toLower _weapon); 
		if (_indx!=-1) then { 
			{ 
				if (toLower (_x select 0) != (toLower _weapon)) then { 
					_weapon_varinant pushBack [_x select 0  
						,_weapon_data select 1 
						,_weapon_data select 2 
						,_weapon_data select 3 
						,0 
						,_weapon_data select 5 
						,_weapon_data select 6 
					]; 
				}; 
			} forEach _x; 
		}; 
	} forEach GRLIB_arsenal_weapons_colors_variant; 
} forEach GRLIB_arsenal_weapons_primary; 

GRLIB_weapons_colors = createHashMap;
{
    _group = _x;
    {   
        _class = _x select 0;
        GRLIB_weapons_colors set [_class ,_group select {_x select 0 != _class} ]
    } forEach _x;
} forEach GRLIB_arsenal_weapons_colors_variant;

GRLIB_arsenal_weapons_primary  = GRLIB_arsenal_weapons_primary + _weapon_varinant;


GRLIB_arsenal_all_weapons = GRLIB_arsenal_weapons_primary + GRLIB_arsenal_weapons_secondary +
GRLIB_arsenal_weapons_handgun;

{
    _wmags = [(_x select 0)] call jn_fnc_arsenal_getCompatiblemagazines;
    {
        if !((tolower _x) in (GRLIB_arsenal_magazines apply {tolower (_x select 0) })) then {
            _cost = [_x] call KPLIB_fnc_calculateMagValue;
            _cfgMagazine = configFile >> "Cfgmagazines" >> _x;
            _magazinecount = getNumber (_cfgMagazine >> "count");
            _count=0;
            _roles = ["Rifleman"];
            switch (true) do {
                case (_magazinecount <2 && _magazinecount >0): {
                    _roles = ["Rifleman"];
                };
                case (_magazinecount <21 && _magazinecount >2) : {
                    _roles = ["Marksman","Sniper"];
                };
                case (_magazinecount <31 && _magazinecount >21) : {
                    _roles = ["Rifleman"];
                };
                case (_magazinecount <51 && _magazinecount >31) : {
                    _roles = ["Autorifleman"];
                };
                case (_magazinecount >51) : {
                    _roles = ["Autorifleman"];
                };
                default {
                    _count = 0;
                };
            };
            GRLIB_arsenal_magazines pushBack [_x, "magazines",_roles , _cost, _count];
        };
    } forEach _wmags;
} forEach (GRLIB_arsenal_all_weapons select {
    (_x select 5)
});

{
    GRLIB_arsenal_uniforms pushBack [_x, "civiliansItems", [], 2, 5];
} forEach KPLIB_civ_uniform;
{
    GRLIB_arsenal_headgear pushBack [_x, "civiliansItems", [], 2, 5];
} forEach KPLIB_civ_headwear;
{
    GRLIB_arsenal_backpacks pushBack [_x, "civiliansItems", [], 5, 5];
} forEach KPLIB_civ_backbag;

GRLIB_arsenal_all_dub= GRLIB_arsenal_weapons_primary + GRLIB_arsenal_weapons_secondary +
GRLIB_arsenal_weapons_handgun + GRLIB_arsenal_magazines + GRLIB_arsenal_uniforms + GRLIB_arsenal_headgear + GRLIB_arsenal_vests + GRLIB_arsenal_facegear +
GRLIB_arsenal_nightvision + GRLIB_arsenal_rangefinders + GRLIB_arsenal_maps + GRLIB_arsenal_compass + GRLIB_arsenal_watchs + GRLIB_arsenal_terminal + GRLIB_arsenal_radio +
GRLIB_arsenal_optics + GRLIB_arsenal_backpacks + GRLIB_arsenal_flashlaser + GRLIB_arsenal_bipods + GRLIB_arsenal_muzzles + GRLIB_arsenal_HandGrenade + GRLIB_arsenal_explosives +
GRLIB_arsenal_other;

GRLIB_arsenal_all = [];
{
    if ((_x select 0) call HALs_fnc_getConfigClass != configNull) then {
        if !((_x select 0) in (GRLIB_arsenal_all apply {
            _x select 0
        })) then {
            GRLIB_arsenal_all pushBack _x;
        }
    };
} forEach GRLIB_arsenal_all_dub;

GRLIB_arsenal_items = createHashMap;

{
    GRLIB_arsenal_items set [ tolower (_x select 0), [_x select 3, _x select 2 ]];
} forEach GRLIB_arsenal_all;

GRLIB_arsenal_initiated = true;