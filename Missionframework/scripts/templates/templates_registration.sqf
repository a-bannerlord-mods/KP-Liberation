
register_Template={
	params ["_filename","_id"];
	_temp = ([] call (compile preprocessFileLineNumbers  format ["scripts\templates\%1.sqf",_filename]));
	GRLIB_Templates set [_id,_temp];
};

GRLIB_Templates = createHashMap;


["blufor_templates\blufor_road_guard_post",	"blufor_road_guard_post"] call register_Template; 

["opfor_templates\camp_light_artillery_1","camp_light_artillery_1"] call register_Template; 
["opfor_templates\camp_light_artillery_2","camp_light_artillery_2"] call register_Template; 
["opfor_templates\camp_light_artillery_3","camp_light_artillery_3"] call register_Template; 
["opfor_templates\camp_light_artillery_4","camp_light_artillery_4"] call register_Template; 

SpawnTemplate = {
	params ["_id","_pos","_dir"];
	_data = GRLIB_Templates get _id;
	[_data select 1,_pos, _dir, _data select 2 ,_data select 3,_data select 4]  call KPLIB_fnc_spawnTemplate;
};