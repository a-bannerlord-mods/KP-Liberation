if (hasinterface) then {

    
    getRearmCargo  = {
        params ["_vehicle"];
        _cargo = getNumber (configFile >> "CfgVehicles" >>  typeof _vehicle >> "ace_rearm_defaultSupply");
        if (typeof _vehicle == "MCC_crateAmmoBigWest" ) then {
            _cargo = 6000;
        };
        _cargo
    };


    _condition = {
        params["_target", "_player", "_params"];

        (alive _target && locked _target != 2 && locked _target != 3 &&
            _target getVariable["ace_rearm_currentsupply", 0] > 0) ||
        _target isKindOf "MCC_crateAmmoBigWest"


    };

    _insertChildren = {
        params["_target", "_player", "_params"];

        _list = (ASLtoAGL getPosASL _target nearObjects 50) select {

            (alive _x && [(configFile >> "CfgVehicles" >>  typeof _x >> "ace_rearm_defaultSupply"), "NUMBER", -1] call CBA_fnc_getConfigEntry > 0) ||
            _x isKindOf "MCC_crateFuelBigWest"
        };

        // Add children to this action
        private _actions = []; {
            if (_x != _target) then {
                private _childStatement = {
                    params["_target", "_player", "_params"];
                    [_params, _target] call move_fuel;

                };
                _name = gettext(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayname");
                _icon = [(typeOf _x)] call ace_common_fnc_getVehicleIcon;
                private _action = [(typeOf _x) + str _forEachindex, _name, _icon, _childStatement, {
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

    _action = ["MoveAmmo", "Move Ammo", "\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa", {}, _condition, _insertChildren, [123], "", 8, [false, false, false, true, false], _modifierFunc] call ace_interact_menu_fnc_createaction;
    ["All", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActiontoClass;


    move_fuel = {
        params["_target", "_source"];
        [_target, _source] spawn {
            params["_target", "_source"];
            _move_fuel_target = _target;
            _move_fuel_source = _source;

            _move_fuel_source_amount =  (_move_fuel_source getVariable ['ace_rearm_currentsupply', 0]);
            _move_fuel_target_amount =  (_move_fuel_target getVariable ['ace_rearm_currentsupply', 0]);

            _move_fuel_source_storage = [_move_fuel_source]  call getRearmCargo;
            _move_fuel_target_storage = [_move_fuel_target]  call getRearmCargo;

            _amount_to_move = (_move_fuel_target_storage - _move_fuel_target_amount) min _move_fuel_source_amount;
            if (_amount_to_move == 0) then {

            } else {
                private _result = [format["Are you sure you want to move %1 point of ammo?", str _amount_to_move], "Confirm", true, true] call BIS_fnc_guiMessage;
                if (_result) then {
                    _source_amount = (_move_fuel_source getVariable ['ace_rearm_currentsupply', 0]) - _amount_to_move;
                    _move_fuel_source setVariable ['ace_rearm_currentsupply', _source_amount,true];
                    
                    _target_amount = (_move_fuel_target getVariable ['ace_rearm_currentsupply', 0]) + _amount_to_move;
                    _move_fuel_target setVariable ['ace_rearm_currentsupply', _target_amount,true];
                };
            };
        };
    };
};