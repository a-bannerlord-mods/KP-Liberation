
//[cursorObject] call jn_fnc_arsenal_addInitialArsenalItems
_items = [
//Weapons	
GRLIB_arsenal_weapons_primary apply { [(_x select 0) ,(_x select 4)]}
//launcher
,GRLIB_arsenal_weapons_secondary apply { [(_x select 0) , (_x select 4)]}
//handguns
,GRLIB_arsenal_weapons_handgun apply { [(_x select 0) , (_x select 4)]}
//uniforms
,GRLIB_arsenal_uniforms apply { [(_x select 0) , (_x select 4)]}
//vests
,GRLIB_arsenal_vests apply { [(_x select 0) ,( _x select 4)]}
//bags
,GRLIB_arsenal_backpacks apply { [(_x select 0) , (_x select 4)]}
//headgear
,GRLIB_arsenal_headgear  apply { [(_x select 0) ,( _x select 4)]}
//facewear
,GRLIB_arsenal_facegear apply { [(_x select 0) ,( _x select 4)]}
//nightvision
,GRLIB_arsenal_nightvision apply { [(_x select 0) ,( _x select 4)]}
//rangefinders
,GRLIB_arsenal_rangefinders apply { [(_x select 0) ,( _x select 4)]}
//maps
,GRLIB_arsenal_maps apply { [(_x select 0) ,( _x select 4)]}
//terminal
,GRLIB_arsenal_terminal apply { [(_x select 0) ,( _x select 4)]}
//radio
,GRLIB_arsenal_radio apply { [(_x select 0) ,( _x select 4)]}
//compass
,GRLIB_arsenal_compass apply { [(_x select 0) ,( _x select 4)]}

//watchs
,GRLIB_arsenal_watchs apply { [(_x select 0) ,( _x select 4)]}
,[]
,[]
,[]
//optics
,GRLIB_arsenal_optics apply { [(_x select 0) ,( _x select 4)]}
//flash and laser
,GRLIB_arsenal_flashlaser apply { [(_x select 0) ,( _x select 4)]}
//muzzles
,GRLIB_arsenal_muzzles apply { [(_x select 0) ,( _x select 4)]}
,[]
//HandGrenade
,GRLIB_arsenal_HandGrenade apply { [(_x select 0) ,( _x select 4)]}
//explosives
,GRLIB_arsenal_explosives apply { [(_x select 0) ,( _x select 4)]}
//items
,GRLIB_arsenal_other apply { [(_x select 0) ,( _x select 4)]}

//bipods
,GRLIB_arsenal_bipods apply { [(_x select 0) ,( _x select 4)]}
//mags
,GRLIB_arsenal_magazines apply { [(_x select 0) ,(_x select 4)]}
];

// _names= [];
//	 {
//	 _names pushBack ( getText(configFile >> "CfgWeapons" >> (_x select 0) >> "displayName"));	
//	 } forEach _weapons;
// _names


_this setVariable ["jna_dataList" ,_items,true];


