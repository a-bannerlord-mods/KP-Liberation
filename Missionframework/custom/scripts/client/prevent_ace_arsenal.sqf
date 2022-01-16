
ace_arsenal_displayOpened = {
    if (getPlayerUID player in KP_liberation_commander_actions) then {
        
    } else {
        (_this select 0) closeDisplay 1;
    };
};
["ace_arsenal_displayOpened", ace_arsenal_displayOpened] call CBA_fnc_addEventHandler; 