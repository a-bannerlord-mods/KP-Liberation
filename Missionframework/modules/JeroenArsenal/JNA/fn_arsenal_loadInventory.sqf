
#include "defineCommon.inc"

//items that need to be removed from arsenal
private _arrayPlaced = EMPTY_ARRAY;
private _arrayTaken = EMPTY_ARRAY;
private _arrayMissing = [];
private _arrayReplaced = [];
private _arrayNoPermission = [];

params ["_saveName",["_inventory",[]]];

private  _addToArray = {
	params ["_array","_index","_item","_amount"];

	if(_index != -1 && !(_item isEqualTo "") && _amount != 0)then{
		_array set [_index,[_array select _index,[_item,_amount]] call jn_fnc_common_array_add];
	};
};


private _removeFromArray = {
	params ["_array","_index","_item","_amount"];

	if(_index != -1 && !(_item isEqualTo "") && _amount != 0)then{
		_array set [_index,[_array select _index,[_item,_amount]] call jn_fnc_common_array_remove];
	};
};

private _addArrays = {
	_array1 = +(_this select 0);
	_array2 = +(_this select 1);
	{
		_index = _foreachindex;
		{
			_item = _x select 0;
			_amount = _x select 1;
			[_array1,_index,_item,_amount]call _addToArray;
		} forEach _x;
	} forEach _array2;
	_array1;
};

private _subtractArrays = {
	_array1 = +(_this select 0);
	_array2 = +(_this select 1);
	{
		_index = _foreachindex;
		{
			_item = _x select 0;
			_amount = _x select 1;
			[_array1,_index,_item,_amount]call _removeFromArray;
		} forEach _x;
	} forEach _array2;
	_array1;
};

//name that needed to be loaded

private _object = UINamespace getVariable "jn_object";
private _dataList = _object getVariable "jna_dataList";

if ((count _inventory) ==0) then {
	private _saveData = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
	{
		if (typename _x  == "STRING" && {_x == _saveName}) exitWith {
			_inventory = _saveData select (_foreachindex + 1);
		};
	} forEach _saveData;
};

systemChat "Loadout copied to Clipboard";
copyToClipboard str _inventory;
player setVariable ["loadout_template",_inventory,true];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// REMOVE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// magazines (loaded)
//["30Rnd_65x39_caseless_green",30,false,-1,"Uniform"]
{
	private _loaded = _x select 2; //we only want need the mags that are loaded in a weapon
	if(_loaded) then {
		private _item = _x select 0;
		private _amount = _x select 1;
		private _index = _item call jn_fnc_arsenal_itemType;
		//We dont need to remove the magazines here because they will be removed with the weapon later.
		[_arrayPlaced,_index,_item,_amount] call _addToArray;
	};
} foreach magazinesAmmoFull player;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// assinged items
private _assignedItems_old = assignedItems player - [binocular player] + [headgear player] + [goggles player]; //we ignore binocular here, because its a weapon
{
	private _item = _x;
	private _amount = 1;
	private _index = _item call jn_fnc_arsenal_itemType;
	player unlinkItem _item;
	[_arrayPlaced,_index,_item,_amount]call _addToArray;
} forEach _assignedItems_old - [""];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  weapon attachments
private _attachments = primaryWeaponItems player + secondaryWeaponItems player + handgunItems player;
{
	private _item = _x;
	private _amount = 1;
	private _index = _item call jn_fnc_arsenal_itemType;
	//We dont need to remove the attachments here because they will be removed with the weapon later.
	[_arrayPlaced,_index,_item,_amount]call _addToArray;
} forEach _attachments - [""];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	weapons
private _weapons_old = [primaryWeapon player, secondaryWeapon player, handgunWeapon player, binocular player];
{
	private _item = _x;
	if(_item != "")then{
		private _amount = 1;
		private _index = _foreachindex;
		player removeWeapon _item;
		[_arrayPlaced,_index,_item,_amount]call _addToArray;
	};
} forEach _weapons_old; // - [""]; we can use the _foreachindex as index number so we dont need jn_fnc_arsenal_itemType

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	uniform backpack vest (inc itmes)
private _uniform_old = uniform player;
private _vest_old = vest player;
private _backpack_old = backpack player;

//remove items from containers
{
	private _array = (_x call jn_fnc_arsenal_cargoToArray);
	//We dont need to remove the items here because they will be removed with uniform,vest and backpack later.
	_arrayPlaced = [_arrayPlaced, _array] call _addArrays;
} forEach [uniformContainer player, vestContainer player, backpackContainer player];

