// [] call jn_fnc_arsenal_getItemsWithPermission;
if (isnil "ItemsWithPermission") then {
	ItemsWithPermission = [];
};

{
    if ([_x]  call jn_fnc_arsenal_hasItemPermission) then {
		ItemsWithPermission pushBack (tolower _x);
	};
} forEach GRLIB_arsenal_items;

ItemsWithPermission