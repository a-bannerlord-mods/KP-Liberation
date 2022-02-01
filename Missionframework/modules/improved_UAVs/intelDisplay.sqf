params [
	"_uav",
	"_lockLaser","_pauseDisplay",
	"_uavPos_a","_uavPos_b","_laserPos_a","_laserPos_b","_laserDistance","_laserDirection","_intelB"
];

_uav setVariable [format["MIL_%1_IntelPaused",_uav],false];

_lockLaser = _uav addAction [
	"<t color='#88B985' shadow='2'>Lock/Unlock Laser</t>",
	{
		params [
			"","","","_uav",
			"_uavSTR"
		];
		if ((str _uav find "REMOTE") != -1) then {
			_uavSTR = [str _uav,0,((str _uav) find "REMOTE") - 2] call BIS_fnc_trimString;
			} else {
			_uavSTR = str _uav;
		};
		if (!(_uav getVariable [format["MIL_%1_LaserLocked",_uavSTR],false])) then {
			private _lockPos = getPosASL (laserTarget _uav);
			if ((_lockPos select 2) < 0) then {
				_lockPos set [2,0];
			};
			if (({cursorObject isKindOf _x} count ["LandVehicle","Ship","Air"]) > 0) then {
				_lockPos = cursorObject;
			};
			[_uav,[_lockPos,[0]]] remoteExec ["lockCameraTo",0];
			_uav setVariable ["MIL_targetCam",_lockPos,true];
			_uav setVariable [format["MIL_%1_LaserLocked",_uavSTR],true,true];
			} else {
			[_uav,[objNull,[0]]] remoteExec ["lockCameraTo",0];
			_uav setVariable ["MIL_targetCam",objNull,true];
			_uav setVariable [format["MIL_%1_LaserLocked",_uavSTR],false,true];
		};
	},
	_uav,
	1.6,
	false,
	true,
	"",
	"isLaserOn _target"
];
_pauseDisplay = _uav addAction [
	"<t color='#88B985' shadow='2'>Pause/Un-pause Laser Intel</t>",
	{
		params ["_uav"];
		if (!(_uav getVariable [format["MIL_%1_IntelPaused",_uav],false])) then {

			_uav setVariable [format["MIL_%1_IntelPaused",_uav],true];
			[
				"<t color='#ffffff' size='0.5' font='EtelkaNarrowMediumPro' align='left' shadow='0'>| |</t>",
				(safeZoneXABS + (safeZoneWABS * 0.618)), 
				(safeZoneY + (safeZoneH * 0.38)),
				99999,
				0,
				0,
				"MIL_EUAVI_PausedDisplay"
			] spawn BIS_fnc_dynamicText;

			} else {

			_uav setVariable [format["MIL_%1_IntelPaused",_uav],false];
			["",-1,-1,1,0,0,"MIL_EUAVI_PausedDisplay"] spawn BIS_fnc_dynamicText;
		};
	},
	nil,
	1.7,
	false,
	true,
	"",
	"isLaserOn _target"
];

_followTargetAction = _uav addAction [
	"<t color='#88B985' shadow='2'>Follow Target</t>",
	{
		params ["_uav"];
		if (!(_uav getVariable ["MIL_followTarget",false])) then {

			_uav setVariable ["MIL_followTarget",true,true];
			[
				"<t color='#ffffff' size='0.5' font='EtelkaNarrowMediumPro' align='left' shadow='0'>FOLLOWING TARGET</t>",
				(safeZoneXABS + (safeZoneWABS * 0.618)), 
				(safeZoneY + (safeZoneH * 0.38)),
				99999,
				0,
				0,
				"MIL_EUAVI_FollowDisplay"
			] spawn BIS_fnc_dynamicText;

			} else {

			_uav setVariable ["MIL_followTarget",false,true];
			["",-1,-1,1,0,0,"MIL_EUAVI_FollowDisplay"] spawn BIS_fnc_dynamicText;
		};
	},
	nil,
	1.7,
	false,
	true,
	"",
	"isLaserOn _target"
];

