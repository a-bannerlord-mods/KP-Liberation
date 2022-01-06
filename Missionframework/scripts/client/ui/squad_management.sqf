private["_dialog", "_membercount", "_memberselection", "_unitname", "_selectedmember", "_cfgVehicles", "_cfgWeapons", "_primary_mags", "_secondary_mags", "_vehstring", "_nearfob", "_fobdistance", "_nearsquad", "_tempgmp", "_destpos", "_destdir", "_resupplied", "_firstloop", "_squad_camera", "_targetobject", "_isvehicle"];

GRLIB_squadaction = -1;
GRLIB_squadconfirm = -1;
GRLIB_switchActions = [];
_membercount = -1;
_resupplied = false;
_memberselection = -1;
_selectedmember = objNull;
_dialog = createDialog "liberation_squad";
_cfgVehicles = configFile >> "cfgVehicles";
_cfgWeapons = configFile >> "cfgWeapons";
_firstloop = true;
_isvehicle = false;

waitUntil {
    dialog
};


_targetobject = "Sign_Sphere100cm_F"
createVehicleLocal[0, 0, 0];
hideObject _targetobject;

_squad_camera = "camera"
camCreate(getpos player);
_squad_camera cameraEffect["internal", "back", "rtt"];
_squad_camera camSetTarget _targetobject;
_squad_camera camcommit 0;
"rtt"
setPiPEffect[0];

