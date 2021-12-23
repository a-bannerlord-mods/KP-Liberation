/*
File: fn_combatReadinessUpdated.sqf
Author: KP Liberation Dev Team - https:// github.com/KillahPotatoes
date: 2019-12-03
Last Update: 2020-04-22
License: MIT License - http:// www.opensource.org/licenses/MIT

Description:
occur when combat readiness changed

parameter(s):
nothing

Returns:
nothing
*/

if !(isServer) exitwith {};

if (combat_readiness > KP_Radars_Enable_On_Combat_Readiness_Above) then {
    {
        {
            _x setvehicleRadar 1;
        } forEach (entities [[_x], [], false, true]);
    } forEach (opfor_SAM apply {
        _x select 0
    });
} else {
    {
        {
            _x setvehicleRadar 0;
        } forEach (entities [[_x], [], false, true]);
    } forEach (opfor_SAM apply {
        _x select 0
    });
};