_setReferenceUnit = _uav addAction [
	"<t color='#88B985' shadow='2'>Set reference unit</t>",
	{
		params [
			"","","","_uav",
			"_uavSTR"
		];
		SUAV =_uav;
		avlplayers = (allplayers select { 
			alive _x;
		}); 

		_data = avlplayers  apply { 
		[
						[name _x],
						[],
						[
							getText(configfile >> "RscDisplayMultiplayerSetup" >> "west"),
							(configfile >> "RscDisplayMultiplayerSetup" >> "controls" >> "CA_B_West" >> "colorActive") call BIS_fnc_colorConfigToRGBA
						],
						[], 
						name _x, name _x, avlplayers find _x
					]
				
		}; 

		[
			[
				_data,
				4, // selects the quadbike by default
				false // Multi select disabled
			],
			"Unit selection",
			{
				// systemChat format["_confirmed: %1", _confirmed];
				// systemChat format["_index: %1", _index];
				// systemChat format["_data: %1", _data];
				// systemChat format["_value: %1", _value];
				if (_confirmed &&  (count avlplayers > 0)) then {
					SUAV setVariable ["MIL_UAV_Reference_unit",(avlplayers select _index),true];
				};
			},
			"", // reverts to default
			"" // reverts to default, disable cancel option
		] call CAU_UserinputMenus_fnc_listbox;
	},
	_uav,
	1.6,
	false,
	true,
	"",
	"isLaserOn _target"
];

_setTargetUnit = _uav addAction [
	"<t color='#88B985' shadow='2'>Set Target unit</t>",
	{
		params [
			"","","","_uav",
			"_uavSTR"
		];
		SUAV =_uav;
		avlplayers = (allplayers select { 
			alive _x;
		}); 

		_data = avlplayers  apply { 
		[
						[name _x],
						[],
						[
							getText(configfile >> "RscDisplayMultiplayerSetup" >> "west"),
							(configfile >> "RscDisplayMultiplayerSetup" >> "controls" >> "CA_B_West" >> "colorActive") call BIS_fnc_colorConfigToRGBA
						],
						[], 
						name _x, name _x, avlplayers find _x
					]
				
		}; 

		[
			[
				_data,
				4, // selects the quadbike by default
				false // Multi select disabled
			],
			"Unit selection",
			{
				// systemChat format["_confirmed: %1", _confirmed];
				// systemChat format["_index: %1", _index];
				// systemChat format["_data: %1", _data];
				// systemChat format["_value: %1", _value];
				if (_confirmed &&  (count avlplayers > 0)) then {
					_unit =(avlplayers select _index); 
					[SUAV,[_unit,[0]]] remoteExec ["lockCameraTo",0];
					SUAV setVariable ["MIL_targetCam",_unit,true];
					SUAV setVariable [format["MIL_%1_LaserLocked", str _uav],true,true];
				};
			},
			"", // reverts to default
			"" // reverts to default, disable cancel option
		] call CAU_UserinputMenus_fnc_listbox;
	},
	_uav,
	1.6,
	false,
	true,
	"",
	"isLaserOn _target"
];



_intelB = [_uav] spawn {
	params ["_uav","_targetObject"];
	while {true} do {
		waitUntil {isLaserOn _uav};
		if (({cursorObject isKindOf _x} count ["LandVehicle","Ship","Air"]) > 0) then {
			_targetObject = getText (configfile >> "CfgVehicles" >> typeOf cursorObject >> "displayName");
			
			[
				format["<t color='#ffffff' size='0.5' font='EtelkaMonospacePro' align='left' shadow='0'>%1</t>",_targetObject],
				(safeZoneXABS + (safeZoneWABS * 0.615)),
				(safeZoneY + (safeZoneH * 0.332)),
				11,
				0,
				0,
				"MIL_EUAVI_IntelB"
			] spawn BIS_fnc_dynamicText;
		};
		sleep 0.1;
		["",-1,-1,1,0,0,"MIL_EUAVI_IntelB"] spawn BIS_fnc_dynamicText;
	};
};