while {
    dialog && alive player
}
do {

    if ({
            alive _x
        }
        count(units group player) != _membercount) then {

        _membercount = {
            alive _x
        }
        count(units group player);

        lbClear 101; {
            if (alive _x) then {
                _unitname = format["%1. ", [_x] call KPLIB_fnc_getUnitPositionId];
                _unitOriginalName = _x getVariable["originalUnitName", ""];
                if (_unitOriginalName == "") then {
                    if (isPlayer _x) then {
                        if (count(squadParams _x) != 0) then {
                            _unitname = "[" + ((squadParams _x select 0) select 0) + "] ";
                        };
                    };
                    _unitname = _unitname + (name _x);
                } else {
                    _unitname = _unitname + _unitOriginalName;
                };

                lbAdd[101, _unitname];
            };
        }
        foreach(units group player);

        if (_firstloop) then {
            lbSetCurSel[101, 0];
            _firstloop = false;
        };
    };

    _selectedmember = objNull;
    if (lbCurSel 101 != -1 && (count(units group player) > lbCurSel 101)) then {
        _selectedmember = (units group player) select(lbCurSel 101);
    };

    if (!(isNull _selectedmember)) then {
        "spawn_marker"
        setMarkerPosLocal(getpos _selectedmember);
        ctrlMapAnimClear((findDisplay 5155) displayCtrl 100);
        ((findDisplay 5155) displayCtrl 100) ctrlMapAnimAdd[0, 0.3, getpos _selectedmember];
        ctrlMapAnimCommit((findDisplay 5155) displayCtrl 100);
    };

    if (!(isNull _selectedmember)) then {
        if (_memberselection != lbCurSel 101 || _resupplied || ((vehicle _selectedmember == _selectedmember && _isvehicle) || (vehicle _selectedmember != _selectedmember && !_isvehicle))) then {
            _memberselection = lbCurSel 101;
            _resupplied = false;
            _hasItem = [_selectedmember, "ItemcTabHCam"] call BIS_fnc_hasItem;
            _hasItem = _hasItem || (tolower(headgear _selectedmember) == "rhsusf_opscore_ut_pelt_nsw_cam");
            if (_hasItem) then {
                if (vehicle _selectedmember == _selectedmember) then {
                    _targetobject attachTo[_selectedmember, [0, 10, 0.05], "neck"];
                    _squad_camera attachTo[_selectedmember, [0, 0.25, 0.05], "neck"];
                    _isvehicle = false;
                } else {
                    _targetobject attachTo[vehicle _selectedmember, [0, 20, 2]];
                    _squad_camera attachTo[vehicle _selectedmember, [0, 0, 2]];
                    _isvehicle = true;
                };
                _squad_camera cameraEffect["internal", "back", "rtt"];
            } else {
                _squad_camera cameraEffect["terminate", "back"];
            };
            _squad_camera camcommit 0;

            _unitname = format["%1. ", [_selectedmember] call KPLIB_fnc_getUnitPositionId];
            if (isPlayer _selectedmember) then {
                if (count(squadParams _selectedmember) != 0) then {
                    _unitname = "[" + ((squadParams _selectedmember select 0) select 0) + "] ";
                };
            };
            _unitname = _unitname + (name _selectedmember);
            ctrlSetText[201, _unitname];

            ctrlSetText[202, getText(_cfgVehicles >> (typeof _selectedmember) >> "displayName")];
            ctrlSetText[203, format["%1 %2%3", localize 'STR_HEALTH', round(100 - ((damage _selectedmember) * 100)), '%']];

            ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor[1, 1, 1, 1];
            if (damage _selectedmember > 0.4) then {
                ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor[1, 1, 0, 1];
            };
            if (damage _selectedmember > 0.6) then {
                ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor[1, 0.5, 0, 1];
            };
            if (damage _selectedmember > 0.8) then {
                ((findDisplay 5155) displayCtrl 203) ctrlSetTextColor[1, 0, 0, 1];
            };

            if (isplayer _selectedmember) then {
                ctrlSetText[204, format["%1 %2 Supplies", "Loadout Cost", str([_selectedmember] call jn_fnc_arsenal_calculateLoadoutCost)]];
            } else {
                ctrlSetText[204, format["%1 %2m", localize 'STR_DISTANCE', round(player distance _selectedmember)]];
            };


            if (primaryWeapon _selectedmember != "") then {
                ctrlSetText[205, format["%1: %2", localize 'STR_PRIMARY_WEAPON', getText(_cfgWeapons >> (primaryWeapon _selectedmember) >> "displayName")]];

                _primary_mags = 0;
                if (count primaryWeaponMagazine _selectedmember > 0) then {
                    _primary_mags = 1; {
                        if ((_x select 0) == ((primaryWeaponMagazine _selectedmember) select 0)) then {
                            _primary_mags = _primary_mags + 1;
                        }
                    }
                    foreach(magazinesAmmo _selectedmember);
                };

                ctrlSetText[206, format["%1: %2", localize 'STR_AMMO', _primary_mags]];
            } else {
                ctrlSetText[205, format["%1: %2", localize 'STR_PRIMARY_WEAPON', localize 'STR_NONE']];
                ctrlSetText[206, format["%1: %2", localize 'STR_AMMO', 0]];
            };

            if (secondaryWeapon _selectedmember != "") then {
                ctrlSetText[207, format["%1: %2", localize 'STR_SECONDARY_WEAPON', getText(_cfgWeapons >> (secondaryWeapon _selectedmember) >> "displayName")]];

                _secondary_mags = 0;
                if (count secondaryWeaponMagazine _selectedmember > 0) then {
                    _secondary_mags = 1; {
                        if ((_x select 0) == ((secondaryWeaponMagazine _selectedmember) select 0)) then {
                            _secondary_mags = _secondary_mags + 1;
                        }
                    }
                    foreach(magazinesAmmo _selectedmember);
                };

                ctrlSetText[208, format["%1: %2", localize 'STR_AMMO', _secondary_mags]];
            } else {
                ctrlSetText[207, format["%1: %2", localize 'STR_SECONDARY_WEAPON', localize 'STR_NONE']];
                ctrlSetText[208, format["%1: %2", localize 'STR_AMMO', 0]];
            };

            if (vehicle _selectedmember == _selectedmember) then {
                ctrlSetText[209, ""];
            } else {
                _vehstring = localize 'STR_PASSENGER';
                if (driver vehicle _selectedmember == _selectedmember) then {
                    _vehstring = localize 'STR_DRIVER';
                };
                if (gunner vehicle _selectedmember == _selectedmember) then {
                    _vehstring = localize 'STR_GUNNER';
                };
                if (commander vehicle _selectedmember == _selectedmember) then {
                    _vehstring = localize 'STR_COMMANDER';
                };
                _vehstring = _vehstring + format[" (%1)", getText(_cfgVehicles >> (typeof vehicle _selectedmember) >> "displayName")];
                ctrlSetText[209, _vehstring];
            };
        };
    } else {
        {
            ctrlSetText[_x, ""]
        }
        foreach[201, 202, 203, 204, 205, 206, 207, 208, 209];
        GRLIB_squadconfirm = -1;
        GRLIB_squadaction = -1;
    };

    if (GRLIB_squadaction == -1) then {
        ctrlEnable[213, false];
        ctrlEnable[214, false];
        if (!(isPlayer _selectedmember) && (vehicle _selectedmember == _selectedmember)) then {
            ctrlEnable[210, true];
            if (leader group player == player) then {
                ctrlEnable[211, true];
            };
            ctrlEnable[212, true];
            ctrlSetText[212, localize "$STR_DEPLOY_ON_MEMBER"];
            ctrlSetText[211, localize "$STR_REMOVE_MEMBER"];
            ctrlSetText[210, localize "$STR_RESUPPLY"];

        } else {
            ctrlSetText[210, "Unstuck"];
            ctrlEnable[210, true];
            ctrlSetText[211, "Punish"];
            ctrlEnable[211, true];
            ctrlSetText[212, "Request Help"];
            ctrlEnable[212, true];
        };
    } else {

        ctrlEnable[210, false];
        ctrlEnable[211, false];
        ctrlEnable[212, false];
        ctrlEnable[213, true];
        ctrlEnable[214, true];
    };

    if (GRLIB_squadconfirm == 0) then {
        GRLIB_squadconfirm = -1;
        GRLIB_squadaction = -1;
    };

    if (GRLIB_squadconfirm == 1) then {
        GRLIB_squadconfirm = -1;
        if !(isPlayer _selectedmember) then {
            if (GRLIB_squadaction == 1) then {

                _nearfob = [getpos _selectedmember] call KPLIB_fnc_getNearestFob;
                _fobdistance = 9999;
                if (count _nearfob == 3) then {
                    _fobdistance = _selectedmember distance _nearfob;
                };

                _nearsquad = (getPos _selectedmember) nearEntities[KPLIB_aiResupplySources, 30];

                if (_fobdistance < 100 || count _nearsquad > 0) then {

                    _tempgmp = createGroup[GRLIB_side_friendly, true];
                    (typeof _selectedmember) createUnit[markers_reset, _tempgmp, ''];
                    [(units _tempgmp) select 0, _selectedmember] call KPLIB_fnc_swapInventory;
                    deleteVehicle((units _tempgmp) select 0);
                    _selectedmember setDamage 0;

                    hint localize 'STR_RESUPPLY_OK';
                    _resupplied = true;
                } else {
                    hint localize 'STR_RESUPPLY_KO';
                };
            };

            if (GRLIB_squadaction == 2) then {
                deleteVehicle _selectedmember;
                _resupplied = true;
                hint localize 'STR_REMOVE_OK';
            };

            if (GRLIB_squadaction == 3) then {

                closeDialog 0;

                {
                    (_x select 1) removeAction(_x select 0);
                }
                forEach GRLIB_switchActions;
                GRLIB_switchActions = [];

                _originalPlayerUnit = player getVariable['originalPlayerUnit', objNull];
                if (isNull _originalPlayerUnit) then {
                    _selectedmember setVariable["originalPlayerUnit", player, true];
                    _selectedmember setVariable["originalUnitName", name _selectedmember];
                    GRLIB_switchActions pushback[(_selectedmember addAction[
                        ["<t color='#FFFF00'>", "-- Switchback", "</t>"] joinString "", {
                            params["_target", "_caller", "_actionId", "_arguments"]; {
                                (_x select 1) removeAction(_x select 0);
                            }
                            forEach GRLIB_switchActions;
                            GRLIB_switchActions = [];
                            _player = (_caller getVariable['originalPlayerUnit', objNull]);
                            if !(isNull _player) then {
                                _caller setVariable["originalPlayerUnit", objNull, true];
                                [_player, _caller] call ace_switchunits_fnc_switchBack;
                                _caller setVariable["ace_switchunits_isplayercontrolled", false, true];
                            };
                        },
                        nil, -850,
                        false,
                        true,
                        "player == (_originalTarget getVariable ['originalPlayerUnit',objNull])",
                        "
                        true "
                    ]), _selectedmember];

                    GRLIB_switchActions pushback[(_selectedmember addAction[
                        ["<t color='#FFFF00'>", "-- Task Guard", "</t>"] joinString "", {
                            params["_target", "_caller", "_actionId", "_arguments"]; {
                                (_x select 1) removeAction(_x select 0);
                            }
                            forEach GRLIB_switchActions;
                            GRLIB_switchActions = [];
                            _player = (_caller getVariable['originalPlayerUnit', objNull]);
                            if !(isNull _player) then {
                                _caller setVariable["originalPlayerUnit", objNull, true];
                                _caller setVariable["ace_switchunits_isplayercontrolled", false, true];
                                [_player, _caller] call ace_switchunits_fnc_switchBack;
                                _caller setUnitPos "UP";
                                _caller disableAI "PATH";
                                [_caller] joinSilent grpNull;
                                _caller setVariable["task", "guard", true];
                            };
                        },
                        nil, -850,
                        false,
                        true,
                        "player == (_originalTarget getVariable ['originalPlayerUnit',objNull])",
                        "
                        true "
                    ]), _selectedmember];

                    [_selectedmember] call ace_switchunits_fnc_switchUnit;

                } else {
                    {
                        (_x select 1) removeAction(_x select 0);
                    }
                    forEach GRLIB_switchActions;
                    GRLIB_switchActions = [];
                    player setVariable["originalPlayerUnit", objNull, true];
                    player setVariable["ace_switchunits_isplayercontrolled", false, true];
                    [_originalPlayerUnit, player] call ace_switchunits_fnc_switchBack;
                };


            };

        } else {
            switch (GRLIB_squadaction) do {
                case 1:{
                        //Unstuck
                        _position = (getPosATL _selectedmember);
                        _goodPosition = _position findEmptyPosition[2, 10, typeOf _selectedmember];
                        _selectedmember setPosATL _goodPosition;
                    };
                case 2:{
                        //Punish
                        [_selectedmember, true, player] call ACE_captives_fnc_setHandcuffed;
                    };
                case 3:{
                        //Request Help
                        if (!isnil "commandant") then {
                            format["%1 Requesting help for %2.", name player, name _selectedmember] remoteExec["hint", commandant];
                        };
                    };
                default {};
            };
        };
        GRLIB_squadaction = -1;
    };

    sleep 0.1;
};

"spawn_marker"
setMarkerPosLocal markers_reset;
_squad_camera cameraEffect["terminate", "back"];
camDestroy _squad_camera;
deleteVehicle _targetobject;