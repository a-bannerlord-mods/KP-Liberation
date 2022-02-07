params ["_copyingFrom","_copyingTo"];

[[_copyingFrom,_copyingTo],"modules\mapShare\functions\scanPlayerMarkers.sqf"] remoteExec ["execVM",_copyingFrom];