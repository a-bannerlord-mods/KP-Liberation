/*
    Needed Mods:
    - RHS USAF
    - RHS AFRF
    - Project OPFOR

    Optional Mods:
    - None
*/
guerilla_flag_texture = "USP_flags\data\africa\flag_libya_co.paa";
/* Classnames of the guerilla faction which is friendly or hostile, depending on the civil reputation
Standard loadout of the units will be replaced with a scripted one, which depends on the guerilla strength, after spawn */
KP_liberation_guerilla_units = [
"UK3CB_ADA_B_ENG", 
"UK3CB_ADA_B_AA", 
"UK3CB_ADA_B_GL", 
"UK3CB_ADA_B_MG", 
"UK3CB_ADA_B_LAT", 
"UK3CB_ADA_B_SL", 
"UK3CB_ADA_B_TL", 
"UK3CB_ADA_B_MD"
];

// Armed vehicles
KP_liberation_guerilla_vehicles = [
    "UK3CB_ADA_B_T55", 
"UK3CB_ADA_B_T34", 
"UK3CB_ADA_B_BRDM2", 
"UK3CB_ADA_B_LR_M2"
];

/* Guerilla Equipment
There are 3 tiers for every category. If the strength of the guerillas will increase, they'll have higher tier equipment. */

/* Weapons - You've to add the weapons as array like
["Weaponclassname","Magazineclassname","magazine amount","optic","tripod"]
You can leave optic and tripod empty with "" */
KP_liberation_guerilla_weapons_1 = [
    ["rhs_weap_ak74","rhs_30rnd_545x39_AK",4,"",""],
    ["rhs_weap_aks74u","rhs_30rnd_545x39_AK",4,"",""],
    ["LOP_Weap_LeeEnfield","LOP_10rnd_77mm_mag",3,"",""]
];

KP_liberation_guerilla_weapons_2 = [
    ["rhs_weap_ak74","rhs_30rnd_545x39_AK",4,"",""],
    ["rhs_weap_akm","rhs_30rnd_762x39mm",4,"",""],
    ["rhs_weap_akms","rhs_30rnd_762x39mm",4,"",""],
    ["rhs_weap_aks74u","rhs_30rnd_545x39_AK",4,"",""],
    ["rhs_weap_pp2000","rhs_mag_9x19mm_7n21_20",5,"optic_ACO_grn_smg",""],
    ["LOP_Weap_LeeEnfield_railed","LOP_10rnd_77mm_mag",3,"optic_ACO_grn",""]
];

KP_liberation_guerilla_weapons_3 = [
    ["rhs_weap_ak103","rhs_30rnd_762x39mm",4,"",""],
    ["rhs_weap_ak104","rhs_30rnd_762x39mm",4,"",""],
    ["rhs_weap_ak105","rhs_30rnd_545x39_AK",4,"rhs_acc_ekp1",""],
    ["rhs_weap_pkm","rhs_100Rnd_762x54mmR",2,"",""],
    ["rhs_weap_aks74un","rhs_30rnd_545x39_AK",4,"rhs_acc_ekp8_02",""],
    ["LOP_Weap_LeeEnfield_railed","LOP_10rnd_77mm_mag",3,"optic_MRCO",""]
];

// Uniforms
KP_liberation_guerilla_uniforms_1 = [

];

KP_liberation_guerilla_uniforms_2 = [

];

KP_liberation_guerilla_uniforms_3 = [

];

// Vests
KP_liberation_guerilla_vests_1 = [

];

KP_liberation_guerilla_vests_2 = [

];

KP_liberation_guerilla_vests_3 = [

];

// Headgear
KP_liberation_guerilla_headgear_1 = [

];

KP_liberation_guerilla_headgear_2 = [

];

KP_liberation_guerilla_headgear_3 = [

];

// Facegear. Applies for tier 2 and 3.
KP_liberation_guerilla_facegear = [
    ""
];
