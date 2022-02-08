/*
	Author: Ahmed Salah

	Description:
	Return a cost of unit loadout

	Parameter(s):
	a unit

	Returns:
	INT represent a cost of unit loadout
*/

params["_unit"];

_items = ([primaryWeapon _unit] + primaryWeaponItems _unit +  
[secondaryWeapon _unit] + secondaryWeaponItems _unit +  
[handgunWeapon _unit] + handgunItems _unit +  
[uniform _unit] +  
[backpack _unit] +  
[vest _unit] +  
[headgear _unit] +   
[goggles _unit]+ 
assignedItems _unit +  
items _unit +  
magazines _unit) select {_x!=""}; 

_itemsCost = 0; 
{ 
	_item = tolower _x;
	if (_item in GRLIB_arsenal_items) then {
		_itemsCost = _itemsCost + ((GRLIB_arsenal_items get _item) select 0);  
	};

} forEach _items; 

_itemsCost