//remove containers
removeUniform player;
[_arrayPlaced,IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,_uniform_old,1]call _addToArray;
removeVest player;
[_arrayPlaced,IDC_RSCDISPLAYARSENAL_TAB_VEST,_vest_old,1]call _addToArray;
removeBackpack player;
[_arrayPlaced,IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,_backpack_old,1]call _addToArray;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  ADD
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private _availableItems = [_dataList, _arrayPlaced] call _addArrays;
private _itemCounts =+ _availableItems;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  assigned items
private _assignedItems = ((_inventory select 9) + [_inventory select 3] + [_inventory select 4]+ [_inventory select 5]);	    	//TODO add binocular batteries dont work yet
{// forEach _assignedItems - [""];
	private _item = _x;
	private _amount = 1;
	private _index = _item call jn_fnc_arsenal_itemType;

	if(_index == -1) then {
		_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
	} else {

		//TFAR fix, find base radio
		private _radioName = getText(configfile >> "CfgWeapons" >> _item >> "tf_parent");
		if!(_radioName isEqualTo "")then{
			_item =_radioName;
		};

		_hasItemPermission =  (tolower _item) in ItemsWithPermission;
		if (_hasItemPermission) then {
			if ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1) then {
				if(_item isEqualTo (_inventory select 5) )then{
					player addweapon _item;
				}else{
					player linkItem _item;
				};
			} else {
				if ([_item, _availableItems select _index] call jn_fnc_arsenal_itemCount > 0) then {
					if(_item isEqualTo (_inventory select 5) )then{
						player addweapon _item;
					}else{
						player linkItem _item;
					};
					[_arrayTaken,_index,_item,_amount]call _addToArray;
					[_availableItems,_index,_item,_amount]call _removeFromArray;
				} else {
					_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
				};
			};
		} else {
			_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
		};
		


	};
} forEach _assignedItems - [""];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// weapons and attachments
removeBackpack player;
player addBackpack "B_Carryall_oli"; //temp backpack for adding magazines to weapons
private _weapons = [_inventory select 6,_inventory select 7,_inventory select 8];
{//forEach _weapons;
	private _item = _x select 0;

	if!(_item isEqualTo "")then{
		private _itemAttachmets = _x select 1;
		private _itemMag = _x select 2;
		private _amount = 1;
		private _amountMag = getNumber (configfile >> "CfgMagazines" >> _itemMag >> "count");
		private _index = _foreachindex;
		private _indexMag = IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL;
		private _gunAdded = false;
		

		//adding the gun
		call {
			_hasItemPermission =  (tolower _item) in ItemsWithPermission;
			if (_hasItemPermission) then {
				if ((_index != -1) AND ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1)) exitWith {
					player addWeapon _item;
					_gunAdded = true;
				};

				if ((_index != -1) AND {[_item, _availableItems select _index] call jn_fnc_arsenal_itemCount > 0}) then {
					player addWeapon _item;
					_gunAdded = true;
					[_arrayTaken,_index,_item,_amount] call _addToArray;
					[_availableItems,_index,_item,_amount] call _removeFromArray;
				} else {
					_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
				};
			} else {
					_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
			};	
		};

		//add ammo to backpack, which need to be loaded in the gun.
		call {
			if (_gunAdded) then {
				
			
				_hasItemPermission =  (tolower _itemMag) in ItemsWithPermission;
				if (_hasItemPermission) then {
					if ([_itemMag, _itemCounts select _indexMag] call jn_fnc_arsenal_itemCount == -1) exitWith {
						player addMagazine [_itemMag, _amountMag];
					};

					private _amountMagAvailable = [_itemMag, _availableItems select _indexMag] call jn_fnc_arsenal_itemCount;
					if (_amountMagAvailable > 0) then {
						if (_amountMagAvailable < _amountMag) then {
							_arrayMissing = [_arrayMissing,[_itemMag,_amountMag]] call jn_fnc_common_array_add;
							_amountMag = _amountMagAvailable;
						};
					[_arrayTaken,_indexMag,_itemMag,_amountMag] call _addToArray;
					[_availableItems,_indexMag,_itemMag,_amountMag] call _removeFromArray;
					player addMagazine [_itemMag, _amountMag];
					} else {
						_arrayMissing = [_arrayMissing,[_itemMag,_amountMag]] call jn_fnc_common_array_add;
					};
				} else {
					_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
				};	
			};
		};
		//add attachments
		if (_gunAdded) then {
			{
				private _itemAcc = _x;
				if!(_itemAcc isEqualTo "")then{
					private _amountAcc = 1;
					private _indexAcc = _itemAcc call jn_fnc_arsenal_itemType;

					call {
						_hasItemPermission =  (tolower _itemAcc) in ItemsWithPermission;
						if (_hasItemPermission) then {
							if ((_indexAcc != -1) AND ([_itemAcc, _itemCounts select _indexAcc] call jn_fnc_arsenal_itemCount == -1)) exitWith {
								switch _index do{
									case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON:{player addPrimaryWeaponItem _itemAcc;};
									case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON:{player addSecondaryWeaponItem _itemAcc;};
									case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN:{player addHandgunItem _itemAcc;};
								};
							};

							if ((_indexAcc != -1) AND {[_itemAcc, _availableItems select _indexAcc] call jn_fnc_arsenal_itemCount != 0}) then {
								switch _index do{
									case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON:{player addPrimaryWeaponItem _itemAcc;};
									case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON:{player addSecondaryWeaponItem _itemAcc;};
									case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN:{player addHandgunItem _itemAcc;};
								};
								[_arrayTaken,_indexAcc,_itemAcc,_amountAcc] call _addToArray;
								[_availableItems,_indexAcc,_itemAcc,_amountAcc] call _removeFromArray;
							} else {
								_arrayMissing = [_arrayMissing,[_itemAcc,_amountAcc]] call jn_fnc_common_array_add;
							};
						} else {
							_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
						};	
					};
				};
			}foreach _itemAttachmets;
		};
	};
} forEach _weapons;
removeBackpack player;//Remove temporary backpack

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  vest, uniform and backpack
private _uniform = _inventory select 0 select 0;
private _vest = _inventory select 1 select 0;
private _backpack = _inventory select 2 select 0;

