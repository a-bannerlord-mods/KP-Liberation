

if (isClass(configFile >> "CfgPatches" >> "SSS")) exitwith {
	sss_interaction_fnc_childactionstransportlandvehicle = compile preprocessFileLineNumbers "compatibility\simplex_support_services\fnc_childactionstransportlandvehicle.sqf";
	sss_interaction_fnc_childactionstransporthelicopter = compile preprocessFileLineNumbers "compatibility\simplex_support_services\fnc_childactionstransporthelicopter.sqf";
	sss_interaction_fnc_childactionstransportplane = compile preprocessFileLineNumbers "compatibility\simplex_support_services\fnc_childactionstransportplane.sqf";
	sss_interaction_fnc_childactionscashelicopter = compile preprocessFileLineNumbers "compatibility\simplex_support_services\fnc_childactionscashelicopter.sqf";
	add_to_support_group  = compile preprocessFileLineNumbers "compatibility\simplex_support_services\remote_call\add_to_support_group.sqf";
};
