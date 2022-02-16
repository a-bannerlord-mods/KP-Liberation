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
"UK3CB_TKM_I_AA", 
"UK3CB_TKM_I_AT", 
"UK3CB_TKM_I_AR", 
"UK3CB_TKM_I_ENG", 
"UK3CB_TKM_I_GL", 
"UK3CB_TKM_I_IED", 
"UK3CB_TKM_I_LAT", 
"UK3CB_TKM_I_SNI", 
"UK3CB_TKM_I_WAR", 
"UK3CB_TKM_I_RIF_1"
];


// Armed vehicles
KP_liberation_guerilla_vehicles = [
    "UK3CB_ADA_B_T55", 
    "UK3CB_ADA_B_T34", 
    "UK3CB_TKM_I_Hilux_Dshkm", 
    "UK3CB_TKM_I_Pickup_M2", 
    "UK3CB_TKM_I_YAVA", 
    "UK3CB_TKM_I_Datsun_Pkm"
];

/* Guerilla Equipment
There are 3 tiers for every category. If the strength of the guerillas will increase, they'll have higher tier equipment. */

/* Weapons - You've to add the weapons as array like
["Weaponclassname","Magazineclassname","magazine amount","optic","tripod"]
You can leave optic and tripod empty with "" */
KP_liberation_guerilla_weapons_1 = [

];

KP_liberation_guerilla_weapons_2 = [

];

KP_liberation_guerilla_weapons_3 = [

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
