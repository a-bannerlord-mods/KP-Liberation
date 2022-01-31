params ["_screen",["_screenIndex",0]];

Cam_headgear_items = ["rhsusf_opscore_ut_pelt_nsw_cam","vsm_fasthelmet_od"];

fScreen =_screen;
fScreenIndex = _screenIndex;

avlplayers = (allplayers select { 
	_hasItem = [_x, "ItemcTabHCam"] call BIS_fnc_hasItem; 
	_hasItem = _hasItem || (toLower(headgear _x) in Cam_headgear_items); 
	_hasItem	
}); 

_data = avlplayers  apply { 
[
				[name _x],
				[],
				[
					getText(configfile >> "RscDisplayMultiplayerSetup" >> "west"),
					(configfile >> "RscDisplayMultiplayerSetup" >> "controls" >> "CA_B_West" >> "colorActive") call BIS_fnc_colorConfigToRGBA
				],
				[], 
				name _x, name _x, avlplayers find _x
			]
		
}; 

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
		if (_confirmed &&  (count avlplayers > 0)) then {
			[fScreen,(avlplayers select _index),fScreenIndex]  call CCC_connectUnitToScreen;
		};
    },
    "", // reverts to default
    "" // reverts to default, disable cancel option
] call CAU_UserinputMenus_fnc_listbox;