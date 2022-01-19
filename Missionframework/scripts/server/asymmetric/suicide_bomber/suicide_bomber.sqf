// nul = [unit_name,trigger_distance,sound,chase_players] call suicide_bomber; 

// unit	- string, is the name of the kamikaze unit 
// trigger_distance - number, distance from targeted player at which the kamikaze will blow himself up 
// sound	- boolean, if is true a random sound from a given array is played, if is false kamikaze will not shout 
// chase_players  - boolean, if true the kamikaze unit will chase players, otherwise will be pasive and blow himself up when a random player is in its proximity 

// // >>>> Example 1 
// nul = [this,50,true,true] call suicide_bomber; 

// - kamikaze will blow up at 50 meters from target 
// - kamikaze will yell 
// - Kamikaze will chase players 




// // >>>> Example 2 
// nul = [this,50,false,false] call suicide_bomber; 

// - kamikaze will blow up at 50 meters from target 
// - kamikaze will NOT yell 
// - Kamikaze will NOT chase players 

// // >>>> Example 3 
// nul = [this,20,false,true] call suicide_bomber; 

// - kamikaze will blow up at 15 meters from target 
// - kamikaze will NOT yell 
// - Kamikaze will chase players 


params["_unit", "_dist", "_soundk", "_chase_players"];
private["_expl1", "_expl2", "_expl3", "_bombk", "_list_p", "_grp", "_strigat", "_check_p", "_target"];
_target = objNull;

_unit enableFatigue false;

_grp = creategroup civilian;

[_unit] joinSilent _grp;

_grp setBehaviour "AWARE";
_grp setCombatMode "RED";
_grp setspeedMode "FULL";

_expl1 = "DemoCharge_Remote_ammo"
createvehicle position _unit;
_expl1 attachto[_unit, [-0.1, 0.1, 0.15], "Pelvis"];
_expl1 setvectorDirAndUp[[0.5, 0.5, 0], [-0.5, 0.5, 0]];
_expl2 = "DemoCharge_Remote_ammo"
createvehicle position _unit;
_expl2 attachto[_unit, [0, 0.15, 0.15], "Pelvis"];
_expl2 setvectorDirAndUp[[1, 0, 0], [0, 1, 0]];
_expl3 = "DemoCharge_Remote_ammo"
createvehicle position _unit;
_expl3 attachto[_unit, [0.1, 0.1, 0.15], "Pelvis"];
_expl3 setvectorDirAndUp[[0.5, -0.5, 0], [0.5, 0.5, 0]];

_unit setVariable ["lambs_danger_disableAI", true,true];

_unit addEventHandler ["Hit", {
    params ["_unit", "_source", "_damage", "_instigator"];
    if (side _instigator != side _unit) then {
        [_unit, true] call ace_captives_fnc_setSurrendered;
    };
}];

_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

sleep 10;

while {
alive _unit
}
do {
    _allunits = []; 
    {
        _allunits pushBack _x;
    }forEach(allPlayers select {
        alive _x &&  side _x  == GRLIB_side_friendly && (((GRLIB_side_enemy knowsAbout _x) > 2 &&_unit distance _x < 400 ) || _unit distance _x < 60 )
    });

    if ((count _allunits) > 0) then {
        _target = _allunits call BIS_fnc_selectRandom;
        while {
            alive _unit && alive _target &&  !(captive _unit) && !(_unit getVariable['ACE_isUnconscious', false])
        }
        do {
            if (_soundk) then {
                _strigat = ["NoSound", "01", "NoSound", "02", "NoSound", "04", "NoSound", "05", "NoSound", "06", "NoSound", "07", "NoSound", "08", "NoSound", "09", "NoSound", "099", "NoSound"] call BIS_fnc_selectRandom;
                [_unit, [_strigat, 300]] remoteExec["say3D"];
            };
            if (_chase_players) then {
                {
                    _x domove getPos _target;
                }
                forEach units _grp
            };
            _players = allplayers select {
                side _x == west
            };
            _check_p = [];
            _check_p = _players inAreaArray[getPosATL _unit, _dist, _dist, 0, false, -1];

            if (count _check_p > 0 && alive _unit && !(captive _unit) && !(_unit getVariable['ACE_isUnconscious', false])) then {
                _strigat = ["01", "02", "04", "05", "06", "07", "08", "09", "099"] call BIS_fnc_selectRandom;
                [_unit, [_strigat, 300]] remoteExec["say3D"];
                sleep(1 + random 2);
                _unit setvelocity[random 3, random 3, 5 + (random 15)];
                sleep 0.01;
                _unit enableSimulationGlobal false;
                sleep 0.01;
                _bombk = "M_Mo_82mm_AT_LG"
                createvehicle(getPos _unit);
                sleep 0.01;
                _unit enableSimulationGlobal false;
                sleep 0.01;
                _unit setDamage 1;
                deletevehicle _expl1;
                deletevehicle _expl2;
                deletevehicle _expl3;
                sleep 0.01;
                _unit enableSimulationGlobal true;
            };
            sleep 1;
        };

    } else {
        _target = objNull;
    };
    sleep 20;
};

        if (!isNull _expl1) then {
            deletevehicle _expl1;

        };
        if (!isNull _expl2) then {
            deletevehicle _expl2;

        };
        if (!isNull _expl3) then {
            deletevehicle _expl3;

        };