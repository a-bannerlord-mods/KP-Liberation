params ["_screen",["_screenIndex",0]];
live_feed_cam = _screen getVariable [("live_feed_cam" + str _screenIndex) ,objNull];
live_feed_cam_zoom = _screen getVariable [("live_feed_cam_zoom" + str _screenIndex) ,1];
fScreenIndex = _screenIndex;

if !(isnull live_feed_cam) then {
[
    [
        [1,100],
        (1/live_feed_cam_zoom),
        [1,1]
    ],
    "Set charge timer",
    {format["%1X",(round _position)]},
    {
        if _confirmed then {
			live_feed_cam camSetFov  (1/_position);
            _screen setVariable [("live_feed_cam_zoom" + str  (1/_position)) ,1];
            live_feed_cam camcommit 0;
        };
    },
    "Set Zoom",
    "Abort"
] call CAU_UserInputMenus_fnc_slider;

};
