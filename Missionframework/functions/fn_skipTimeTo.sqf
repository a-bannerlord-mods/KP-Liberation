params [["_time",0]];

if (isserver) then {
	_timetoSkip = ((_time - dayTime + 24) % 24);

	[["Time is passing", "BLACK OUT", 1.2]] remoteExec ["titleText", [0, -2] select isDedicated ];
	sleep 2;
	skipTime _timetoSkip;
	sleep 2;

	[["", "BLACK IN", 1.2]] remoteExec ["titleText", [0, -2] select isDedicated ];

	combat_readiness = combat_readiness + _timetoSkip/2;
	[] call KPLIB_fnc_combatReadinessUpdated;
	publicVariable "combat_readiness";
};
