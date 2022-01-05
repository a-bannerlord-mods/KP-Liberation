if (!(isnil "acex_field_rations_enabled") && acex_field_rations_enabled) then {

    if (KPLIB_acex_field_rations_enable_Effects) then {
        execVM "compatibility\acex_field_rations\field_rations_effects.sqf";
    };


    
    drink_condition = {
        true
    };

    drink_statement = {
        [8, [], {
            ACE_player setVariable["acex_field_rations_thirst", 0];
        }, {}, "Drinking Water"] call ace_common_fnc_progressBar
    };

    _actionDrinkWater = ["DrinkWater", "Drink Water", "", drink_statement, drink_condition] call ace_interact_menu_fnc_createAction;
    ["Fridge_01_closed_F", 0, ["ACE_MainActions"], _actionDrinkWater, true] call ace_interact_menu_fnc_addActionToClass;
    ["Land_WaterCooler_01_new_F", 0, ["ACE_MainActions"], _actionDrinkWater, true] call ace_interact_menu_fnc_addActionToClass;



    eat_condition = {
        true
    };

    eat_statement = {
        
        [5, [], {
            ACE_player setVariable["acex_field_rations_hunger", 0];

        }, {}, "Eating Food"] call ace_common_fnc_progressBar
    };


    _actionEatFood = ["EatFood", "Eat Food", "", eat_statement, eat_condition] call ace_interact_menu_fnc_createAction;

    ["Fridge_01_closed_F", 0, ["ACE_MainActions"], _actionEatFood, true] call ace_interact_menu_fnc_addActionToClass;
    ["Land_FoodContainer_01_White_F", 0, ["ACE_MainActions"], _actionEatFood, true] call ace_interact_menu_fnc_addActionToClass;
};