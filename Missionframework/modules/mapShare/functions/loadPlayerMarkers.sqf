params ["_copyingTo","_markerDataList"];

if ('ItemMap' in (assignedItems _copyingTo) || 'vn_b_item_map' in (assignedItems _copyingTo) || 'vn_o_item_map' in (assignedItems _copyingTo)) then {
{
_x call mapShare_fnc_stringToMarker;
} forEach _markerDataList;
hint "Map markers copied onto your map";
} else {
hint "You have no map to copy to!";
};