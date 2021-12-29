/*
	Function: HALs_store_fnc_addTrader
	Author: HallyG
	Initialises a trader.

	Argument(s):
	0: Trader object <OBJECT>
	1: Trader type <STRING>
	2: Trader target (Default: 0) <ARRAY, GROUP, NUMBER, OBJECT, SIDE, STRING>
		The trader is avaliable to all of these targets.

	Return Value:
	<BOOLEAN>

	Example:
	[obj2, "Navigation"] call HALs_store_fnc_addTrader;
__________________________________________________________________*/
params [
	["_trader", objNull, [objNull]],
	["_traderType", "", [""]],
	["_target", 0, [0, objNull, "", sideUnknown, grpNull, []]]
];

if (!isServer) exitWith {false};

try {
	if (!isNil {_trader getVariable "HALs_store_trader_type"}) then {throw ["Trader already initialised"]};
	if (isNull _trader) then {throw ["Trader cannot be null"]};
	if (!alive _trader) then {throw ["Trader cannot be dead"]};
	if (isPlayer _trader) then {throw ["Trader cannot be a player"]};
	if (_traderType isEqualTo "") then {throw ["No Trader type"]};
	if (!isClass (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType)) then {throw ["Invalid Trader type"]};

   	private _categories = getArray (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType >> "categories");
	private _classes = [];
	private _stocks = [];
	{
		private _category = _x;
		_configCategory = missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _category;
		_items = "true" configClasses (_configCategory) apply {[configName _x, _x >>"price" ]};

		{
				if !((_x select 0) in _items) then {
						if ((_x select 1) == _category ) then {
							_items pushback [(_x select 0),(_x select 3)];
						};
					};
		} forEach GRLIB_arsenal_all;

		_items = [_items,{_x select 1},true] call HALs_fnc_sortArray;
		_items =  _items apply {_x select 0};
		
		_duplicateClass = {_classes find _x > -1} count _items > 0;
		_duplicateItem = !(count (_items arrayIntersect _items) isEqualTo count _items);
		if (_duplicateClass || _duplicateItem) then {
			throw [format ["Duplicate items  [category: %1, type: %2]", toUpper _x, toUpper _traderType]];
		};

		{
			_classes pushBack _x;
			_stocks pushBack toLower _x;
			_stocks pushBack 1000000000;
		} forEach _items;
	} forEach _categories;

	_trader setVariable ["HALs_store_trader_type", _traderType, true];
	_trader setVariable ["HALs_store_trader_stocks", _stocks, true];

	if !(typeOf _trader isKindOf ["CAManBase", configFile >> "cfgVehicles"]) then {
		clearMagazineCargoGlobal _trader;
		clearWeaponCargoGlobal _trader;
		clearItemCargoGlobal _trader;
		clearBackpackCargoGlobal _trader;
	};

	_trader setVariable ["HALs_store_name", getText (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _traderType >> "displayName"), true];
	[_trader, _target] call HALs_store_fnc_addActionTrader;
	true
} catch {
	[_exception] call HALs_fnc_log;
	[_exception select 0] call BIS_fnc_error;
	false
};
