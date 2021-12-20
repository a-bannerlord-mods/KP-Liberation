// [_item] call call jn_fnc_arsenal_hasItemPermission;
params ["_item"];

if(_item in [
"Binocular","ItemWatch","ItemCompass","tf_anprc152","ItemMap","ItemGPS",
//items
"ACE_Fortify","ACE_EntrenchingTool","eaf_beef_can","eaf_foul_can","eaf_fig_jam","eaf_water_bottle","ACE_Canteen","ACE_Flashlight_MX991","ACE_rope12","ACE_rope15","ACE_rope27","ACE_rope36","ACE_rope18","ACE_EarPlugs",
//headgear
"eaf_recon_patrolcap","eaf_cav_patrolcap","eaf_inf_patrolcap","eaf_metal_helmet","eaf_camo_helmet"
])exitwith {true};


_isMedic = player getUnitTrait "Medic";
_isEngineer = player getUnitTrait "Engineer";
_isAntitank = player getUnitTrait "Antitank";
_isMarksman = player getUnitTrait "Marksman";
_isAutorifleman = player getUnitTrait "Autorifleman";
_isDroneOperator = player getUnitTrait "DroneOperator";
_isJTAC = player getUnitTrait "JTAC ";


_isOfficer = player getUnitTrait "Officer";

true