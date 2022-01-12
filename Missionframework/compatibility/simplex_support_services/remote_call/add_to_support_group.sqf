params ["_target", "_type"];

switch (_type) do {
    case "transport": {
        // _addonGrpname = createvehiclecrew _target;
        // _grpname = creategroup GRLIB_side_friendly;
        // {
        //     [_x] joinSilent _grpname;
        // } forEach units _addonGrpname;
        [_target] call KPLIB_fnc_forceBluforCrew;
        _customname = _target getVariable ["ace_cargo_customname",""];
        [_target, _customname, -1, {}, blufor_cas_support_required_items, {
            player getUnitTrait 'JTAC'
        }] call sss_support_fnc_addtransport;
    };
    case "cas": {
        //_addonGrpname = createvehiclecrew _target;
        // _grpname = creategroup GRLIB_side_friendly;
        // {
        //     [_x] joinSilent _grpname;
        // } forEach units _addonGrpname;

        [_target] call KPLIB_fnc_forceBluforCrew;
        [_target, "", -1, {}, blufor_cas_support_required_items, {
            player getUnitTrait 'JTAC'
        }] call sss_support_fnc_addcashelicopter;
    };
    case "plane": {
        _targettype = typeOf _target;
        _weaponset = (getPylonMagazines cursorObject) apply {getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") };
        _weaponset = _weaponset select {_x != ""};
        _weaponset= _weaponset arrayIntersect _weaponset;
        _customname = _target getVariable ["ace_cargo_customname",""];
        deletevehicle _target;
        GRLIB_virual_support pushback ["plane",_targettype,_weaponset];
        [_targettype, _customname, _weaponset, 600, {}, GRLIB_side_friendly, blufor_cas_support_required_items, {
            player getUnitTrait 'JTAC'
        }] call sss_support_fnc_addcasplane;
    };
    default {};
};