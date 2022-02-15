GRLIB_enable_auto_civilian_patrol =false;
GRLIB_enable_auto_opfor_patrol=false;
GRLIB_enable_auto_random_battlegroup=false;
GRLIB_enable_auto_counter_battlegroup=false;
GRLIB_hideMarkers = true;

GRLIB_enable_training_scenario = true;

{
	sectors_forced_despawn pushBack _x;
	_x setMarkerAlpha 0; 
} forEach sectors_allSectors;

publicVariable "GRLIB_enable_auto_civilian_patrol";
publicVariable	"GRLIB_enable_auto_opfor_patrol";
publicVariable	"GRLIB_enable_auto_random_battlegroup";
publicVariable	"GRLIB_enable_auto_counter_battlegroup";
publicVariable	"GRLIB_enable_training_scenario";
publicVariable	"sectors_forced_despawn";
