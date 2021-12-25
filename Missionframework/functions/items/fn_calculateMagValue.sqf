/*
File: fn_addActionsFob.sqf
Author: KP Liberation Dev Team - https:// github.com/KillahPotatoes
date: 2020-04-13
Last Update: 2020-04-13
License: MIT License - http:// www.opensource.org/licenses/MIT

Description:
Adds build action to FOB box and repackage action to FOB building.

parameter(s):
_weapon - UK3CB_AK47_30Rnd_Magazine

Returns:
Function reached the end [BOOL]
*/

params [
    "_magazine"
];

_ge = _magazine call BIS_fnc_itemtype;

_basecost = -1;
if ((_ge select 0) != "Weapon") exitwith {
    -1
};


_magazine = "UK3CB_AK47_30Rnd_Magazine";
_cfgMagazine = configFile >> "CfgMagazines" >> _magazine;

_ammoClass = getText (_cfgMagazine >> "ammo");

_cfgAmmo = configFile >> "cfgAmmo" >> _ammoClass;


// The amount of ammo this magazine holds.
_magazineCount = getNumber (_cfgMagazine >> "count");

// Starting speed of missile.
_initSpeed = getNumber (_cfgMagazine >> "initSpeed");

// How much the air friction slows down the projectile. 
_airFriction = getNumber (_cfgAmmo >> "airFriction");



// How much can AI hear when given weapon is fired.
_audibleFire = getNumber (_cfgAmmo >> "audibleFire");


// The intensity of the light source. Used in illuminating flares.
_brightness = getNumber (_cfgAmmo >> "brightness");


//Acts as penetration multiplier for the projectile.
//Penetration depth in mm velocity[m/s] * caliber * penetrability / 1000. Penetrability is a material property (for RHA steel it is 15, for concrete 80, for meat 250).
_caliber = getNumber (_cfgAmmo >> "caliber");

//Cost-gain evaluation is performed to choose an appropriate weapon.
_cost = getNumber (_cfgAmmo >> "cost");


//Declares the maximum speed (metres per second).
_maxSpeed = getNumber (_cfgAmmo >> "maxSpeed");


//Damage on hit. In OFP total damage is calculated as: Total damage = Hit damage - Indirect damage (while hit value is larger than indirectHit). Note that in Arma 3 damage calculation is different. For bullets with caliber=0 the standard damage is dealt. For bullets with caliber > 0 only a fraction of the "hit" value is dealt when the bullet completely penetrates the firegeometry. The damage behaviour in this case is nonlinear (depending on firegeometry thickness) and currently not possible to predict.
_hit = getNumber (_cfgAmmo >> "hit");


//Defines the max. distance in meters at which the AI becomes suppressed by the projectile's impact or explosion. Default value -1 disables the suppressive effect.
_suppressionRadiusHit = getNumber (_cfgAmmo >> "suppressionRadiusHit");
//Defines the max. distance in meters at which the AI becomes suppressed by the bullet's pass. Default value -1 disables the suppressive effect (works only for bullets, no other projectiles).
_suppressionRadiusBulletClose = getNumber (_cfgAmmo >> "suppressionRadiusBulletClose");


