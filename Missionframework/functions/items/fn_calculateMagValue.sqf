/*
File: fn_calculateMagValue.sqf
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
//["UK3CB_AK47_30Rnd_Magazine"] call KPLIB_fnc_calculateMagValue;
params [
    "_magazine"
];

_type = (_magazine call BIS_fnc_itemtype) select 1;


_cfgMagazine = configFile >> "Cfgmagazines" >> _magazine;
_name = gettext(_cfgMagazine >> "displayname");

_ammoClass = gettext (_cfgMagazine >> "ammo");

_cfgammo = configFile >> "cfgammo" >> _ammoClass;

// The amount of ammo this magazine holds.
_magazinecount = getNumber (_cfgMagazine >> "count");

// Starting speed of missile.
_initspeed = getNumber (_cfgMagazine >> "initspeed");

// How much the air friction slows down the projectile.
_airFriction = getNumber (_cfgammo >> "airFriction");

// How much can AI hear when given weapon is fired.
_audiblefire = getNumber (_cfgammo >> "audiblefire");

// The intensity of the light source. Used in illuminating flares.
_brightness = getNumber (_cfgammo >> "brightness");

// Acts as penetration multiplier for the projectile.
// Penetration depth in mm velocity[m/s] * caliber * penetrability / 1000. Penetrability is a material property (for RHA steel it is 15, for concrete 80, for meat 250).
_caliber = getNumber (_cfgammo >> "caliber");

// cost-gain evaluation is performed to choose an appropriate weapon.
_cost = getNumber (_cfgammo >> "cost") /10;

// Declares the maximum speed (metres per second).
_maxspeed = getNumber (_cfgammo >> "maxspeed");

// damage on hit. in OFP total damage is calculated as: total damage = Hit damage - indirect damage (while hit value is larger than indirectHit). note that in Arma 3 damage calculation is different. for bullets with caliber=0 the standard damage is dealt. for bullets with caliber > 0 only a fraction of the "hit" value is dealt when the bullet completely penetrates the firegeometry. The damage behaviour in this case is nonlinear (depending on firegeometry thickness) and currently not possible to predict.
_hit = getNumber (_cfgammo >> "hit");

// Defines the max. distance in meters at which the AI becomes suppressed by the projectile's impact or explosion. default value -1 disables the suppressive effect.
_suppressionradiusHit = getNumber (_cfgammo >> "suppressionradiusHit");
// Defines the max. distance in meters at which the AI becomes suppressed by the bullet's pass. default value -1 disables the suppressive effect (works only for bullets, no other projectiles).
_suppressionradiusBulletClose = getNumber (_cfgammo >> "suppressionradiusBulletClose");
_cost = _cost +(_hit/10 ) + (_caliber/10 ) + (_suppressionradiusHit/40) + (_initspeed/10000) ;

if (
(toLower _magazine) find "mixed" != -1 ||
(toLower _ammoClass) find "mixed" != -1 ||
(toLower _name) find "mixed" != -1) then {
     _cost = (_cost +0.1) + (_cost * 1.1)
};

if (((toLower _magazine) find "tracer" != -1 ||
(toLower _ammoClass) find "tracer" != -1 ||
(toLower _name) find "tracer" != -1
    
||
(toLower _magazine) find "red" != -1 ||
(toLower _ammoClass) find "red" != -1 ||
(toLower _name) find "red" != -1

||
(toLower _magazine) find "green" != -1 ||
(toLower _ammoClass) find "green" != -1 ||
(toLower _name) find "green" != -1

||
(toLower _magazine) find "yellow" != -1 ||
(toLower _ammoClass) find "yellow" != -1 ||
(toLower _name) find "yellow" != -1

||
(toLower _magazine) find "white" != -1 ||
(toLower _ammoClass) find "white" != -1 ||
(toLower _name) find "white" != -1) &&

(toLower _name) find "no tracer" == -1) then {
    _cost = (_cost +0.1) + (_cost * 1.2)
};
if ((toLower _magazine) find "ir" != -1 ||
(toLower _magazine) find "dim" != -1 ||
(toLower _ammoClass) find "ir" != -1 ||
(toLower _ammoClass) find "dim" != -1) then {
    _cost = (_cost +0.2) + (_cost * 1.3)
};
if ((toLower _magazine) find "ap" != -1 ||
(toLower _ammoClass) find "ap" != -1 ||
(toLower _name) find "ap" != -1)
then {
    _cost = (_cost +0.2) + (_cost * 1.2)
};
if ((toLower _magazine) find "mod1" != -1 ||
(toLower _magazine) find "mod_1" != -1 ||
(toLower _ammoClass) find "mod1" != -1 ||
(toLower _ammoClass) find "mod_1" != -1 ||
(toLower _name) find "mod 1" != -1||
(toLower _name) find "mod1" != -1
) then {
    _cost = (_cost +0.1) + (_cost * 1.2)
};
if ((toLower _magazine) find "mod0" != -1 ||
(toLower _magazine) find "mod_0" != -1 ||
(toLower _ammoClass) find "mod0" != -1 ||
(toLower _ammoClass) find "mod_0" != -1||
(toLower _name) find "mod 0" != -1||
(toLower _name) find "mod0" != -1) then {
    _cost = (_cost +0.1) + (_cost * 1.2)
};
if ((toLower _magazine) find "ebr" != -1 ||
(toLower _magazine) find "ebr" != -1 ||
(toLower _name) find "ebr" != -1) then {
    _cost = (_cost +0.1) + (_cost * 1.2)
};

if ((toLower _magazine) find "subsonic" != -1 ||
(toLower _magazine) find "subsonic" != -1 ||
(toLower _name) find "subsonic" != -1) then {
    _cost = (_cost +0.1) + (_cost * 1.2)
};

if (_type isEqualTo "Grenade"||_type isEqualTo "Shell" ) then {
    _cost = _cost +20 ;
};
if (_type isEqualTo "SmokeShell" ||_type isEqualTo "Flare"   ) then {
    _cost = _cost + 5 ;
};

if (_type isEqualTo "Missile" ) then {
    _cost = _cost +60 ;
};       
if ( _type isEqualTo "Rocket") then {
    _cost = _cost +30 ;
};      

ceil ( _cost* (_magazinecount/10))