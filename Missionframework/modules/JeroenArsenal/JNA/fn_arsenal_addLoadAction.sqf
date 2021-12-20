//[this,Recon_Arsenal] call  jn_fnc_arsenal_addLoadAction;

params ["_interface","_object",["_actionName","Unload From Arsenal"]];

_id = _interface addaction [
			"Unload From Arsenal",
        {
			params ["_target", "_caller", "_actionId", "_arguments"];
			_object = _arguments select 0;
			
			_script =  {
				params ["_object"];
				
				//check if player is looking at some object
				_object_selected = cursorObject;
				if(isnull _object_selected)exitWith{hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR1"; };

				//check if object is in range
				//if(_object distance cursorObject > 10)exitWith{hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR2";};

				//check if object has inventory
				_className = typeOf _object_selected;
				_tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
				_tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
				_tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
				if !(_tb > 0  || _tm > 0 || _tw > 0) exitWith{hint localize "STR_JNA_ACT_CONTAINER_SELECTERROR3";};


				//set type and object to use later
				UINamespace setVariable ["jn_type","container"];
				UINamespace setVariable ["jn_object",_object];
				UINamespace setVariable ["jn_object_selected",_object_selected];

				
				//start loading screen and timer to close it if something breaks
				["jn_fnc_arsenal", "Loading EAF Arsenal"] call bis_fnc_startloadingscreen;
				[] spawn {
					uisleep 5;
					_ids = missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]];
					if("jn_fnc_arsenal" in _ids)then{
						_display =  uiNamespace getVariable ["arsanalDisplay","No display"];
						titleText["ERROR DURING LOADING ARSENAL", "PLAIN"];
						_display closedisplay 2;
						["jn_fnc_arsenal"] call BIS_fnc_endLoadingScreen;
						if !(isnil "KPLIB_fnc_zuesLog") then {
							["Player %1 Failed to open Arsenal (For Unload)", name player] spawn KPLIB_fnc_zuesLog;
						};
					};
					
					//TODO this is a temp fix for rhs because it freezes the loading screen if no primaryWeapon was equiped. This will be fix in rhs 0.4.9
					if("bis_fnc_arsenal" in _ids)then{
						_display =  uiNamespace getVariable ["arsanalDisplay","No display"];
						diag_log "JNA: Non Fatal Error, RHS?";
						titleText["Non Fatal Error, RHS?", "PLAIN"];
						["bis_fnc_arsenal"] call BIS_fnc_endLoadingScreen;
					};

				};

				//request server to open arsenal
				[clientOwner,_object] remoteExecCall ["jn_fnc_arsenal_requestOpen",2];
			};
			_conditionActive = {
				params ["_object"];
				alive player;
			};
			_conditionColor = {
				params ["_object"];
				
				!isnull cursorObject
				//&&{
				//	_object distance cursorObject < 10;
			//	}
				&&{
					//check if object has inventory
					_className = typeOf cursorObject;
					_tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
					_tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
					_tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
					if (_tb > 0  || _tm > 0 || _tw > 0) then {true;} else {false;};
				
				}//return
			};
			
			[_script,_conditionActive,_conditionColor,_object] call jn_fnc_common_addActionSelect;
		},
        [_object],
        6,
        true,
        false,
        "",
        "alive _target && {_target distance _this < 8} && {vehicle player == player}"
			
    ];
	// nil,		// arguments
	// 1.5,		// priority
	// true,		// showWindow
	// true,		// hideOnUse
	// "",			// shortcut
	// "true", 	// condition
	// 50,			// radius
	// false,		// unconscious
	// "",			// selection
	// ""			// memoryPoint













