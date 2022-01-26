if (isClass(configFile >> "CfgPatches" >> "SSS")) exitwith {
    if !(isnil "blufor_transport_support_vehicles") then {
        _this addAction [
            ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa'/><t color='#FFFF00'>", " Add to Transport Support Group", "</t>"] joinstring "",
            {
            
                _cost = blufor_transport_support_vehicles select ((blufor_transport_support_vehicles apply {_x select 0}) find (typeOf cursorObject)) select 1;
                _nearfob = [] call KPLIB_fnc_getNearestFob;
                _actual_fob = KP_liberation_fob_resources select {((_x select 0) distance _nearfob) < GRLIB_fob_range};
                _supplies = (_actual_fob select 0) select 1;
                if (_cost<_supplies) then {
                    private _result = [format ["Are you sure you want to spend %1 supplies to add crew to this vehicle?",str _cost], "Confirm", true, true] call BIS_fnc_guiMessage; 
                    if (_result) then {
                        _storage_areas = (_nearfob nearObjects (GRLIB_fob_range * 2)) select {
                        (_x getVariable ["KP_liberation_storage_type", -1]) == 0 };                   
                        [_cost, 0, 0, "", 0, _storage_areas] remoteExec ["build_remote_call", 2];

                        [cursorObject,"transport"] remoteExec ["add_to_support_group",2];
                        // _addonGrpName = createVehicleCrew _target;
                        // _grpName = createGroup GRLIB_side_friendly;
                        // {[_x] joinSilent _grpName;} forEach units _addonGrpName;

                        // [_target,"",-1,{},blufor_cas_support_required_items,{player getUnitTrait 'JTAC'}]  call sss_support_fnc_addtransport;
                    };

                } else {
                    Hint (format ["Not Enough Supplies (%1 supplies needed)",_cost]);
                };
                
            },
            nil,
            -850,
            false,
            true,
            "",
            "
            (typeOf cursorObject) in (blufor_transport_support_vehicles apply {_x select 0}) 
			&& cursorObject distance player < 12 
			&& isnull (cursorObject getVariable['SSS_parentEntity', objNull])
            && {
                _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
                || {[3] call KPLIB_fnc_hasPermission}
            }
            && {build_confirmed isEqualTo 0}
            && [_originalTarget,1.3] call  KPLIB_fnc_isPlayerNearToFob
            "
        ];
    };
    if !(isnil "blufor_cas_support_vehicles") then {
        _this addAction [
            ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa'/><t color='#FFFF00'>", " Add to CAS Support Group", "</t>"] joinstring "",
            {
                _cost = blufor_cas_support_vehicles select ((blufor_cas_support_vehicles apply {_x select 0}) find (typeOf cursorObject)) select 1;
                _nearfob = [] call KPLIB_fnc_getNearestFob;
                _actual_fob = KP_liberation_fob_resources select {((_x select 0) distance _nearfob) < GRLIB_fob_range};
                _supplies = (_actual_fob select 0) select 1;
                if (_cost<_supplies) then {
                    private _result = [format ["Are you sure you want to spend %1 supplies to add crew to this vehicle?",str _cost], "Confirm", true, true] call BIS_fnc_guiMessage;
                    if (_result) then {
                        _storage_areas = (_nearfob nearObjects (GRLIB_fob_range * 2)) select {
                        (_x getVariable ["KP_liberation_storage_type", -1]) == 0 };                   
                        [_cost, 0, 0, "", 0, _storage_areas] remoteExec ["build_remote_call", 2];

                        [cursorObject,"cas"] remoteExec ["add_to_support_group",2];
                        // _addonGrpName = createVehicleCrew _target;
                        // _grpName = createGroup GRLIB_side_friendly;
                        // {[_x] joinSilent _grpName;} forEach units _addonGrpName;

                        // [_target,"",-1,{},blufor_cas_support_required_items,{player getUnitTrait 'JTAC'}] call sss_support_fnc_addcashelicopter;
                    };

                } else {
                    Hint (format ["Not Enough Supplies (%1 supplies needed)",_cost]);
                };
                
            },
            nil,
            -850,
            false,
            true,
            "",
            "
            (typeOf cursorObject) in (blufor_cas_support_vehicles apply {_x select 0})
            && cursorObject distance player < 12
            && isnull (cursorObject getVariable['SSS_parentEntity', objNull])
            && {
                _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
                || {[3] call KPLIB_fnc_hasPermission}
            }
            && {build_confirmed isEqualTo 0}
            && [_originalTarget,1.3] call  KPLIB_fnc_isPlayerNearToFob
            "
        ];
    };
    if !(isnil "blufor_jet_support_vehicles") then {
        _this addAction [
            ["<img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa'/><t color='#FFFF00'>", " Add to Support Group", "</t>"] joinstring "",
            {
                _cost = blufor_jet_support_vehicles select ((blufor_jet_support_vehicles apply {_x select 0}) find (typeOf cursorObject)) select 1;
                _nearfob = [] call KPLIB_fnc_getNearestFob;
                _actual_fob = KP_liberation_fob_resources select {((_x select 0) distance _nearfob) < GRLIB_fob_range};
                _supplies = (_actual_fob select 0) select 1;
                if (_cost<_supplies) then {
                    private _result = [format ["Are you sure you want to spend %1 supplies to add crew to this vehicle?",str _cost], "Confirm", true, true] call BIS_fnc_guiMessage;
                    if (_result) then {
                        _storage_areas = (_nearfob nearObjects (GRLIB_fob_range * 2)) select {
                        (_x getVariable ["KP_liberation_storage_type", -1]) == 0 };                   
                        [_cost, 0, 0, "", 0, _storage_areas] remoteExec ["build_remote_call", 2];

                        [cursorObject,"plane"] remoteExec ["add_to_support_group",2];
                        // _addonGrpName = createVehicleCrew _target;
                        // _grpName = createGroup GRLIB_side_friendly;
                        // {[_x] joinSilent _grpName;} forEach units _addonGrpName;

                        // [_target,"",-1,{},blufor_cas_support_required_items,{player getUnitTrait 'JTAC'}] call sss_support_fnc_addcashelicopter;
                    };

                } else {
                    Hint (format ["Not Enough Supplies (%1 supplies needed)",_cost]);
                };
                
            },
            nil,
            -850,
            false,
            true,
            "",
            "
            (typeOf cursorObject) in (blufor_jet_support_vehicles apply {_x select 0})
            && cursorObject distance player < 12
            && isnull (cursorObject getVariable['SSS_parentEntity', objNull])
            && {
            _originalTarget getVariable ['KPLIB_hasDirectAccess', false]
            || {[3] call KPLIB_fnc_hasPermission}
            }
            && {build_confirmed isEqualTo 0}
            && [_originalTarget,1.3] call  KPLIB_fnc_isPlayerNearToFob
            "
        ];
    };

};