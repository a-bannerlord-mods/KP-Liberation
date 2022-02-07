params ["_copyingFrom"];

_markerDataList = []; 
{  
  private "_a";  
  _a = toArray _x; 
  _a resize 15; 
  if (toString _a == "_USER_DEFINED #") then { 
	_saveInfo = _x call mapShare_fnc_markerToString;
	_markerDataList pushBack _saveInfo;  
	};  
} forEach allMapMarkers; 

_friendlyPlayers = allPlayers select { !( _x isEqualTo player ) && { side group _x isEqualTo playerSide } && ('ItemMap' in (assignedItems _x) || 'vn_b_item_map' in (assignedItems _x) || 'vn_o_item_map' in (assignedItems _x)) && !((_x distance player) > 50)};
if !( _friendlyPlayers isEqualTo [] ) then {
{
[[_x,_markerDataList],"modules\mapShare\functions\loadPlayerMarkers.sqf"] remoteExec ["execVM",_x];
} forEach _friendlyPlayers;
};
hint "Map data copied to nearby players of the same side.";