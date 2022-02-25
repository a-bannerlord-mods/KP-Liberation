/*
	Author: Genesis

	Description:
		Function for AI calling in artillery support.

	Parameter(s):
		0: GROUP - Group calling for support
		1: GROUP - Enemy group to be targetted

	Returns:
		NOTHING
		
		
		
		
		
west reportRemoteTarget [TARGET, 3600];
TARGET confirmSensorTarget [west, true];
VLS fireAtTarget [TARGET, "weapon_vls_01"];		
		
*/

params["_callGrp", "_enemyGrp", "_AvgKnw", "_PredictedLoc"];

[_callGrp, _enemyGrp, _AvgKnw, _PredictedLoc] spawn {
    params["_callGrp", "_enemyGrp", "_AvgKnw", "_PredictedLoc"];
    private _CallSide = (side _callGrp);

    private _LazClass = "LaserTargetE";
    switch (_CallSide) do {
        case (west):{
                _LazClass = "LaserTargetE";
            };
        case (east):{
                _LazClass = "LaserTargetW";
            };
        case (resistance):{
                _LazClass = "LaserTargetE";
            };
    };




    //First let's go ahead and make sure we clear any dead artillery units.
    private _RemoveList = [];

    {
        private _veh = _x;
        private _class = typeOf _veh;
        if !(isNil("_class")) then {
            private _artyChk = getNumber(configfile / "CfgVehicles" / _class / "artilleryScanner");
            if (!(_artyChk isEqualTo 1) || !(alive _x)) then {
                _RemoveList pushBack _x;
            };
        };
    }
    foreach VCM_ARTYLST;

    {
        private _Num = _x;
        private _Index = VCM_ARTYLST findIf {
            _x isEqualTo _Num
        };
        VCM_ARTYLST deleteAt _Index;
    }
    foreach _RemoveList;

    //Let's find an artillery group that can provide support.
    private _artyArray = [];
    {
        if ([(side _x), _CallSide] call BIS_fnc_sideIsFriendly && {
                side _x in VCM_ARTYSIDES
            }) then {
            if ((typeof(_x)) in opfor_artillery) then {
                _artyArray pushback _x;
            };

        };
    }
    foreach VCM_ARTYLST;




    //There are no artillery units available!
    if (_artyArray isEqualTo[]) exitWith {
        ["no artillery unit available to support"] spawn KPLIB_fnc_zuesLog;
    };

    //Now with our completed array, lets find positions that can support.
    private _clstGrp = [_artyArray, (leader _callGrp), true, "Arty1"] call VCM_fnc_ClstObj;
    if (isNil "_clstGrp") exitWith {
        ["no close artillery group available to support"] spawn KPLIB_fnc_zuesLog;
    };

    private _EnemyGrpLeader = leader _enemyGrp;
    private _AllEmyUnits = (_EnemyGrpLeader nearEntities[["Man", "LandVehicle"], 100]) select {
        alive _x && !(_x getVariable["ACE_isUnconscious", false]) && (side _x == side _EnemyGrpLeader)
    };

    if (count _AllEmyUnits < 1) exitWith {
        ["no living enemy to fire on"] spawn KPLIB_fnc_zuesLog;
    };

    private _RndSelEnmy = selectRandom _AllEmyUnits;
    private _callLeader = leader _callGrp;
    Attr_Caller = _callLeader;
    private _artLeader = leader _clstGrp;
    private _callDistance = _artLeader distance _callLeader;
    private _callerJTACsCount = count(((getpos _callLeader) nearEntities[["Man"], 250]) select {
        _backpack = backpack _x;
        _t = getNumber(configFile >> "cfgVehicles" >> _backpack >> "tf_hasLRradio");
        alive _x && !(_x getVariable["ACE_isUnconscious", false]) && _t == 1 && (side _x == side _callLeader)
    });
    _callerJTACsCount = _callerJTACsCount + count(((getpos _RndSelEnmy) nearEntities[["Man"], 1000]) select {
        _backpack = backpack _x;
        _t = getNumber(configFile >> "cfgVehicles" >> _backpack >> "tf_hasLRradio");
        alive _x && !(_x getVariable["ACE_isUnconscious", false]) && _t == 1 && (side _x == side _callGrp)
    });

    private _callerRadioTowersCount = count((_callLeader nearEntities[KPLIB_radioTowerClassnames, 200]) select {
        alive _x
    });

    if (_callerRadioTowersCount == 0 && _callerJTACsCount == 0 && _callDistance > 850) exitWith {
        ["Unable to call arty because so far to send short range radio and there is no JTAC around (nearst Atr is %1m away)", _callDistance] spawn KPLIB_fnc_zuesLog;
    };

    //Now we need to see how much we know about the enemy.

    //Find any friendlies within 50 meters.


    //Now that we passed basic checks, let's collect more information to do the damage.
    private _VCnt = [];
    private _MinRDist = 0;
    private _MaxRDist = 0;

    private _RndNumber = 0;


    switch (true) do {
        case (_AvgKnw >= 0 && {
            _AvgKnw < 10
        }):{
                _MinRDist = 120;
                _MaxRDist = 100;
                _RndNumber = 4;
            };
        case (_AvgKnw >= 10 && {
            _AvgKnw < 20
        }):{
                _MinRDist = 110;
                _MaxRDist = 80;
                _RndNumber = 4;
            };
        case (_AvgKnw >= 20 && {
            _AvgKnw < 30
        }):{
                _MinRDist = 100;
                _MaxRDist = 60;
                _RndNumber = 4;
            };
        case (_AvgKnw >= 30 && {
            _AvgKnw < 40
        }):{
                _MinRDist = 90;
                _MaxRDist = 60;
                _RndNumber = 4;
            };
        case (_AvgKnw >= 40 && {
            _AvgKnw < 50
        }):{
                _MinRDist = 80;
                _MaxRDist = 60;
                _RndNumber = 6;
            };
        case (_AvgKnw >= 50 && {
            _AvgKnw < 60
        }):{
                _MinRDist = 70;
                _MaxRDist = 50;
                _RndNumber = 6;
            };
        case (_AvgKnw >= 60 && {
            _AvgKnw < 70
        }):{
                _MinRDist = 60;
                _MaxRDist = 50;
                _RndNumber = 6;
            };
        case (_AvgKnw >= 70 && {
            _AvgKnw < 80
        }):{
                _MinRDist = 50;
                _MaxRDist = 50;
                _RndNumber = 6;
            };
        case (_AvgKnw >= 80 && {
            _AvgKnw < 90
        }):{
                _MinRDist = 40;
                _MaxRDist = 40;
                _RndNumber = 8;
            };
        case (_AvgKnw >= 90 && {
            _AvgKnw <= 100
        }):{
                _MinRDist = 30;
                _MaxRDist = 40;
                _RndNumber = 8;
            };
        case (_AvgKnw > 100):{
                _MinRDist = 20;
                _MaxRDist = 40;
                _RndNumber = 8;
            };
    };

    if (VCM_Debug) then {
        systemChat(format["_AvgKnw: %1  _RndNumber: %2", _AvgKnw, _RndNumber])
    };

    {
        if (_x isKindOf "LandVehicle") then {
            _Vcnt pushBack _x;
        };
    }
    foreach _AllEmyUnits;

    //Now let's fire
    private _RndSelEnmy = selectRandom _AllEmyUnits;
    private _PredictedLoc2 = ((leader _callGrp) targetKnowledge(vehicle _RndSelEnmy)) #6;



    //Define what rounds we are using at the enemies.

    //["HE","Guided","Laser Guided","Cluster Shells","Mine Cluster","White Smoke","AT Mine Cluster"]

    //_Finallist pushbackunique (getText(configfile/"CfgMagazines"/_x/"displayNameShort"));	

    private _FinalArtyArray =[];
    private _FinalAmmoType = [];
    private _SmokeArray = [];
    if (VCM_Debug) then {
        systemChat(format["count _VCnt: %1", (count _VCnt)])
    };
    // if (count _VCnt > 0) then {
    //     {
    //         private _Unit = _x;
    //         private _ammoArray = getArtilleryAmmo[vehicle _Unit];
    //         if !(isNil "_ammoArray") then {
    //             {
    //                 private _Type = getText(configfile / "CfgMagazines" / _x / "displayNameShort");
    //                 if (["AT", _Type] call BIS_fnc_inString || ["Guided", _Type] call BIS_fnc_inString || _Type == "3VO18") then {
    //                     _FinalArtyArray pushBackUnique _Unit;
    //                     _FinalAmmoType pushBackUnique _x;
    //                 };
    //                 if (["Smoke", _Type] call BIS_fnc_inString) then {
    //                     _SmokeArray pushBackUnique _x;
    //                 };
    //             }
    //             foreach _ammoArray;
    //         };
    //     }
    //     foreach(units _clstGrp);
    //     private _VAttached = selectRandom _VCnt;
    //     private _LazTarget = _LazClass createVehicle[0, 0, 0];
    //     _LazTarget attachto[_VAttached, [0, 0, 4]];
    //     _LazTarget spawn {
    //         sleep 120;
    //         deleteVehicle _this;
    //     };
    //     _CallSide reportRemoteTarget[_VAttached, 120];
    //     _VAttached confirmSensorTarget[_CallSide, true];

    //     if (VCM_Debug) then {
    //         systemChat(format["_LazTarget: %1 Attached To: %2", _LazTarget, (typeOf _VAttached)])
    //     };
    // }
    // else {
    {
        private _Unit = _x;
        private _ammoArray = getArtilleryAmmo[vehicle _Unit];
        if !(isNil "_ammoArray") then {
            {
                private _Type = getText(configfile / "CfgMagazines" / _x / "displayNameShort");
                if (["HE", _Type] call BIS_fnc_inString || ["3vo18", tolower _Type] call BIS_fnc_inString || ["Cluster", _Type] call BIS_fnc_inString && !(["AT", _Type] call BIS_fnc_inString)) then {
                    _artilleryProps = opfor_artillery get(typeOf vehicle _Unit);
                    if (_x in _artilleryProps) then {
                        _artilleryammoProps = _artilleryProps get _x;
                        _maxRange = _artilleryammoProps select 1;
                        _minRange = _artilleryammoProps select 0;
                        _saveDist = _artilleryammoProps select 3;
                        _distOfEnemy = _Unit distance _PredictedLoc2;
                        if !(_distOfEnemy > _maxRange || _distOfEnemy < _minRange) then {
                            _FinalArtyArray pushBackUnique _Unit;
                            _FinalAmmoType pushBackUnique _x;
                        };

                    };

                };
                if (["Smoke", _Type] call BIS_fnc_inString) then {
                    _SmokeArray pushBackUnique _x;
                };
            }
            foreach _ammoArray;
        };
    }
    foreach(units _clstGrp);

    // };


    if (VCM_Debug) then {
        systemChat(format["_clstGrp: %1  _FinalAmmoType: %2", _clstGrp, _FinalAmmoType])
    };











    private _aVehGrpunits = []; {
        _aVehGrpunits pushBack(vehicle _x)
            // _atrtype = typeOf (vehicle _Unit);
            // if !(_atrtype in opfor_artillery) exitwith {
            //     if (VCM_Debug) then {
            //         [(leader _clstgrp), "NO AMMO"] call VCM_fnc_Debugtext;
            //     };
            //     ["artillery %1 not allowed to fire %2 (artillery does not exist)", _atrtype, _Finalammotype] spawn KPLIB_fnc_zueslog;
            // };
            // _artilleryProps= opfor_artillery get _atrtype;
            // if !(_Finalammotype in _artilleryProps) exitwith {
            //     if (VCM_Debug) then {
            //         [(leader _clstgrp), "NO AMMO"] call VCM_fnc_Debugtext;
            //     };
            //     ["artillery %1 not allowed to fire %2 (ammo does not exist)", _atrtype, _Finalammotype] spawn KPLIB_fnc_zueslog;
            // };
            // _artilleryammoProps= _artilleryProps get _Finalammotype;
            // _maxRange =_artilleryammoProps select 0;
            // _minRange =_artilleryammoProps select 1;
            // _saveDist =_artilleryammoProps select 3;
    }
    forEach _FinalArtyArray;

    private _randomAmmoArray = selectRandom _FinalAmmoType;
    if (isNil "_randomAmmoArray") exitWith {
        If(VCM_Debug) then {
            [(leader _clstGrp), "NO AMMO"] call VCM_fnc_DebugText;
        };
    };


    //Exit if group cannot reach.
    private _continueFiring = _PredictedLoc2 inRangeOfArtillery[_aVehGrpUnits, _randomAmmoArray];
    // _distOfEnemy =  _aVehGrpUnits distance _PredictedLoc2;
    // if (_distOfEnemy>_maxRange || _distOfEnemy <_minRange) then {
    //     _continueFiring = true;
    //     ["artillery fire canceled target distance %1 , minimum is %2 and maximum is %3", _distOfEnemy, _minRange,_maxRange] spawn KPLIB_fnc_zuesLog;
    // };
    if !(_continueFiring) exitWith {
        If(VCM_Debug) then {
            [(leader _clstGrp), "NOT APPROPRIATE RANGE"] call VCM_fnc_DebugText;
        };
    };


    // Make sure we do minimal friendly fire.
    private _FriendlyArray = (leader _clstgrp) call VCM_fnc_FriendlyArray;

    private _ajustmentLead = _aVehGrpunits select 0;
    private _ajustmentdist = (80 + (random 30));
    private _ajustmentpos = _PredictedLoc2;
    private _ajustmentpositions = _ajustmentpos getPos[_ajustmentdist, (random 360)];
    private _ajustmentCF = [_FriendlyArray, _ajustmentpositions, true, "Arty1"] call VCM_fnc_Clstobj;



    if (VCM_Debug) then {
        [(leader _clstgrp), "DO AJUSTMENT FIRE TARGET " + str _AvgKnw] call VCM_fnc_Debugtext;
    };

    ["Firing artillery adjustment on target %1 with %2 knowledge.", name(leader _enemyGrp), str _AvgKnw] spawn KPLIB_fnc_zuesLog;
    if (_ajustmentCF distance2D _ajustmentpositions > 50) then {
        _ajustmentLead doArtilleryfire[_ajustmentpositions, _randomammoArray, 1];
    };
    sleep 30;

    ["Firing artillery barrage of %1 shell on target %2 within %3-%4 of target.", _RndNumber, name(leader _enemyGrp), str _minRDist, str _maxRDist] spawn KPLIB_fnc_zuesLog;
    for "_i"
    from 1 to floor(_RndNumber / (count _aVehGrpunits)) do {
            {
                _dist = (_minRDist + (random _maxRDist));
                _pos = _PredictedLoc2;
                _positions = _pos getPos[_dist, (random 360)];
                _gun = _x;
                private _CF = [_FriendlyArray, _positions, true, "Arty1"] call VCM_fnc_Clstobj;

                if (_CF distance2D _positions > 50) then {
                    if (VCM_Debug) then {
                        [(leader _clstgrp), "DO SMOKE FIRE TARGET " + str _AvgKnw] call VCM_fnc_Debugtext;
                    };
                    _gun doArtilleryfire[_positions, _randomammoArray, 1];
                } else {
                    if (count _SmokeArray > 0) then {
                        if (VCM_Debug) then {
                            [(leader _clstgrp), "DO SMOKE FIRE TARGET " + str _AvgKnw] call VCM_fnc_Debugtext;
                        };
                        _gun doArtilleryfire[_positions, (selectRandom _SmokeArray), 1];
                    };
                };
            }
            forEach _aVehGrpunits;

            sleep 10;
        };

        sleep 10;
    if (VCM_Debug) then {
        [(leader _clstgrp), "DONE FIRE"] call VCM_fnc_Debugtext;
    };
};