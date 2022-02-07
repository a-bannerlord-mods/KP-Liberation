mapShare_fnc_stringToMarker= compile preprocessFileLineNumbers "modules\mapShare\functions\fn_stringToMarker.sqf";
mapShare_fnc_copyPlayer = compile preprocessFileLineNumbers "modules\mapShare\functions\fn_copyPlayer.sqf";
mapShare_fnc_copyRadius = compile preprocessFileLineNumbers "modules\mapShare\functions\fn_copyRadius.sqf";
mapShare_fnc_markerToString = compile preprocessFileLineNumbers "modules\mapShare\functions\fn_markerToString.sqf";

_conditionCopyMap = {
	(('ItemMap' in (assignedItems _target) || 'vn_b_item_map' in (assignedItems _target) || 'vn_o_item_map' in (assignedItems _target)))
};
_statementCopyMap = {
    [_target,_player] call mapShare_fnc_copyPlayer;
};

_action = ["CopyMapMarkers","Copy Map Markers","eaf_factions\data\icon_map.paa",_statementCopyMap,_conditionCopyMap] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;