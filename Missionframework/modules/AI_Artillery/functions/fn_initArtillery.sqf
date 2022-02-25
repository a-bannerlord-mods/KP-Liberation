params["_vh"];

_magtypes = getArtilleryAmmo[_vh];
{
	_vh addmagazines[_x,20];
}
forEach _magtypes;

_magtypes