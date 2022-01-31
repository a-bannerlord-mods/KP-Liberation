
// TFAR
KPLIB_Enable_TFAR_compatibility = true;

KPLIB_TFAR_Default_SR_Channels =[
	["130.1","Base/FOB Communications"],
	["131.1","Infantry"],
	["132.1","Recon"],
	["133.1","Armoured"],
	["134.1","Army Alternate"],
	["135.1","Saka Fire Team"],
	["136.1","Saka Squad Team"],
	["137.1","Airforce"]
	];
	
KPLIB_TFAR_Default_LR_Channels =[
["40.1","HQ COMMAND NETWORK"],
["41.1","Airforce"],
["42.1","Infantry"],
["43.1","Recon"],
["44.1","Armoured"],
["45.1","Saka"],
["46.1","Not Used"],
["47.1","Brodcast"]
];

KPLIB_TFAR_Set_Default_Channels_Device = [
	"Land_Computer_01_black_F", 
	"Land_Computer_01_sand_F", 
	"Land_Computer_01_olive_F",
	"Vysilacka",
	"Static_Radio_Black_Off", 
	"Static_Radio_Black_1", 
	"Static_Radio_Black_2", 
	"Static_Radio_Black_3", 
	"Static_Radio_Green_Off", 
	"Static_Radio_Green_1", 
	"Static_Radio_Green_2", 
	"Static_Radio_Green_3", 
	"Static_Radio_Tan_Off", 
	"Static_Radio_Tan_1", 
	"Static_Radio_Tan_2", 
	"Static_Radio_Tan_3"];

KPLIB_classnamesToSave append KPLIB_TFAR_Set_Default_Channels_Device;

//Simplex Support Services

blufor_cas_support_required_items =["ItemcTab","Saka_tf_rt1523g_big_DES","Saka_tf_rt1523g_DES","tfw_ilbe_blade_black","tfw_ilbe_blade_mct","tfw_ilbe_blade_coy"];


//acex field rations
KPLIB_acex_field_rations_enable_Effects = true;

KPLIB_acex_field_rations_execluded_players = ["76561198028353187"];
