if(missionNamespace getVariable ["r0ed_SurvivableCrashes_Initialized", false]) exitWith {};

[	true,  // Mod Enabled
	true,   //VFX
	true,   //SFX
	true,   // Exag FX
	"AUTO", // Med Sys
	1,      // dmg Multi
	["Air"],// Veh whitelist
	{},     // On Crash Code
	{},     // crew Post Crash code
	{       // veh post crash code
		params["_veh"];
		sleep (40 );
		_veh allowDamage true;
	}
] call compile preprocessFileLineNumbers "modules\r0ed_SurvivableCrashes\functions\init\init_survivableCrashes.sqf"