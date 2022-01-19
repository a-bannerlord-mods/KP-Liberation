// Scripts
// Logistic convoy ambush
logistic_convoy_ambush = compile preprocessFileLineNumbers "scripts\server\asymmetric\convoy\logistic_convoy_ambush.sqf";
// IED spawner for blufor sectors
manage_asymIED = compile preprocessFileLineNumbers "scripts\server\asymmetric\ied\manage_asymIED.sqf";
// Spawner for guerilla ambushes in blufor sectors
asym_sector_ambush = compile preprocessFileLineNumbers "scripts\server\asymmetric\random\asym_sector_ambush.sqf";
// Spawner for guerilla forces who join a fight at an opfor sector
sector_guerilla = compile preprocessFileLineNumbers "scripts\server\asymmetric\random\sector_guerilla.sqf";

suicide_bomber = compile preprocessFileLineNumbers "scripts\server\asymmetric\suicide_bomber\suicide_bomber.sqf";

// Globals
// List sectors which are just liberated. Preventing direct ambush spawn.
asymm_blocked_sectors = [];
publicVariable "asymm_blocked_sectors";

// Start module loop
execVM "scripts\server\asymmetric\asymmetric_loop.sqf";
