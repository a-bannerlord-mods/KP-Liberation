/*
    File: fn_addActionsFob.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-04-13
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Adds build action to FOB box and repackage action to FOB building.

    Parameter(s):
        _obj - FOB box/truck/building to add the deploy/repack action to [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/

params [
    "_weapon" 
];

_ge = _weapon call BIS_fnc_itemType;


_basecost = 0; 
if ((_ge select 0) == "Weapon") then {
    switch ((_ge select 1)) do {
        case "AssaultRifle": {_basecost = 12; };
        case "BombLauncher": {_basecost = 10; };
        case "Cannon": {_basecost = 10; };
        case "GrenadeLauncher": {_basecost = 10; };
        case "Handgun": {_basecost = 2; };
        case "Launcher": {_basecost = 10; };
        case "MachineGun": {_basecost = 40; };
        case "MissileLauncher": {_basecost = 50; };
        case "RocketLauncher": {_basecost = 30; };
        case "Shotgun": { _basecost = 5;};
        case "Rifle": {_basecost = 10;  };
        case "SubmachineGun": {_basecost = 8;  };
        case "SniperRifle": {_basecost = 40; };
        default {_basecost = 0;  };
    };

    _cfgWeapon = configfile >> "cfgweapons" >> _weapon;
    //returns 0.15 - time between each shot 
    _reloadTime = getNumber (_cfgWeapon >> "reloadTime");

    //returns 2 - time needed to change magazine
    _magazineReloadTime = getNumber (_cfgWeapon >> "magazineReloadTime");

    _mass =getNumber (_cfgWeapon >> "WeaponSlotsInfo" >> "mass");

    //In-game weapon handling value, lower value = takes more time to traverse a weapon.
    _dexterity =getNumber (_cfgWeapon >> "dexterity");

    //In A3 this has multiple usages. positive values override magazine initspeed with the fixed number. Negative values act as modifier to the magazine's initispeed.
    //initSpeed = 1050; //overwrites magazine's value with 1050m/s
    //initSpeed = -1.1; //multiplies magazine's value by +1.1
    _initSpeed =getNumber (_cfgWeapon >> "initSpeed");

    _aimTransitionSpeed  =getNumber (_cfgWeapon >> "aimTransitionSpeed");



    _usableMagazines = [];
    {
	    _cfgMuzzle = if (_x == "this") then {_cfgWeapon} else {_cfgWeapon >> _x};
	    {
		    _usableMagazines pushBackUnique _x;
	    } foreach getarray (_cfgMuzzle >> "magazines");
    } foreach getarray (_cfgWeapon >> "muzzles");
    
    // means all parameters necessary for the one and only mode are declared within the main body. Note this also gives the order of selection using the control key in-game.
    _modes = getarray (_cfgWeapon >> "modes") 

    //Some modes defined for AI usage (e.g. burst modes for full auto weapons) can be hidden from player with this parameter.
    //showToPlayer=true

    //Mean Rounds Between Stoppages (this will be scaled based on the barrel temp)
    _ace_overheating_mrbs = getNumber (configFile >> "CfgWeapons" >> "rhs_weap_m4a1" >> "ace_overheating_mrbs"  );
    //Slowdown Factor, reduces the velocity of the projectile (this will be scaled based on the barrel temp)
    _ace_overheating_slowdownFactor= getNumber (configFile >> "CfgWeapons" >> "rhs_weap_m4a1" >> "ace_overheating_slowdownFactor"  );
    // 1 to enable barrel swap. 0 to disable. Meant for machine guns where you can easily swap the barrel without dismantling the whole weapon.
    _ace_overheating_allowSwapBarrel = getNumber (configFile >> "CfgWeapons" >> "rhs_weap_m4a1" >> "ace_overheating_allowSwapBarrel"  );
    //Dispersion Factor, increases the dispersion of the projectile (this will be scaled based on the barrel temp)
    _ace_overheating_dispersion= getNumber (configFile >> "CfgWeapons" >> "rhs_weap_m4a1" >> "ace_overheating_dispersion"  );
    
    //ace_overheating_closedBolt = 0; // Open bolt, can only cook off on failure to fire type jams.
    //ace_overheating_closedBolt = 1; // Closed bolt, can cook off from barrel heat.
    _ace_overheating_closedBolt= getNumber (configFile >> "CfgWeapons" >> "rhs_weap_m4a1" >> "ace_overheating_closedBolt"  );


} 
