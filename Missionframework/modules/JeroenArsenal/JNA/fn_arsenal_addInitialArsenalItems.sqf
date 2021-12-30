
//[cursorObject] call jn_fnc_arsenal_addInitialArsenalItems
_items = [
//Weapons	
GRLIB_arsenal_weapons_primary select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,(_x select 4)]}
//launcher
,GRLIB_arsenal_weapons_secondary select {(_x select 4 > 0) ||(_x select 4 == -1)}  apply { [(_x select 0) , (_x select 4)]}
//handguns
,GRLIB_arsenal_weapons_handgun select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) , (_x select 4)]}
//uniforms
,GRLIB_arsenal_uniforms select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) , (_x select 4)]}
//vests
,GRLIB_arsenal_vests select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//bags
,GRLIB_arsenal_backpacks select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) , (_x select 4)]}
//headgear
,GRLIB_arsenal_headgear select {(_x select 4 > 0) ||(_x select 4 == -1)}  apply { [(_x select 0) ,( _x select 4)]}
//facewear
,GRLIB_arsenal_facegear select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//nightvision
,GRLIB_arsenal_nightvision select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//rangefinders
,GRLIB_arsenal_rangefinders select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//maps
,GRLIB_arsenal_maps select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//terminal
,GRLIB_arsenal_terminal select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//radio
,GRLIB_arsenal_radio select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//compass
,GRLIB_arsenal_compass select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}

//watchs
,GRLIB_arsenal_watchs select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
,[]
,[]
,[]
//optics
,GRLIB_arsenal_optics select { (_x select 4 > 0) ||(_x select 4 == -1) } apply { [(_x select 0) ,( _x select 4)]}
//flash and laser
,GRLIB_arsenal_flashlaser select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//muzzles
,GRLIB_arsenal_muzzles select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
,[]
//HandGrenade
,GRLIB_arsenal_HandGrenade select {(_x select 4 > 0) ||(_x select 4 == -1)}apply { [(_x select 0) ,( _x select 4)]}
//explosives
,GRLIB_arsenal_explosives select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//items
,GRLIB_arsenal_other select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}

//bipods
,GRLIB_arsenal_bipods select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,( _x select 4)]}
//mags
,GRLIB_arsenal_magazines select {(_x select 4 > 0) ||(_x select 4 == -1)} apply { [(_x select 0) ,(_x select 4)]}
];

// _names= [];
//	 {
//	 _names pushBack ( getText(configFile >> "CfgWeapons" >> (_x select 0) >> "displayName"));	
//	 } forEach _weapons;
// _names


_this setVariable ["jna_dataList" ,_items,true];


