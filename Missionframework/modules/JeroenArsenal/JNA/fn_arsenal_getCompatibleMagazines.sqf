
/*
    By: Jeroen Notenbomer

	overwrites default arsenal script, original arsenal needs to be running first in order to initilize the display.

    fuctions:
    ["rhs_weap_akms"] call jn_fnc_arsenal_getCompatibleMagazines;
*/

params["_weapon"]; 
_usableMagazines = [];

_cfgWeapon = configfile >> "cfgweapons" >> _weapon;
{
    _cfgMuzzle = if (_x == "this") then {_cfgWeapon} else {_cfgWeapon >> _x};
    {
        _usableMagazines pushBackUnique _x;
    } foreach getarray (_cfgMuzzle >> "magazines");
} foreach getarray (_cfgWeapon >> "muzzles");

_usableMagazines