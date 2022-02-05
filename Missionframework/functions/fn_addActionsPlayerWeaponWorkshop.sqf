/*
    File: fn_addActionsPlayer.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-08-07
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Adds Liberation player actions to the given player.

    Parameter(s):
        _player - Player to add the actions to [OBJECT, defaults to player]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_player", player, [objNull]]
];

if !(isPlayer _player) exitWith {["No player given"] call BIS_fnc_error; false};

if (isNil "KP_liberation_resources_global") then {KP_liberation_resources_global = false;};



_player addAction [
    ["<img size='1' image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_saveas_ca.paa'/><t color='#FFFF00'> ", "Repaint Primary Weapon", "</t>"] joinString "",
    {
        
        _data = (GRLIB_weapons_colors get (primaryWeapon player)) apply { 
            [
                [_x select 1],
                [],
                [getText(configFile >> "CfgVehicles" >> _x select 0>> "picture")],
                [getText(configFile >> "CfgVehicles" >> _x select 0 >> "icon"),[random 1,random 1,random 1,1]],
                _x select 1,
                _x select 0,
                0
            ]
        }; 

        [
            [
                _data,
                0, // selects the quadbike by default
                false // Multi select disabled
            ],
            "Color selection",
            {
                // systemChat format["_confirmed: %1", _confirmed];
                // systemChat format["_index: %1", _index];
                // systemChat format["_data: %1", _data];
                // systemChat format["_value: %1", _value];
                if (_confirmed && !(_data == "")) then { 
					_oldAttachments =  primaryweaponitems player; 
					player addWeaponGlobal _data; 
					{  
					    player addPrimaryWeaponItem _x; 
					}foreach _oldAttachments; 
				};
            },
            "", // reverts to default
            "" // reverts to default, disable cancel option
        ] call CAU_UserinputMenus_fnc_listbox;
    
    },
    nil,
    -760,
    false,
    true,
    "",
    "
        isNull (objectParent _originalTarget)
        && (primaryWeapon _originalTarget) in GRLIB_weapons_colors
        && {alive _originalTarget}
        && {build_confirmed isEqualTo 0}
        && (typeof cursorObject) in ['Land_Workbench_01_F']
        && cursorObject distance player < 5
    "
];

