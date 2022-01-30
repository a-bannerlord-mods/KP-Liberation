params ["_screen",["_screenIndex",0]];

Cam_headgear_items = ["rhsusf_opscore_ut_pelt_nsw_cam","vsm_fasthelmet_od"];

fScreen =_screen;
fScreenIndex = _screenIndex;

avldrones = entities [["UAV"], [], false, true] ; 
avldrones = avldrones + entities [["UAV_02_base_F"], [], false, true];
avldrones = avldrones + entities [["UAV_01_base_F"], [], false, true]; 

avldrones = avldrones arrayIntersect avldrones;
avldrones = avldrones select {alive _x};

_data = avldrones  apply {  
[ 
	[getText(configFile >> "CfgVehicles" >> typeof _x >> "displayName")], 
	[], 
	[getText(configFile >> "CfgVehicles" >> typeof _x >> "picture")], 
	[getText(configFile >> "CfgVehicles" >> typeof _x >> "icon"),[random 1,random 1,random 1,1]], 
	getText(configFile >> "CfgVehicles" >> typeof _x >> "displayName"), 
	typeof _x, 
	avldrones find _x 
]}; 

[
    [
        _data,
        4, // selects the quadbike by default
        false // Multi select disabled
    ],
    "Unit selection",
    {
        // systemChat format["_confirmed: %1", _confirmed];
        // systemChat format["_index: %1", _index];
        // systemChat format["_data: %1", _data];
        // systemChat format["_value: %1", _value];
		if (_confirmed) then {
			[fScreen,(avldrones select _index),fScreenIndex]  call CCC_connectDroneToScreen;
		};
    },
    "", // reverts to default
    "" // reverts to default, disable cancel option
] call CAU_UserinputMenus_fnc_listbox;