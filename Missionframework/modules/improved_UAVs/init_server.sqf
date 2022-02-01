
MIL_fnc_EUAVI_Display = compileFinal preprocessFileLineNumbers "modules\improved_UAVs\intelDisplay.sqf";
publicVariable "MIL_fnc_EUAVI_Display";

nul = [] spawn {
	MIL_EUAVI_ConnectedUAVs = [];
	publicVariable "MIL_EUAVI_ConnectedUAVs";
	while {true} do {
		sleep 3;
		
		private _allUAVs = allUnitsUAV;
		{
			if (((UAVControl _x select 1) == "GUNNER") && !(_x in MIL_EUAVI_ConnectedUAVs)) then {
				MIL_EUAVI_ConnectedUAVs pushBack _x;
				publicVariable "MIL_EUAVI_ConnectedUAVs";
				
				[_x] remoteExec ["MIL_fnc_EUAVI_Display",UAVControl _x select 0];
			};
		} forEach _allUAVs;
	};
};