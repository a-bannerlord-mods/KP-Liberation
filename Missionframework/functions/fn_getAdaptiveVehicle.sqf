/*
    File: fn_getAdaptiveVehicle.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-11-25
    Last Update: 2019-11-26
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Provides a vehicle classname depending on the combat readiness.

    Parameter(s):
        NONE

    Returns:
        Vehicle classname [STRING]
*/
params [
            ["_tanksOnly",false]
        ];
    if (_tanksOnly) then {
        selectRandom ([opfor_vehicles arrayIntersect opfor_tanks , opfor_vehicles_low_intensity arrayIntersect opfor_tanks ] select (combat_readiness < 40))
    } else {
        selectRandom ([opfor_vehicles, opfor_vehicles_low_intensity] select (combat_readiness < 40))
    };

