params ["_copyingFrom","_copyingTo"];

if (isplayer _copyingFrom) then {
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
  [[_copyingTo,_markerDataList],"modules\mapShare\functions\loadPlayerMarkers.sqf"] remoteExec ["execVM",_copyingTo];
} else {
  _markerDataList = _copyingFrom getVariable ["markers",[]];
  [[_copyingTo,_markerDataList],"modules\mapShare\functions\loadPlayerMarkers.sqf"] remoteExec ["execVM",_copyingTo];
};
