_condition = {
    params["_target", "_player", "_params"];
    alive _target &&
    locked _target != 2 && locked _target != 3 &&
    count(_target getVariable["ace_rearm_magazinesupply", []]) > 0

};
// _statement = {
//     params ["_target", "_player", "_params"];
//     diag_log format ["_statement [%1, %2, %3]", _target, _player, _params];


// };
_insertChildren = {
    params["_target", "_player", "_params"];

    _list = (ASLtoAGL getPosASL _target nearEntities 50) select {
        alive _x &&
            (_x getVariable["ace_rearm_isSupplyvehicle", false] || [(configFile >> "Cfgvehicles" >> (typeOf _x) >> "ace_rearm_defaultSupply"), "NUMBER", -1] call CBA_fnc_getConfigEntry > 0)
    };

    // Add children to this action
    private _actions = []; {
        if (_x != _target) then {
            private _childStatement = {
                params["_target", "_player", "_params"];
                systemChat str _target;
                systemChat str _params;
            };
            _name = gettext(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayname");
            private _action = [(typeOf _x) + str _forEachindex, _name, "", _childStatement, {
                true
            }, {}, _x] call ace_interact_menu_fnc_createaction;
            _actions pushBack[_action, [], _target];
        };
        // New action, it's children, and the action's target
    }
    forEach _list;

    _actions
};
_modifierFunc = {
    params["_target", "_player", "_params", "_actionData"];


    // modify the action - index 1 is the display name, 2 is the icon...
    // _actionData set [1, format ["Give items: %1", count (items player)]];
};

_action = ["MoveAmmo", "Move Ammo", "", {}, _condition, _insertChildren, [123], "", 4, [false, false, false, true, false], _modifierFunc] call ace_interact_menu_fnc_createaction;
["All", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActiontoClass;
