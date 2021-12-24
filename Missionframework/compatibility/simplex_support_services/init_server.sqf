

if (isClass(configFile >> "CfgPatches" >> "SSS")) exitwith {
	sss_add_cas_helicopter_support = compile preprocessFileLineNumbers "compatibility\simplex_support_services\add_cas_helicopter_support.sqf";
	sss_add_transport_support = compile preprocessFileLineNumbers "compatibility\simplex_support_services\add_transport_support.sqf";
};