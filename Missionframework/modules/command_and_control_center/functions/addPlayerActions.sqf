params ["_player"];


_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Turn on", "</t>"] joinString "",
    {
		[cursorObject] call CCC_turnOnScreen;
		//[cursorObject] remoteExec ["CCC_turnOnScreen", [0, -2] select isDedicated];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_All_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];



// player cams
_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Unit", "</t>"] joinString "",
    {
		[cursorObject] call CCC_setFeedToUnit;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_Single_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Unit (Screen 1)", "</t>"] joinString "",
    {
		[cursorObject,0] call CCC_setFeedToUnit;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Unit (Screen 2)", "</t>"] joinString "",
    {
		[cursorObject,1] call CCC_setFeedToUnit;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Unit (Screen 3)", "</t>"] joinString "",
    {
		[cursorObject,2] call CCC_setFeedToUnit;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];


//drones

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Drone", "</t>"] joinString "",
    {
		[cursorObject] call CCC_setFeedToDrone;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_Single_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Drone (Screen 1)", "</t>"] joinString "",
    {
		[cursorObject,0] call CCC_setFeedToDrone;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Drone (Screen 2)", "</t>"] joinString "",
    {
		[cursorObject,1] call CCC_setFeedToDrone;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Feed To Drone (Screen 3)", "</t>"] joinString "",
    {
		[cursorObject,2] call CCC_setFeedToDrone;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];


//zoom

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Zoom Level", "</t>"] joinString "",
    {
		[cursorObject] call CCC_setZoomLevel;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_Single_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Zoom Level (Screen 1)", "</t>"] joinString "",
    {
		[cursorObject,0] call CCC_setZoomLevel;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Zoom Level (Screen 2)", "</t>"] joinString "",
    {
		[cursorObject,1] call CCC_setZoomLevel;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Zoom Level (Screen 3)", "</t>"] joinString "",
    {
		[cursorObject,2] call CCC_setZoomLevel;
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];


//normal 
_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Normal Vision Mode", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[0];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_Single_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Normal Vision Mode (Screen 1)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[0];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Normal Vision Mode (Screen 2)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[0];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Normal Vision Mode (Screen 3)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[0];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

//NV
_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[1];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_Single_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode (Screen 1)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[1];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode (Screen 2)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[1];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode (Screen 3)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[1];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

//Thermal
_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Thermal Vision Mode", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[2];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& typeof cursorObject in (CCC_Feed_Single_Screens apply {_x select 0 })
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode (Screen 1)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[2];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode (Screen 2)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[2];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Double_Screens apply {_x select 0 }) ||  typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];

_player addAction [
    ["<img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/><t color='#80FF80'> ", "Set Night Vision Mode (Screen 3)", "</t>"] joinString "",
    {
		_screenIndex = 0;
		_live_feed_texture = cursorObject getVariable [("live_feed_texture" + str _screenIndex) ,""];
		_live_feed_texture setPiPEffect[2];
	},
    nil,
    -730,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (isNull cursorObject || _originalTarget distance cursorObject < 10 )
        && {alive _originalTarget}
		&& (typeof cursorObject in (CCC_Feed_Trible_Screens apply {_x select 0 }))
        && {build_confirmed isEqualTo 0}
        && [_originalTarget,1.5] call  KPLIB_fnc_isPlayerNearToFob
    "
];