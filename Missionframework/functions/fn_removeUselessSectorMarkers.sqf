/*
File: fn_removeUselessSectorMarkers.sqf
Author: KP Liberation Dev Team - https:// github.com/KillahPotatoes
date: 2019-12-03
Last Update: 2020-04-22
License: MIT License - http:// www.opensource.org/licenses/MIT

Description:
remove Artillery and SAM sectors if there is no classes in presence

parameter(s):
nothing

Returns:
nothing
*/

if ((count (opfor_heavy_artillery select {
    isClass (configFile >> "Cfgvehicles">>_x);
})) <= 0 ) then {
	
    sectors_longRange =  sectors_longRange - sectors_heavyArtillery; 
    sectors_allSectors  = sectors_allSectors - sectors_heavyArtillery; 
	{
		deleteMarker _x;
	} forEach sectors_heavyArtillery;
	sectors_heavyArtillery =[] ; 
};

if ((count (opfor_light_artillery select {
    isClass (configFile >> "Cfgvehicles">>_x);
})) <= 0 ) then {
	sectors_longRange =  sectors_longRange - sectors_lightArtillery; 
    sectors_allSectors  = sectors_allSectors - sectors_lightArtillery; 
	{
		deleteMarker _x;
	} forEach sectors_lightArtillery;
	sectors_lightArtillery =[] ; 
};


if ((count (opfor_SAM select {
    isClass (configFile >> "Cfgvehicles">>(_x select 0) ) &&  isClass (configFile >> "Cfgvehicles">>(_x select 1))
})) <= 0 ) then {
	sectors_longRange =  sectors_longRange - sectors_SAM; 
    sectors_allSectors  = sectors_allSectors - sectors_SAM; 
	{
		deleteMarker _x;
	} forEach sectors_SAM;
	sectors_SAM =[] ; 
};