_followTargetInit  = _uav getVariable ["MIL_followTargetScript",false];
if !(_followTargetInit) then {
	_followTarget = [_uav] spawn {
	params ["_uav","_targetObject"];
	_wp = [];
	while {alive _uav} do {
			waitUntil {
				!(isNull(_uav getVariable ["MIL_targetCam",objNull])) && 
				(_uav getVariable ["MIL_followTarget",false])};
			_target = _uav getVariable ["MIL_targetCam",objNull];
			if !(isNull _target) then {
				_drone_grp = group driver _uav;
				if (
					count _wp ==0 ||
					(_target distance2D _uav) > 220 
				) then {
					while {(count (waypoints _drone_grp)) > 0} do {	deleteWaypoint ((waypoints  _drone_grp) select 0);};
					_wp = _drone_grp addWaypoint [_target, 0];
					_wp setWaypointType "MOVE";
					_wp setWaypointCompletionRadius 150;
					_wp setWaypointSpeed "LIMITED";
				};
				
				_wp setWaypointPosition [position _target, 0];
				sleep 30;
			};	
		};
	};
	_uav setVariable ["MIL_followTargetScript",true,true];
};



while {(UAVControl _uav) select 1 == "GUNNER"} do {
	waitUntil {(isLaserOn _uav) || ((UAVControl _uav) select 1 != "GUNNER")};
	if ((UAVControl _uav) select 1 != "GUNNER") exitWith {};
	_obj = laserTarget _uav;
	_ref = _uav getVariable ["MIL_UAV_Reference_unit",_uav];
	_uavPos_a = [(mapGridPosition (getPosASL _uav)),0,((count (mapGridPosition (getPosASL _uav)))/2) - 1] call BIS_fnc_trimString;
	_uavPos_b = [(mapGridPosition (getPosASL _uav)),(count (mapGridPosition (getPosASL _uav)))/2,(count (mapGridPosition (getPosASL _uav))) - 1] call BIS_fnc_trimString;
	_laserPos_a = [(mapGridPosition (_obj)),0,((count (mapGridPosition (_obj)))/2) - 1] call BIS_fnc_trimString;
	_laserPos_b = [(mapGridPosition (_obj)),(count (mapGridPosition (_obj)))/2,(count (mapGridPosition (_obj))) - 1] call BIS_fnc_trimString;
	_laserDistance = round (_ref distance2D (_obj));
	_laserDirection = round (_ref getDir (_obj));
	_refName = "UAV";
	if (_ref!=_uav) then {
		_refName =toUpper (name _ref);
	};
	[
		format["<t color='#ffffff' size='0.5' font='EtelkaMonospacePro' align='left' shadow='0'>UAV<br/>GRID: %1 %2<br/><br/>LASER<br/>GRID: %3 %4<br/>FROM %7<br/>DISTANCE: %5m<br/>DIRECTION: %6</t>",
			_uavPos_a,_uavPos_b,_laserPos_a,_laserPos_b,_laserDistance,_laserDirection,_refName
		],
		(safeZoneXABS + (safeZoneWABS * 0.618)), 
		(safeZoneY + (safeZoneH * 0.4175)),
		99999,
		0,
		0,
		"MIL_EUAVI_IntelA"
	] spawn BIS_fnc_dynamicText;

	if (_uav getVariable (format["MIL_%1_IntelPaused",_uav])) then {
		["",-1,-1,1,0,0,"MIL_EUAVI_IntelA"] spawn BIS_fnc_dynamicText;
		waitUntil {
			!(_uav getVariable (format["MIL_%1_IntelPaused",_uav])) ||
			((UAVControl _uav) select 1 != "GUNNER")
		};
		} else {
		sleep 0.1;
	};
	//["",-1,-1,1,0,0,"MIL_EUAVI_IntelA"] spawn BIS_fnc_dynamicText;
};

["",-1,-1,1,0,0,"MIL_EUAVI_IntelA"] spawn BIS_fnc_dynamicText;

MIL_EUAVI_ConnectedUAVs = MIL_EUAVI_ConnectedUAVs - [_uav];
publicVariable "MIL_EUAVI_ConnectedUAVs";

{
	_uav removeAction _x;
} forEach [
	_lockLaser,
	_pauseDisplay,
	_setReferenceUnit,
	_setTargetUnit,
	_followTargetAction
];
["",-1,-1,1,0,0,"MIL_EUAVI_IntelA"] spawn BIS_fnc_dynamicText;
["",-1,-1,1,0,0,"MIL_EUAVI_PausedDisplay"] spawn BIS_fnc_dynamicText;
["",-1,-1,1,0,0,"MIL_EUAVI_FollowDisplay"] spawn BIS_fnc_dynamicText;
terminate _intelB;
_uav setVariable [format["MIL_%1_IntelPaused",_uav],false];
