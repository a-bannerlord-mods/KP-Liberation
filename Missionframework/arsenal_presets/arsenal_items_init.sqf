GRLIB_arsenal_all_weapons = GRLIB_arsenal_weapons_primary + GRLIB_arsenal_weapons_secondary +
GRLIB_arsenal_weapons_handgun;

{
    _wmags = [(_x select 0)] call jn_fnc_arsenal_getCompatiblemagazines;
    {
        if !(_x in (GRLIB_arsenal_magazines apply {
            _x select 0
        })) then {
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
    GRLIB_arsenal_uniforms pushBack [_x, "civilians items", [], 2, 5];
} forEach KPLIB_civ_uniform;
{
    GRLIB_arsenal_headgear pushBack [_x, "civilians items", [], 2, 5];
} forEach KPLIB_civ_headwear;
{
    GRLIB_arsenal_backpacks pushBack [_x, "civilians items", [], 5, 5];
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