private _uniformItems = _inventory select 0 select 1;
private _vestItems = _inventory select 1 select 1;
private _backpackItems = _inventory select 2 select 1;

//add containers
private _containers = [_uniform,_vest,_backpack];
private _invCallArray = [
	{removeUniform player;player forceAddUniform _this;},//todo remove function because its done already before
    {removeVest player;player addVest _this;},
    {removeBackpackGlobal player;player addBackpack _this;}
];

{
	private _item = _x;
	if!(_item isEqualTo "")then{
		private _amount = 1;
		private _index = [
			IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,
			IDC_RSCDISPLAYARSENAL_TAB_VEST,
			IDC_RSCDISPLAYARSENAL_TAB_BACKPACK
		] select _foreachindex;
		_hasItemPermission =  (tolower _item) in ItemsWithPermission;
		if (_hasItemPermission) then {
			if ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1) then {
					_item call (_invCallArray select _foreachindex);
			}else{
				if ([_item, _availableItems select _index] call jn_fnc_arsenal_itemCount > 0) then {
					_item call (_invCallArray select _foreachindex);
					[_arrayTaken,_index,_item,_amount] call _addToArray;
					[_availableItems,_index,_item,_amount] call _removeFromArray;
				} else {
					private _oldItem = [_uniform_old,_vest_old,_backpack_old] select _foreachindex;
					if !(_oldItem isEqualTo "") then {
						_oldItem call (_invCallArray select _foreachindex);
						_arrayReplaced = [_arrayReplaced,[_item,_oldItem]] call jn_fnc_common_array_add;
						[_arrayTaken,_index,_oldItem,1] call _addToArray;
					} else {
						_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
					};
				};
			};
		} else {
			_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
		};	
	};
} forEach _containers;

