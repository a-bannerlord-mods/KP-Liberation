#include "defineCommon.inc"

params[["_object",objNull]]; 
if (isNull _object) then {
    _object = uiNamespace getVariable "jn_object";
};  


//items that need to be removed from arsenal
pr _arrayPlaced = EMPTY_ARRAY;
pr _arrayTaken = EMPTY_ARRAY;
pr _arrayMissing = [];
pr _arrayNoPermission = [];
pr _arrayReplaced = [];

    
pr  _addToArray = {
	params ["_array","_index","_item","_amount"];

	if(_index != -1 && !(_item isEqualTo "") && _amount != 0)then{
		_array set [_index,[_array select _index,[_item,_amount]] call jn_fnc_common_array_add];
	};
};


pr _removeFromArray = {
	params ["_array","_index","_item","_amount"];

	if(_index != -1 && !(_item isEqualTo "") && _amount != 0)then{
		_array set [_index,[_array select _index,[_item,_amount]] call jn_fnc_common_array_remove];
	};
};

pr _addArrays = {
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

pr _subtractArrays = {
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
 hint "Loading Default Gear For Rifleman step 1";


pr _dataList = _object getVariable "jna_dataList";


pr _loadoutTemplate = player getVariable ["loadout_template",[]];
if (count _loadoutTemplate > 1) then {
	
 
pr _inventory  =  _loadoutTemplate;

pr _availableItems = [_dataList, _arrayPlaced] call _addArrays;
pr _itemCounts =+ _availableItems;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  vest, uniform and backpack
pr _uniform = _inventory select 0 select 0;
pr _vest = _inventory select 1 select 0;
pr _backpack = _inventory select 2 select 0;

pr _uniformItems = _inventory select 0 select 1;
pr _vestItems = _inventory select 1 select 1;
pr _backpackItems = _inventory select 2 select 1;


//add items to containers
{
	pr _container = call (_x select 0);
	pr _items = _x select 1;

	{
		pr _item = _x;
		pr _index = _item call jn_fnc_arsenal_itemType;

		if(_index == -1)then{
			pr _amount = 1; // we will never know the ammo count in the magazines anymore :c
			_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
		} else {
			pr _amountAvailable = [_item, _availableItems select _index] call jn_fnc_arsenal_itemCount;            
			// if (_index == IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL) then {
			// 	pr _amount = getNumber (configfile >> "CfgMagazines" >> _item >> "count");
			
            //     pr _cargoAmount = 0;
			// 	{
			// 		if ((_x select 0 ==_item )) then {					
			// 			_cargoAmount =_cargoAmount + (_x select 1);
			// 		// _cargoAmount =_cargoAmount + getNumber (configfile >> "CfgMagazines" >> _x >> "count");
			// 		};				
	

			// 	 systemChat str magazinesAmmoCargo _container;
		    //      systemChat _item;		
            //      systemChat str _cargoAmount;
            //      systemChat str ({_x == _item} count (_items));

            //     if (_cargoAmount >= {_x == _item} count (_items)  ) then {
			// 		_amount=0;
			// 	};

			// 	call {
			// 		if ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1) exitWith {
			// 			_container addMagazineAmmoCargo [_item,1, _amount];
			// 		};

			// 		if(_amountAvailable < _amount) then {
			// 			_amount = _amountAvailable;
			// 			_arrayMissing = [_arrayMissing,[_item,(_amount - _amountAvailable)]] call jn_fnc_common_array_add;
			// 		};
			// 		[_arrayTaken,_index,_item,_amount] call _addToArray;
			// 		[_availableItems,_index,_item,_amount] call _removeFromArray;
			// 		if (_amount>0) then {//prevent empty mags
			// 			_container addMagazineAmmoCargo  [_item,1, _amount];
			// 		};
			// 	};
			// } else {
				
				pr _amount = 1;
				pr _playerInvCount = ({_x == _item} count (items player));
				if (_playerInvCount ==0 ) then {
					 _playerInvCount = {_x == _item} count (itemsWithMagazines  player);
				};
				if (_playerInvCount>= {_x == _item} count (_items)  ) then {
					_amount=0;
				};
				call {

                  _hasItemPermission =  [_item] call  jn_fnc_arsenal_hasItemPermission;
     if (_hasItemPermission) then {
		if ([_item, _itemCounts select _index] call jn_fnc_arsenal_itemCount == -1) exitWith {
						if (_container canAdd [_item, 1]) then {
                      	_container addItemCargo [_item, 1];
                             };					
					};

					if (_amountAvailable >= _amount) then {
                        if (_container canAdd [_item, 1]) then {
						_container addItemCargo [_item,_amount];
						[_arrayTaken,_index,_item,_amount] call _addToArray;
						[_availableItems,_index,_item,_amount] call _removeFromArray;
							 };
					  } else {
						_arrayMissing = [_arrayMissing,[_item,_amount]] call jn_fnc_common_array_add;
					};
        } else {
		_arrayNoPermission = [_arrayNoPermission,[_item,_amount]] call jn_fnc_common_array_add;
         };
				

				};
			//};
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

pr _reportTotal = "";
pr _reportReplaced = "";
{
	pr _nameNew = _x select 0;
	pr _nameOld = _x select 1;

	_type =_nameOld call jn_fnc_arsenal_itemType;
	_xCfg = switch _type do {
            case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK:    {configfile >> "cfgvehicles"    >> _item};
            case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES:     {configfile >> "cfgglasses"     >> _item};
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG;
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL;
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW;
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT:    {configfile >> "cfgmagazines"   >> _item};
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC:   {configfile >> "cfgweapons"     >> _item};
            default                                     {configfile >> "cfgweapons"     >> _item};
        };
        _isClassExist= isClass _xCfg;
        if(_isClassExist) then {
			_nameOld = gettext (_xCfg >> "displayName");
		}; 

	_reportReplaced = _reportReplaced + _nameOld + " instead of " + _nameNew + "\n";
} forEach _arrayReplaced;

if!(_reportReplaced isEqualTo "")then{
	_reportTotal = ("I keep this items because i couldn't find the other ones:\n" + _reportReplaced+"\n");
};

pr _reportMissing = "";
{
	pr _name = _x select 0;
	pr _amount = _x select 1;

	_xCfg = _name call jn_fnc_arsenal_getConfigClass;
    _isClassExist= isClass _xCfg;
    if(_isClassExist) then {
		_name = gettext (_xCfg >> "displayName");
	}; 

	_reportMissing = _reportMissing + _name + " (" + (str _amount) + "x)\n";
}forEach _arrayMissing;


pr _reportNoPermission= "";
{
	pr _name = _x select 0;
	pr _amount = _x select 1;

	_type =_item call jn_fnc_arsenal_itemType;
	_xCfg = switch _type do {
            case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK:    {configfile >> "cfgvehicles"    >> _item};
            case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES:     {configfile >> "cfgglasses"     >> _item};
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG;
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL;
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW;
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT:    {configfile >> "cfgmagazines"   >> _item};
            case IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC:   {configfile >> "cfgweapons"     >> _item};
            default                                     {configfile >> "cfgweapons"     >> _item};
        };
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
}
