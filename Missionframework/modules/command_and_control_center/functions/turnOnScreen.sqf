
/* create render surface */ 
params ["_screen"];

_screens_feed_units = _screen getVariable ["screens_feed_units",createHashMap];

{
	_screenIndex = _x;
	_unit = _y;
	_cam = _screen getVariable [("live_feed_cam" + str _screenIndex) ,objNull];
	//_textureName = _screen getVariable [("live_feed_texture" + str _screenIndex) ,("_unitrtt" + (str random 999999999))];
	_textureName= "_unitrtt" + (str random 999999999);
	_screen setObjectTexture [_screenIndex, "#(argb,512,512,1)r2t("+_textureName+",1)"]; 
	if (isNull _cam) then {
		
		_cam = "camera" camCreate [0,0,0]; 
						
		_screen setVariable [("live_feed_cam" + str _screenIndex) ,_cam];
		
		if (_unit isKindOf "man") then {	
			_screen setVariable [("live_feed_cam_zoom" + str _screenIndex) ,1];
		}else{	
			_screen setVariable [("live_feed_cam_zoom" + str _screenIndex) ,0.2];
		};

		addMissionEventHandler ["Draw3D", {
			_screen  = _thisArgs select 0;
			_screenIndex = _thisArgs select 1;
			_cam = _screen getVariable [("live_feed_cam" + str _screenIndex) ,objNull];
			_unit = _screen getVariable [("live_feed_unit" + str _screenIndex) ,objNull];
			
			if (!(isnull _unit) && !( _unit isKindOf "man")) then {
				_dir = 
					(_unit selectionPosition "PiP0_pos") 
						vectorFromTo 
					(_unit selectionPosition "PiP0_dir");
				_cam setVectorDirAndUp [
					_dir, 
					_dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]
				];
			};
		},[_screen,_screenIndex]];

	};
	_cam cameraEffect["internal", "back", _textureName];
	_textureName setPiPEffect[0];
	_screen setVariable [("live_feed_unit" + str _screenIndex) ,_unit];
	_screen setVariable [("live_feed_texture" + str _screenIndex) ,_textureName];
	
	if (_unit isKindOf "man") then {

		/* create _unit and make it fly */ 
		_targetobject = "Sign_Sphere100cm_F" createVehicleLocal[0, 0, 0];
		hideObject _targetobject;
		_cam camSetTarget _targetobject;

		_cam attachTo[_unit, [0, 0.25, 0.05], "neck"];
		_targetobject attachTo[_unit, [0, 10, 0.05], "neck"];

		/* make it zoom in a little */ 
	}else{

		/* attach cam to gunner cam position */
		_cam attachTo [_unit, [0,0,0], "PiP0_pos"];

		_cam camSetTarget objNull;
		

		

	};

	_z = _screen getVariable [("live_feed_cam_zoom" + str _screenIndex) ,1];
	_cam camSetFov _z;
	_cam camcommit 0;

} forEach _screens_feed_units;