//add items to containers
{
	private _container = call (_x select 0);
	private _items = _x select 1;

	{
		private _item = _x;
		private _index = _item call jn_fnc_arsenal_itemType;
		private _amount = 1;

		_hasItemPermission =  (tolower _item) in ItemsWithPermission;
		if (_hasItemPermission) then {
			if(_index == -1)then{
				private _amount = 1; // we will never know the ammo count in the magazines anymore :c
				_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
			} else {
				private _amountAvailable = [_item, _availableItems select _index] call jn_fnc_arsenal_itemCount;
				if (_index == IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL) then {
					private _amount = getNumber (configfile >> "CfgMagazines" >> _item >> "count");
					call {
						if ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1) exitWith {
							_container addMagazineAmmoCargo [_item,1, _amount];
						};

						if(_amountAvailable < _amount) then {
							_amount = _amountAvailable;
							_arrayMissing = [_arrayMissing,[_item,(_amount - _amountAvailable)]] call jn_fnc_common_array_add;
						};
						[_arrayTaken,_index,_item,_amount] call _addToArray;
						[_availableItems,_index,_item,_amount] call _removeFromArray;
						if (_amount>0) then {//prevent empty mags
							_container addMagazineAmmoCargo  [_item,1, _amount];
						};
					};
				} else {
					private _amount = 1;
					call {
						if ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1) exitWith {
							_container addItemCargo [_item, 1];
						};

						if (_amountAvailable >= _amount) then {
							_container addItemCargo [_item,_amount];
							[_arrayTaken,_index,_item,_amount] call _addToArray;
							[_availableItems,_index,_item,_amount] call _removeFromArray;
						} else {
							_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
						};
					};
				};
			};
		} else {
				_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
		};	

	} forEach _items;
} forEach [
	[{uniformContainer player},_uniformItems],
	[{vestContainer player},_vestItems],
	[{backpackContainer player},_backpackItems]
];


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  Update global
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_arrayAdd = [_arrayPlaced, _arrayTaken] call _subtractArrays; //remove items that where not added
_arrayRemove = [_arrayTaken, _arrayPlaced] call _subtractArrays;

[_object,_arrayAdd] call jn_fnc_arsenal_addItem;

[_object, _arrayRemove] call jn_fnc_arsenal_removeItem;

//create text for missing and replaced items
//we could use ingame names here but some items might not be ingame(disabled mod), but if you feel like it you can still add it.

private _reportTotal = "";
private _reportReplaced = "";
{
	private _nameNew = _x select 0;
	private _nameOld = _x select 1;

	_xCfg = _nameNew call jn_fnc_arsenal_getConfigClass;
    _isClassExist= isClass _xCfg;
    if(_isClassExist) then {
		_nameNew = gettext (_xCfg >> "displayName");
	}; 

	_xCfg = _nameOld call jn_fnc_arsenal_getConfigClass;
    _isClassExist= isClass _xCfg;
    if(_isClassExist) then {
		_nameOld = gettext (_xCfg >> "displayName");
	}; 
		
	_reportReplaced = _reportReplaced + _nameOld + " instead of " + _nameNew + "\n";

} forEach _arrayReplaced;

if!(_reportReplaced isEqualTo "")then{
	_reportTotal = ("I keep this items because i couldn't find the other ones:\n" + _reportReplaced+"\n");
};

private _reportMissing = "";
{
	private _name = _x select 0;
	private _amount = _x select 1;

	_xCfg = _name call jn_fnc_arsenal_getConfigClass;
    _isClassExist= isClass _xCfg;
    if(_isClassExist) then {
		_name = gettext (_xCfg >> "displayName");
	}; 

	_reportMissing = _reportMissing + _name + " (" + (str _amount) + "x)\n";
}forEach _arrayMissing;

private _reportNoPermission= "";
{
	private _name = _x select 0;
	private _amount = _x select 1;

	_xCfg = _name call jn_fnc_arsenal_getConfigClass;
	_isClassExist= isClass _xCfg;
	if(_isClassExist) then {
		_name = gettext (_xCfg >> "displayName");
	}; 

	_reportNoPermission = _reportNoPermission + _name + " (" + (str _amount) + "x)\n";
}forEach _arrayNoPermission;


if!(_reportMissing isEqualTo "")then{
	_reportTotal = (_reportTotal+"I couldn't find the following items:\n" + _reportMissing+"\n");
};


if!(_reportNoPermission isEqualTo "")then{
	_reportTotal = (_reportTotal+"You dont have permission to use this item \n" + _reportNoPermission+"\n");
};


if!(_reportTotal isEqualTo "")then{
	titleText[_reportTotal, "PLAIN"];
};


/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
[
	"13",
	[
		["U_BG_Guerilla2_3",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"]],
		["",[]],
		["B_Carryall_oli",["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green"]],
		"H_Beret_blk",
		"G_Bandanna_blk",
		"Binocular",
		["arifle_TRG21_F",["","","",""],""],
		["launch_I_Titan_F",["","","",""],"Titan_AA"],
		["",["","","",""],""],
		["ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles"],
		["GreekHead_A3_01","Male01GRE",""]
	]
]
*/
