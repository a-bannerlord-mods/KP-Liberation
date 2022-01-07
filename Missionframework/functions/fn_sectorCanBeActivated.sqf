/*
File: fn_sectorCanBeActivated.sqf
Author: KP Liberation Dev Team - https:// github.com/KillahPotatoes
date: 2019-11-25
Last Update: 2020-04-09
License: MIT License - http:// www.opensource.org/licenses/MIT

Description:
Checks if local player has the given qualification granted.

parameter(s):
_qualification - qualification to check [NUMBER, defaults to -1]

Returns:
Has qualification granted [BOOL]
*/
// [_sector,_range] call KPLIB_fnc_sectorCanBeActivated

params ["_sector","_range"];

(!(_sector in blufor_sectors)) 
&&
    (_sector in sectors_forced_spawn ||
    	(!(_sector in sectors_forced_despawn) 
		&& ([markerPos _sector, _range, GRLIB_side_friendly,_sector] call KPLIB_fnc_getUnitsCount) > 0))