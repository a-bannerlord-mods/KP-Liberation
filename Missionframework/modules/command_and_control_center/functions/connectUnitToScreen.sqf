
params ["_screen","_unit",["_screenIndex",0]];


_screens_feed_units = _screen getVariable ["screens_feed_units",createHashMap];

_screens_feed_units set [_screenIndex, _unit];

_screen setVariable ["screens_feed_units",_screens_feed_units,true];


[_screen] call CCC_turnOnScreen;
[_screen] remoteExec ["CCC_turnOnScreen", [0, -2] select isDedicated];