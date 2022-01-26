/*
    File: fn_initSectors.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-29
    Last Update: 2020-04-29
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Sorts the placed sector markers to their category array.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/


sectors_airspawn = [];
sectors_allSectors = [];
sectors_bigtown = [];
sectors_capture = [];
sectors_factory = [];
sectors_military = [];
sectors_opfor = [];
sectors_opfor_sniper_nests = [];
sectors_tower = [];
sectors_SAM= [];
sectors_lightArtillery= [];
sectors_heavyArtillery= [];
sectors_longRange = [];
sectors_destroyable = [];

sectors_airports = [];
sectors_heliports = [];

sectors_forced_spawn =[];
sectors_forced_despawn =[];

{
    switch (true) do {
        case (_x find "bigtown" == 0): {sectors_bigtown pushBack _x; sectors_allSectors pushBack _x;};
        case (_x find "capture" == 0): {sectors_capture pushBack _x; sectors_allSectors pushBack _x;};
        case (_x find "factory" == 0): {sectors_factory pushBack _x; sectors_allSectors pushBack _x;};
        case (_x find "military" == 0): {sectors_military pushBack _x; sectors_allSectors pushBack _x;};
        case (_x find "opfor_airspawn" == 0): {sectors_airspawn pushBack _x;};
        case (_x find "opfor_point" == 0): {sectors_opfor pushBack _x;};
        case (_x find "opfor_sniper_nest" == 0): {sectors_opfor_sniper_nests pushBack _x; _x setMarkerAlpha 0;};
        case (_x find "tower" == 0): {sectors_tower pushBack _x; if (isServer) then {_x setMarkerText format ["%1 %2",markerText _x, mapGridPosition (markerPos _x)];}; sectors_allSectors pushBack _x;};
        case (_x find "SAM" == 0): {
                sectors_SAM pushBack _x; 
                sectors_longRange  pushBack _x; 
                sectors_destroyable  pushBack _x;
                sectors_allSectors pushBack _x;
            };
        case (_x find "light_artillery" == 0): {
                sectors_lightArtillery pushBack _x; 
                sectors_longRange  pushBack _x; 
                sectors_destroyable  pushBack _x;
                sectors_allSectors pushBack _x;
            };
        case (_x find "heavy_artillery" == 0): {
                    sectors_heavyArtillery pushBack _x; 
                    sectors_longRange  pushBack _x; 
                    sectors_destroyable  pushBack _x;
                    sectors_allSectors pushBack _x;
            };
    };
} forEach allMapMarkers;

All_airfields = [];
if (count allAirports > 0) then {
                private _first = [getArray (configfile >> "CfgWorlds" >> worldname >> "ilsPosition"),getArray (configfile >> "CfgWorlds" >> worldname >> "ilsDirection")];
                All_airfields pushbackunique _first;
                private _next = [];
                _sec = (configfile >> "CfgWorlds" >> worldname >> "SecondaryAirports");
                for "_i" from 0 to (count _sec - 1) do
                {
                    All_airfields pushbackunique [getarray ((_sec select _i) >> "ilsPosition"),getarray ((_sec select _i) >> "ilsDirection")];
                };
};
All_airfields = All_airfields apply {_x select 0};

_heli_slot_building_list = ["Land_HelipadCircle_F","Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F", "HeliH", "HeliHCivil", "Heli_H_civil", "HeliHEmpty", "HeliHRescue", "Heli_H_rescue"];
{
    _pos = getMarkerPos _x;
    private _heliSlots = ({(typeOf _x) in _heli_slot_building_list;} count (_pos nearobjects 500));
    if (count (All_airfields select { (_x distance2D _pos) < 1200 } )>0) then {
        sectors_airports pushBack _x;
    };
    if (_heliSlots >0) then {
        sectors_heliports pushBack _x;
    };
} forEach sectors_military;


true
