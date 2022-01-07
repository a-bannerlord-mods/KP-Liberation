GRLIB_default_uniform = "eaf_full_private_inf_uniform";
GRLIB_default_loadout = [["eaf_full_private_inf_uniform",["ACE_EntrenchingTool","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_quikclot","ACE_splint","ACE_splint","ACE_splint","ACE_tourniquet","ACE_tourniquet","ACE_EarPlugs","ACE_CableTie","ACE_CableTie","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage","ACE_packingBandage"]],["rhsusf_mbav_rifleman",["eaf_beef_can","eaf_foul_can","eaf_foul_can","eaf_fig_jam","eaf_fig_jam","eaf_water_bottle","ACE_Canteen","rhs_30Rnd_762x39mm","rhs_30Rnd_762x39mm","rhs_30Rnd_762x39mm","rhs_30Rnd_762x39mm","rhs_30Rnd_762x39mm","rhs_30Rnd_762x39mm","rhs_30Rnd_762x39mm","SmokeShell","SmokeShell","SmokeShell","ACE_M84","HandGrenade"]],["",[]],"eaf_metal_helmet","","Binocular",["uk3cb_ak47n",["rhs_acc_dtkakm","rhs_acc_2dpZenit","rhs_acc_ekp8_02",""],"rhs_30Rnd_762x39mm"],["",["","","",""],""],["",["","","",""],""],["ItemMap","ItemCompass","ItemWatch","tf_anprc152_4","ItemGPS"],["WhiteHead_17","ace_novoice",""]];
// [Classname,catagory",[array of permitted qualifications],cost (-1 for autocost),initial amount (-1 for infinite),auto add magazine, auto add attachment]
// ["UK3CB_BAF_AT4_CS_AP_Launcher","Weapons",["Antitank"],000,-1,true,true]
GRLIB_arsenal_weapons_primary = [
    ["rhs_weap_akms", "assultRifle", ["Rifleman"], 22, 50, true, true], //AKMS
    ["uk3cb_ak47n", "assultRifle", ["Rifleman"], 20, 50, true, true], //AK-47N
    ["rhs_weap_akm_zenitco01_b33", "assultRifle", ["Rifleman"], 50, 20, true, true],
    ["rhs_weap_akmn_gp25_npz", "assultRifle", ["GL"], 70, 10, true, true],
    ["rhs_weap_ak103_zenitco01_b33", "assultRifle", ["Rifleman"], 70, 5, true, true], //AK-103 (Zenitco/B-33)
    ["rhs_weap_ak103_gp25_npz", "assultRifle", ["GL"], 80, 5, true, true], //AK-103 (GP-25/B-13)
    ["rhs_weap_ak104_zenitco01_b33", "assultRifle", ["Rifleman"], 40, 10, true, true], //AK-104 (Zenitco/B-33)
    ["rhs_weap_m4a1", "assultRifle", ["Rifleman"], 40, 10, true, true], //M4A1 PIP
    ["drg_arx160", "assultRifle", ["Rifleman"], 60, 30, true, true], //Beretta ARX160A1
    ["drg_arx160_gls", "assultRifle", ["GL"], 70, 10, true, true], //Beretta ARX160A1 GL
    ["JAS_SIG516_14_5_CTR_Tan", "assultRifle", ["Rifleman"], 100, 0, true, true], //SIG516 14.5inch Tactical Patrol CTR Stock(Tan)
    ["UK3CB_MP5N_UGL", "smgs", ["GL"], 50, 15, true, true], //HK MP5N UGL
    ["UK3CB_MP5N", "smgs", ["Rifleman"], 30, 5, true, true], //HK MP5N
    ["rhsusf_weap_MP7A2_grip3", "smgs", ["Rifleman"], 40, 10, true, true], //MP7A2
    // ["rhs_weap_hk416d10", "smgs", ["Rifleman"], -1, -1, true, true],
    // ["rhs_weap_hk416d10_m320", "smgs", ["Rifleman"], -1, -1, true, true],
    // ["rhs_weap_hk416d10_LMT", "smgs", ["Rifleman"], -1, -1, true, true],
    // ["rhs_weap_hk416d10_LMT_d", "smgs", ["Rifleman"], -1, -1, true, true],
    // ["rhs_weap_hk416d145", "smgs", ["Rifleman"], -1, -1, true, true],
    // ["rhs_weap_hk416d145_d", "smgs", ["Rifleman"], -1, -1, true, true],
    // ["rhs_weap_hk416d145_d_2", "smgs", ["Rifleman"], -1, -1, true, true],
    ["UK3CB_SVD_OLD_NPZ", "dmr", ["Marksman"], 30, 30, true, true], //SVD NPZ
    ["rhs_weap_svds_npz", "dmr", ["Marksman"], 35, 30, true, true], //SVDS (NPZ)
    ["rhs_weap_sr25", "dmr", ["Marksman"], 70, 10, true, true], //Mk 11 Mod 0
    ["rhs_weap_sr25_ec", "dmr", ["Marksman"], 80, 5, true, true], //Mk 11 Mod 0 (EC)
    ["rhs_weap_sr25_ec_d", "dmr", ["Marksman"], 80, 5, true, true], //Mk 11 Mod 0 (EC/Desert)
    ["rhs_weap_sr25_d", "dmr", ["Marksman"], 70, 10, true, true], //Mk 11 Mod 0 (Desert)
    ["UK3CB_PSG1A1_RIS", "dmr", ["Marksman"], 110, 20, true, true], //HK PSG1A1 (RIS)
    ["arifle_SPAR_03_blk_F", "dmr", ["Marksman"], 100, 10, true, true], //HK417A2 20"" (Black)
    ["rhs_weap_pkm", "mmgs", ["Autorifleman"], 35, 20, true, true], //PKM
    ["UK3CB_RPK", "mmgs", ["Autorifleman"], 50, 10, true, true], //RPK
    ["LMG_03_F", "mmgs", ["Autorifleman"], 50, 10, true, true], //FN Minimi SPW
    ["rhs_weap_m249_pip", "mmgs", ["Autorifleman"], 55, 5, true, true], //M249 PIP
    ["rhs_weap_fnmag", "mmgs", ["Autorifleman"], 40, 5, true, true], //FN MAG
    ["srifle_LRR_F", "sniper", ["Sniper"], 300, 0, true, true], //M200 Intervention
    ["rhs_weap_m82a1", "sniper", ["Sniper"], 400, 0, true, true], //M82A1
    ["rhs_weap_t5000", "sniper", ["Sniper"], 200, 5, true, true], //T-5000
    ["rhs_weap_m32", "launchers", ["GL"], 80, 5, true, true], //M32 MGL
    ["CUP_glaunch_6G30", "launchers", ["GL"], 60, 0, true, true] //6G30

];
GRLIB_arsenal_weapons_secondary = [
    ["rhs_weap_rpg7", "launchers", ["AT"], 100, 20, true, true],
    ["rhs_weap_m72a7", "launchers", ["AT"], 20, 25, true, true],
    ["launch_RPG32_green_F", "launchers", ["AT"], 150, 5, true, true],
    ["launch_O_Vorona_brown_F", "launchers", ["AT"], 600, 0, true, true],
    ["rhs_weap_igla", "launchers", ["AA"], 100, 10, true, true],
    ["CUP_launch_9K32Strela_Loaded", "AA", ["Rifleman"], 100,5, true, true],
    ["rhs_weap_fim92", "launchers", ["AA"], 120, 5, true, true]
    // ["ace_csw_kordCarryTripod", "launchers", ["Rifleman"], -1, -1, true, true],
    // ["ace_csw_staticM2ShieldCarry", "launchers", ["Rifleman"], -1, -1, true, true],
    // ["ace_csw_m3CarryTripod", "launchers", ["Rifleman"], -1, -1, true, true],
    // ["ace_compat_rhs_usf3_tow_carry", "launchers", ["Rifleman"], -1, -1, true, true],
    // ["ace_csw_m220CarryTripod", "launchers", ["Rifleman"], -1, -1, true, true],
    // ["ace_compat_rhs_gref3_dshkm_carry", "launchers", ["Rifleman"], -1, -1, true, true]
];
GRLIB_arsenal_weapons_handgun = [
    ["rhsusf_weap_m9", "handguns", ["Rifleman"], 30, 5, true, true],
    ["hlc_pistol_P226US", "handguns", ["Rifleman"], 30, 0, true, true],
    ["rhsusf_weap_m1911a1", "handguns", ["Rifleman"], 10, 30, true, true],
    ["rhsusf_weap_glock17g4", "handguns", ["Rifleman"],20, 20, true, true],
    ["rhs_weap_M320", "handguns", ["GL"], 30, 20, true, true],
    ["hgun_Pistol_heavy_01_F", "handguns", ["Rifleman"], 30, 5, true, true]
    //,["CUP_hgun_CZ75", "Weapons", ["Rifleman"], -1, -1, true, true]
];
// [Classname,catagory",[array of permitted qualifications],cost (-1 for autocost),initial amount (-1 for infinite)]
// ["SatchelCharge_Remote_Mag","explosives",["Rifleman"],000,16]
GRLIB_arsenal_magazines = [
    ["ACE_HuntIR_M203", "Magazine", ["Special Force"], 50, 5],
    ["Vorona_HEAT", "Magazine", ["Rifleman"], 180, 2],
    ["Vorona_HE", "Magazine", ["Rifleman"], 150, 4],
    ["rhs_30Rnd_762x39mm_bakelite","Magazine",["Rifleman"],4,6000],
    ["30Rnd_762x39_Mag_F","Magazine",["Rifleman"],11,6000],
    ["rhs_30Rnd_762x39mm_polymer","Magazine",["Rifleman"],4,6000],
    ["rhs_mag_30Rnd_556x45_M855A1_Stanag","Magazine",["Rifleman"],5,3000],
    ["rhs_30Rnd_762x39mm","Magazine",["Rifleman"],4,3000],
    ["UK3CB_9x30Rnd","Magazine",["Rifleman"],33,600],
    ["rhsusf_mag_40Rnd_46x30_FMJ","Magazine",["Rifleman"],4,600],
    ["rhs_10Rnd_762x54mmR_7N1","Magazine",["Rifleman"],2,1200],
	["rhsusf_20Rnd_762x51_SR25_m118_special_Mag","Magazine",["Rifleman"],4,1200],
    ["rhsusf_20Rnd_762x51_SR25_m62_Mag","Magazine",["Rifleman"],8,600],
	["20Rnd_762x51_Mag","Magazine",["Rifleman"],4,1200],
	["ace_20rnd_762x51_mag_tracer","Magazine",["Rifleman"],8,800],
	["rhs_100Rnd_762x54mmR","Magazine",["Rifleman"],16,6000],
	["UK3CB_RPK_75Rnd_Drum","Magazine",["Rifleman"],29,6000],
	["rhsusf_200Rnd_556x45_box","Magazine",["Rifleman"],28,6000],
	["rhsusf_100Rnd_762x51","Magazine",["Rifleman"],16,6000],
	["7Rnd_408_Mag","Magazine",["Rifleman"],3,100],
	["rhsusf_mag_10Rnd_STD_50BMG_M33","Magazine",["Rifleman"],4,100],
	["rhs_5Rnd_338lapua_t5000","Magazine",["Rifleman"],4,100],
	["rhs_rpg7_PG7VL_mag","Magazine",["Rifleman"],8,20],
	["rhs_rpg7_PG7V_mag","Magazine",["Rifleman"],8,20],
	["rhs_rpg7_PG7VM_mag","Magazine",["Rifleman"],8,20],
	["rhs_rpg7_PG7VS_mag","Magazine",["Rifleman"],8,20],
	["RPG32_F","Magazine",["Rifleman"],6,20],
	["RPG32_HE_F","Magazine",["Rifleman"],7,20],
	["rhs_mag_9k38_rocket","Magazine",["Rifleman"],14,20],
	["rhs_fim92_mag","Magazine",["Rifleman"],17,20],
	["rhsusf_mag_15Rnd_9x19_JHP","Magazine",["Rifleman"],2,1500],
	["rhsusf_mag_7x45acp_MHP","Magazine",["Rifleman"],1,1500],
	["rhsusf_mag_17Rnd_9x19_JHP","Magazine",["Rifleman"],2,1500],
	["rhs_mag_M441_HE","Magazine",["Rifleman"],3,20],
	["rhs_mag_M433_HEDP","Magazine",["Rifleman"],4,10],
	["rhs_mag_M583A1_white","Magazine",["Rifleman"],3,100],
	["rhs_mag_M585_white_cluster","Magazine",["Rifleman"],1,40],
	["1Rnd_Smoke_Grenade_shell","Magazine",["Rifleman"],3,100],
	["1Rnd_SmokeYellow_Grenade_shell","Magazine",["Rifleman"],3,40],
	["1Rnd_SmokeRed_Grenade_shell","Magazine",["Rifleman"],3,40],
	["1Rnd_SmokeBlue_Grenade_shell","Magazine",["Rifleman"],2,40],
	["1Rnd_SmokeGreen_Grenade_shell","Magazine",["Rifleman"],3,40],
	["ace_10rnd_762x54_tracer_mag","Magazine",["Rifleman"],4,40]
];

GRLIB_arsenal_uniforms = [
    ["eaf_full_private_inf_uniform", "uniforms", ["Rifleman"], 4, 100],
    ["eaf_shirt_private_inf_uniform", "uniforms", ["Rifleman"], 4, 20],
    ["eaf_ss_private_inf_uniform", "uniforms", ["Rifleman"], 4, 20],
    ["eaf_2lt_inf_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_1lt_inf_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_cap_inf_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_maj_inf_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_full_private_cav_uniform", "uniforms", ["Rifleman"], 5, 100],
    ["eaf_shirt_private_cav_uniform", "uniforms", ["Rifleman"], 5, 20],
    ["eaf_ss_private_cav_uniform", "uniforms", ["Rifleman"], 5, 20],
    ["eaf_2lt_cav_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_1lt_cav_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_cap_cav_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_maj_cav_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_full_private_recon_uniform", "uniforms", ["Rifleman"], 4, 100],
    ["eaf_shirt_private_recon_uniform", "uniforms", ["Rifleman"], 4, 20],
    ["eaf_ss_private_recon_uniform", "uniforms", ["Rifleman"], 4, 20],
    ["eaf_2lt_recon_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_1lt_recon_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_cap_recon_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_maj_recon_uniform", "uniforms", ["Officer"], 6, 40],
    ["eaf_full_private_saka_uniform", "uniforms", ["Rifleman"], 5, 100],
    ["eaf_shirt_private_saka_uniform", "uniforms", ["Rifleman"], 5, 20],
    ["eaf_ss_private_saka_uniform", "uniforms", ["Rifleman"], 5, 20],
    ["eaf_full_sp_saka_uniform", "uniforms", ["Rifleman"], 10, 40],
    ["eaf_2lt_saka_uniform", "uniforms", ["Officer"], 6, 10],
    ["eaf_1lt_saka_uniform", "uniforms", ["Officer"], 6, 10],
    ["eaf_cap_saka_uniform", "uniforms", ["Officer"], 6, 10],
    ["eaf_maj_saka_uniform", "uniforms", ["Officer"], 6, 10],
    ["eaf_ltc_saka_uniform", "uniforms", ["Officer"], 6, 10],
    ["eaf_col_saka_uniform", "uniforms", ["Officer"], 6, 10],
    ["CAPPA_camo", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_AH64", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_BLACKHAWK", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_C130", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_CH47", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_F16", "uniforms", ["Rifleman"], 10, 10],
    ["CSU13BP_EAF_F16", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_KA50", "uniforms", ["Rifleman"], 10, 10],
    ["CWU27P_EAF_MI8", "uniforms", ["Rifleman"], 10, 10],
    ["amf_pilot_01_f", "uniforms", ["Rifleman"], 10, 10],
    ["AFWC_camo", "uniforms", ["Rifleman"], 10, 10],
    ["AF_Unif_AIR", "uniforms", ["Rifleman"], 5, 10],
    ["AF_Unif_AIR2", "uniforms", ["Rifleman"], 5, 10],
    ["AF_Unif_AIR_c", "uniforms", ["Rifleman"], 5, 10],
    ["2LT_camo", "uniforms", ["Officer"], 5, 6],
    ["1LT_camo", "uniforms", ["Officer"], 5, 6],
    ["CAP_camo", "uniforms", ["Officer"], 5, 6],
    ["MAJ_camo", "uniforms", ["Officer"], 5, 6],
    ["LTC_camo", "uniforms", ["Officer"], 5, 6],
    ["COL_camo", "uniforms", ["Officer"], 5, 6],
    ["TB_Unif_saka", "uniforms", ["Rifleman"], 8, 10],
    ["TB_Unif_saka_J", "uniforms", ["Rifleman"], 8, 10],
    ["TB_Unif_saka_JC", "uniforms", ["Rifleman"], 8, 10],
    ["TB_Unif_saka2", "uniforms", ["Rifleman"], 8, 10],
    ["TB_Unif_saka2_j", "uniforms", ["Rifleman"], 8, 10],
    ["TB_Unif_saka_c", "uniforms", ["Rifleman"], 8, 10],
    ["TB_Unif_saka_cj", "uniforms", ["Rifleman"], 8, 10],
    ["CSU13BP_EAF_F16", "uniforms", ["Rifleman"], 20, 10]
];

GRLIB_arsenal_headgear = [
    ["eaf_metal_helmet", "headgear", ["Rifleman"], 4, 100],
    ["eaf_camo_helmet", "headgear", ["Rifleman"], 5, 40],
    ["SSO_Helmet_Basic_MARPAT", "headgear", ["Rifleman"], 10, 10],
    ["rhsusf_opscore_ut_pelt_nsw_cam", "headgear", ["Rifleman"], 15, 10],
    ["rhsusf_opscore_ut_pelt", "headgear", ["Rifleman"], 12, 10],
    ["rhsusf_opscore_ut", "headgear", ["Rifleman"], 10, 20],
    ["eaf_inf_patrolcap", "headgear", ["Rifleman"], 2, 20],
    ["eaf_cav_patrolcap", "headgear", ["Rifleman"], 2, 20],
    ["eaf_recon_patrolcap", "headgear", ["Rifleman"], 2, 20],
    ["mgsr_headbag", "headgear", ["Rifleman"], 1, 30],
    ["gear_Boonie_SAKA_01", "headgear", ["Rifleman"], 3, 10],
    ["gear_Boonie_SAKA_02", "headgear", ["Rifleman"], 3, 10],
    ["gear_ballcap_SAKA_01", "headgear", ["Rifleman"],2 , 10],
    ["gear_patrolcap_SAKA_02", "headgear", ["Rifleman"], 2, 10],
    ["CFP_BoonieHat_DCU", "headgear", ["Rifleman"], 3, 10],
    ["beret", "headgear", ["Officer"], 4, 20],
    ["FIR_JHMCS", "headgear", ["Rifleman"], 20, 5],
    ["rhsusf_cvc_ess", "headgear", ["Rifleman"], 8, 20]
];

GRLIB_arsenal_vests = [
    ["rhsusf_mbav", "vests", ["Rifleman"], 20, 10],
    ["rhsusf_mbav_medic", "vests", ["Medic"], 40, 10],
    ["rhsusf_mbav_mg", "vests", ["Autorifleman"], 50, 10],
    ["rhsusf_mbav_light", "vests", ["Rifleman"], 35, 20],
    ["rhsusf_mbav_grenadier", "vests", ["GL"], 45, 10],
    ["rhsusf_mbav_rifleman", "vests", ["Rifleman"], 40, 20],
    ["CPC_103gpcoy", "vests", ["Rifleman"], 25,10],
    ["CPC_103gprgr", "vests", ["Rifleman"], 25, 10],
    ["CPC_belt_762gpcoy", "vests", ["Rifleman"], 35, 10],
    ["CPC_belt_762gprgr", "vests", ["Rifleman"], 35, 10],
    ["CFP_LBT6094_operator_OGA", "vests", ["Rifleman"], 20, 10],
    ["SRU21P_LPU9P_PCU15AP", "vests", ["Rifleman"], 20, 30],
    ["gear_tacvest_SAKA_02", "vests", ["Rifleman"], 15, 20],
    ["gear_tacvest_SAKA_01", "vests", ["Rifleman"], 15, 20],
    ["VSM_RAV_Breacher_OGA", "vests", ["Rifleman"], 20, 10],
    ["VSM_RAV_MG_OGA", "vests", ["Rifleman"], 25,30],
    ["VSM_RAV_operator_OGA", "vests", ["Rifleman"], 15, 10],
    ["VSM_OGA_Vest_1", "vests", ["Rifleman"], 10, 10],
    ["VSM_OGA_Vest_2", "vests", ["Rifleman"], 15, 10],
    ["VSM_OGA_Vest_3", "vests", ["Rifleman"], 20, 10],
    ["VSM_OGA_OD_Vest_3", "vests", ["Rifleman"], 20, 10],
    ["VSM_OGA_OD_Vest_2", "vests", ["Rifleman"], 15, 10],
    ["VSM_OGA_OD_Vest_1", "vests", ["Rifleman"], 10, 10],
    ["VSM_RAV_operator_OGA_OD", "vests", ["Rifleman"], 15, 10],
    ["VSM_RAV_MG_OGA_OD", "vests", ["Rifleman"], 30, 10],
    ["VSM_RAV_Breacher_OGA_OD", "vests", ["Rifleman"], 25, 10],
    ["VSM_LBT6094_operator_OGA_OD", "vests", ["Rifleman"], 20,10],
    ["VSM_LBT6094_MG_OGA_OD", "vests", ["Rifleman"], 35, 10],
    ["VSM_LBT6094_breacher_OGA_OD", "vests", ["Rifleman"], 30, 10],
    ["VSM_CarrierRig_Operator_OGA_OD", "vests", ["Rifleman"], 30, 10],
    ["VSM_CarrierRig_Gunner_OGA_OD", "vests", ["Rifleman"], 40,10],
    ["VSM_CarrierRig_Breacher_OGA_OD", "vests", ["Rifleman"], 35, 10],
    ["VSM_FAPC_Operator_OGA_OD", "vests", ["Rifleman"], 20, 10],
    ["VSM_FAPC_MG_OGA_OD", "vests", ["Rifleman"], 35, 10],
    ["VSM_FAPC_Breacher_OGA_OD", "vests", ["Rifleman"], 30, 10],
    ["VSM_LBT6094_operator_OGA", "vests", ["Rifleman"], 25, 10],
    ["VSM_LBT6094_MG_OGA", "vests", ["Rifleman"], 35, 10],
    ["VSM_LBT6094_breacher_OGA", "vests", ["Rifleman"], 30, 10],
    ["VSM_CarrierRig_Operator_OGA", "vests", ["Rifleman"], 30, 10],
    ["VSM_CarrierRig_Gunner_OGA", "vests", ["Rifleman"], 40, 10],
    ["VSM_CarrierRig_Breacher_OGA", "vests", ["Rifleman"], 35, 10],
    ["VSM_FAPC_Operator_OGA", "vests", ["Rifleman"], 25, 10],
    ["VSM_FAPC_MG_OGA", "vests", ["Rifleman"], 35, 10],
    ["VSM_FAPC_Breacher_OGA", "vests", ["Rifleman"], 30, 10]
];

GRLIB_arsenal_facegear = [
    ["UK3CB_G_Balaclava2_DES", "facegear", ["Rifleman"], 3, 15],
    ["VSM_Balaclava2_tan_Goggles", "facegear", ["Rifleman"],3, 10],
    ["VSM_balaclava2_Black", "facegear", ["Rifleman"], 2, 10],
    ["G_CBRN_M04_Hood", "facegear", ["Rifleman"], 3, 15]
];



GRLIB_arsenal_nightvision = [
    ["rhsusf_ANPVS_15", "navigation", ["Rifleman"], 12, 20],
    ["rhs_1PN138", "navigation", ["Rifleman"], 20, 10]
];

GRLIB_arsenal_rangefinders = [
    ["Binocular", "navigation", ["Rifleman"], 2, 100],
    ["rhsusf_bino_m24", "navigation", ["Rifleman"], 3, 20],
    ["Rangefinder", "navigation", ["Special Force","JTAC","Officer"], 8, 10],
    ["ACE_Vector", "navigation", ["Special Force","JTAC"], 12, 10],
    ["Laserdesignator", "navigation", ["Special Force","JTAC"], 15, 10],
    ["Nikon_DSLR_HUD", "navigation", ["Rifleman"], 3, 10]
];

GRLIB_arsenal_maps = [
    ["ItemMap", "navigation", ["Rifleman"], 1, 100]
];
GRLIB_arsenal_watchs = [
    ["ItemWatch", "navigation", ["Rifleman"], 1, 100],
    ["ACE_Altimeter", "navigation", ["Special Force"], 10, 10]
];
GRLIB_arsenal_terminal = [
    ["ItemGPS", "navigation", ["Rifleman"], 3, 100],
    ["B_UavTerminal", "drones", ["Drone Operator"], 20, 10]
];
GRLIB_arsenal_radio = [
    ["tf_anprc152", "communications", ["Rifleman"], 2, 100]
];
GRLIB_arsenal_compass = [
    ["ItemCompass", "navigation", ["Rifleman"], 2, 100]
];

GRLIB_arsenal_optics = [
 ["rhsusf_acc_eotech_xps3", "optics", ["Rifleman"], 2, 30], //XPS3  (0.0731915) 
 ["rhsusf_acc_T1_low_fwd", "optics", ["Rifleman"], 2, 50], //SU-278/PVS LT661 (Forward)  (0.0310638) 
 ["optic_Aco", "optics", ["Rifleman"], 2, 30], //C-More Railway (Red)  (0.0731915) 
 ["rhsusf_acc_su230a", "optics", ["Rifleman"], 2, 30], //SU-230A/PVS  (0.0731915) 
 ["rhs_acc_okp7_picatinny", "optics", ["Rifleman"], 2, 50], //OKP7 (Picatinny)  (0.0310638) 
 ["rhs_acc_okp7_dovetail", "optics", ["Rifleman"], 2, 50], //OKP7  (0.0310638) 
 ["rhs_acc_ekp1", "optics", ["Rifleman"], 2, 50], //EKP-1S-03  (0.0310638) 
 ["hlc_optic_ZF95Base", "optics", ["Rifleman"], 2, 50], //Kahles ZF95  (0.0394894) 
 ["rhsusf_acc_ACOG_MDO", "optics", ["Rifleman"], 2, 50], //SU-260/P (MDO)  (0.0310638) 
 ["rhsusf_acc_RM05_fwd", "optics", ["Rifleman"], 2, 50], //RM05 RMR LT726 (Forward)  (0.0310638) 
 ["rhs_weap_optic_smaw", "optics", ["Rifleman"], 2, 50], //SMAW sight  (0.01) 
 ["rhsusf_acc_mrds_fwd_c", "optics", ["Rifleman"], 2, 30], //MRDS Coyote (Forward)  (0.0731915) 
 ["optic_MRD_black", "optics", ["Rifleman"], 2, 50], //MRD (Black)  (0.01) 
 ["rhsusf_acc_anpvs27", "optics", ["Rifleman"], 2, 50], //AN/PVS-27  (0.0310638) 
 ["optic_MRD", "optics", ["Rifleman"], 2, 50], //MRD  (0.01) 
 ["rhs_acc_ekp8_02", "optics", ["Rifleman"], 2, 50], //EKP-8-02  (0.0310638) 
 ["rhs_acc_ekp8_18", "optics", ["Rifleman"], 2, 50], //EKP-8-18  (0.0310638) 
 ["rhsusf_acc_g33_T1", "optics", ["Rifleman"], 2, 30], //G33 + SU-278/PVS  (0.0731915) 
 ["rhsusf_acc_g33_xps3", "optics", ["Rifleman"], 2, 30], //G33 + XPS3  (0.0731915) 
 ["rhsusf_acc_g33_xps3_tan", "optics", ["Rifleman"], 2, 30], //G33 + XPS3 (Tan)  (0.0731915) 
 ["rhsgref_mg42_acc_AAsight", "optics", ["Rifleman"], 2, 50], //MG42 AA Sight  (0.0310638) 
 ["rhsusf_acc_T1_low", "optics", ["Rifleman"], 2, 50], //SU-278/PVS LT661  (0.0310638) 
 ["rhsusf_acc_mrds_c", "optics", ["Rifleman"], 2, 30], //MRDS Coyote  (0.0731915) 
 ["rhsusf_acc_su230a_c", "optics", ["Rifleman"], 2, 30], //SU-230A/PVS Coyote  (0.0731915) 
 ["rhsusf_acc_su230a_mrds", "optics", ["Rifleman"], 2, 30], //SU-230A/PVS MRDS  (0.0731915) 
 ["rhsusf_acc_su230a_mrds_c", "optics", ["Rifleman"], 2, 30], //SU-230A/PVS MRDS Coyote  (0.0731915) 
 ["rhsusf_acc_su230_c", "optics", ["Rifleman"], 2, 30], //SU-230/PVS Coyote  (0.0731915) 
 ["rhsusf_acc_mrds_fwd", "optics", ["Rifleman"], 2, 30], //MRDS (Forward)  (0.0731915) 
 ["rhsusf_acc_su230_mrds_c", "optics", ["Rifleman"], 2, 30], //SU-230/PVS MRDS Coyote  (0.0731915) 
 ["rhsusf_acc_su230_mrds", "optics", ["Rifleman"], 2, 30], //SU-230/PVS MRDS  (0.0731915) 
 ["rhsusf_acc_su230", "optics", ["Rifleman"], 2, 30], //SU-230/PVS  (0.0731915) 
 ["rhsusf_acc_mrds", "optics", ["Rifleman"], 2, 30], //MRDS  (0.0731915) 
 ["rhsusf_acc_eotech_552", "optics", ["Rifleman"], 2, 25], //M552 CCO  (0.115319) 
 ["rhsusf_acc_compm4", "optics", ["Rifleman"], 2, 25], //M68 CCO  (0.115319) 
 ["rhsgref_acc_l1a1_anpvs2", "optics", ["Rifleman"], 2, 25], //AN/PVS-2  (0.115319) 
 ["rhsusf_acc_eotech_552_d", "optics", ["Rifleman"], 2, 25], //M552 CCO (Desert)  (0.115319) 
 ["rhsusf_acc_T1_high", "optics", ["Rifleman"], 2, 25], //SU-278/PVS LT660  (0.115319) 
 ["rhsgref_acc_RX01_camo", "optics", ["Rifleman"], 2, 25], //RX01 Camo Reflex  (0.115319) 
 ["rhsusf_acc_RX01", "optics", ["Rifleman"], 2, 25], //RX01 Reflex  (0.115319) 
 ["rhsusf_acc_RX01_NoFilter", "optics", ["Rifleman"], 2, 25], //RX01 (w/o Filter)  (0.115319) 
 ["rhsgref_acc_RX01_NoFilter_camo", "optics", ["Rifleman"], 2, 25], //RX01 Camo (w/o Filter)  (0.115319) 
 ["rhs_acc_pkas", "optics", ["Rifleman"], 2, 25], //PK-AS  (0.115319) 
 ["rhsusf_acc_RX01_NoFilter_tan", "optics", ["Rifleman"], 2, 25], //RX01 Tan (w/o Filter)  (0.115319) 
 ["rhs_acc_pso1m21", "optics", ["Rifleman"], 3, 18], //PSO-1M2-1  (0.165872) 
 ["uk3cb_optic_artel_m14", "optics", ["Rifleman"], 6, 11], //Redfield AR-TEL  (0.368085) 
 ["rhs_acc_dh520x56", "optics", ["Rifleman"], 7, 10], //DH 5-20x56  (0.410213) 
 ["rhsusf_acc_ACOG3_USMC", "optics", ["Rifleman"], 7, 10], //AN/PVQ-31A (ARD/Lens Cover)  (0.410213) 
 ["rhsusf_acc_LEUPOLDMK4_2", "optics", ["Rifleman"], 7, 10], //Mk. 4 ER/T 6.5-20x M5  (0.410213) 
 ["rhsusf_acc_LEUPOLDMK4_d", "optics", ["Rifleman"], 7, 10], //Mk. 4 M3 (Desert)  (0.410213) 
 ["rhsusf_acc_LEUPOLDMK4", "optics", ["Rifleman"], 7, 10], //Mk. 4 ER/T 3.5-10x M3  (0.410213) 
 ["rhsusf_acc_ACOG_USMC", "optics", ["Rifleman"], 7, 10], //AN/PVQ-31A RCO  (0.410213) 
 ["rhsusf_acc_ACOG_RMR", "optics", ["Rifleman"], 7, 10], //TA31RCO-RMR  (0.410213) 
 ["rhs_acc_pgo7v3", "optics", ["AT"], 7, 10], //PGO-7V3  (0.410213) 
 ["rhs_acc_pgo7v", "optics", ["AT"], 7, 10], //PGO-7V  (0.410213) 
 ["rhs_acc_pgo7v2", "optics", ["AT"], 7, 10], //PGO-7V2  (0.410213) 
 ["rhs_acc_pgo7v2", "optics", ["AT"], 7, 10], //PGO-7V2  (0.410213) 
 ["rhs_acc_pgo7v3", "optics", ["AT"], 7, 10], //PGO-7V3  (0.410213) 
 ["rhsusf_acc_LEUPOLDMK4_2_d", "optics", ["Rifleman"], 7, 10], //Mk. 4 M5 (Desert)  (0.410213) 
 ["rhs_acc_pso1m2", "optics", ["Rifleman"], 7, 10], //PSO-1M2  (0.410213) 
 ["rhsusf_acc_LEUPOLDMK4_wd", "optics", ["Rifleman"], 7, 10], //Mk. 4 M3 (Woodland)  (0.410213) 
 ["rhsusf_acc_LEUPOLDMK4_2_mrds", "optics", ["Rifleman"], 7, 10], //Mk. 4 M5 (MRDS)  (0.410213) 
 ["rhsusf_acc_ACOG_wd", "optics", ["Rifleman"], 7, 10], //TA31RCO (Woodland)  (0.410213) 
 ["rhsusf_acc_ACOG_RMR", "optics", ["Rifleman"], 7, 10], //TA31RCO-RMR  (0.410213) 
 ["rhsusf_acc_ACOG_d", "optics", ["Rifleman"], 7, 10], //TA31RCO (Desert)  (0.410213) 
 ["Tier1_ATACR18_Geissele_Docter_Black_PIP", "optics", ["Rifleman"], 8, 10], //Nightforce 1-8x24 ATACR/GAM/Docter III  (0.494468) 
 ["rhsusf_acc_M8541_mrds", "optics", ["Rifleman"], 10, 10], //M8541 (MRDS)  (0.620851) 
 ["rhsusf_acc_M8541_low", "optics", ["Rifleman"], 10, 10], //M8541 (low mount)  (0.620851) 
 ["rhsusf_acc_M8541_low_wd", "optics", ["Rifleman"], 10, 10], //M8541 (low mount/Woodland)  (0.620851) 
 ["rhsusf_acc_M8541", "optics", ["Rifleman"], 10, 10], //M8541  (0.620851) 
 ["rhsusf_acc_M8541_d", "optics", ["Rifleman"], 10, 10], //M8541 (Desert)  (0.620851) 
 ["rhsusf_acc_M8541_low_d", "optics", ["Rifleman"], 10, 10], //M8541 (low mount/Desert)  (0.620851) 
 ["rhsusf_acc_premier_anpvs27", "optics", ["Rifleman"], 12, 10], //M8541A + AN/PVS-27  (0.747234) 
 ["rhsusf_acc_premier", "optics", ["Rifleman"], 12, 10], //M8541A SSDS  (0.747234) 
 ["rhsusf_acc_premier_mrds", "optics", ["Rifleman"], 12, 10], //M8541A SSDS (MRDS)  (0.747234) 
 ["rhsusf_acc_premier_low", "optics", ["Rifleman"], 12, 10], //M8541A (low mount)  (0.747234) 
 ["rhsusf_acc_nxs_3515x50_md", "optics", ["Rifleman"], 12, 10], //NXS 3.5-15x50 (mil-dot)  (0.747234) 
 ["rhsusf_acc_nxs_5522x56_md_sun", "optics", ["Rifleman"], 12, 10], //NXS 5.5-22x56 (sunshade/mil-dot)  (0.747234) 
 ["rhsusf_acc_nxs_3515x50f1_h58", "optics", ["Rifleman"], 12, 10], //NXS 3.5-15x50 F1 (H58)  (0.747234) 
 ["rhsusf_acc_nxs_3515x50f1_md_sun", "optics", ["Rifleman"], 12, 10], //NXS 3.5-15x50 F1 (sunshade/mil-dot)  (0.747234) 
 ["rhsusf_acc_nxs_3515x50f1_md", "optics", ["Rifleman"], 12, 10], //NXS 3.5-15x50 F1 (mil-dot)  (0.747234) 
 ["rhsusf_acc_nxs_3515x50f1_h58_sun", "optics", ["Rifleman"], 12, 10], //NXS 3.5-15x50 F1 (sunshade/H58)  (0.747234) 
 ["rhsusf_acc_nxs_5522x56_md", "optics", ["Rifleman"], 12, 10], //NXS 5.5-22x56 (mil-dot)  (0.747234) 
 ["optic_AMS", "optics", ["Rifleman"], 13, 10], //US Optics MR-10 (Black)  (0.831489) 
 ["ACE_optic_LRPS_PIP", "optics", ["Rifleman"], 15, 10] //Nightforce NXS (PIP)  (1) 
];

GRLIB_arsenal_flashlaser = [
    ["rhs_acc_perst3_2dp_light_h", "pointers", ["Rifleman"], 1, 100],
    ["acc_flashlight", "pointers", ["Rifleman"], 2, 50],
    ["rhs_acc_2dpZenit", "pointers", ["Rifleman"], 2, 20],
    ["rhs_acc_2dpZenit_ris", "pointers", ["Rifleman"], 3, 20],
    ["rhs_acc_perst1ik", "pointers", ["Rifleman"], 5, 10],
    ["rhsusf_acc_anpeq15A", "pointers", ["Rifleman"], 6,20],
    ["rhsusf_acc_anpeq15", "pointers", ["Rifleman"], 8, 10],
    ["acc_pointer_IR", "pointers", ["Rifleman"], 8, 10],
    ["hlc_acc_DBALPL", "pointers", ["Rifleman"], 5, 10]
];

GRLIB_arsenal_bipods = [
    ["rhsusf_acc_grip1", "underbarrel", ["Rifleman"], 1, 20],
    ["rhsusf_acc_grip2", "underbarrel", ["Rifleman"], 2, 15],
    ["rhsusf_acc_grip3", "underbarrel", ["Rifleman"], 3, 10],
    ["bipod_01_F_snd", "underbarrel", ["Rifleman"], 4, 30],
    ["bipod_01_F_blk", "underbarrel", ["Rifleman"], 4, 30],
    ["rhsusf_acc_saw_bipod", "underbarrel", ["Rifleman"], 4, 20]
];

GRLIB_arsenal_muzzles = [
    ["rhs_acc_dtkakm", "muzzles", ["Rifleman"], 1,50],
    ["rhs_acc_dtk", "muzzles", ["Rifleman"], 2, 10],
    ["rhs_acc_dtk3", "muzzles", ["Rifleman"], 3, 10],
    ["rhs_acc_dtk4screws", "muzzles", ["Rifleman"], 4, 10],
    ["hlc_muzzle_snds_ROTEX3P", "muzzles", ["Rifleman"], 5, 10],
    ["rhs_acc_ak5", "muzzles", ["Rifleman"], 5, 20],
    ["rhs_acc_pgs64", "muzzles", ["Rifleman"], 5, 20],
    ["hlc_muzzle_556NATO_M42000", "muzzles", ["Rifleman"], 6, 10],
    ["rhs_acc_pbs1", "muzzles", ["Rifleman"], 6, 10],
    ["uk3cb_muzzle_snds_mp5", "muzzles", ["Rifleman"], 6, 10],
    ["rhsusf_acc_rotex_mp7", "muzzles", ["Rifleman"], 6, 10],
    ["rhs_acc_tgpv2", "muzzles", ["Rifleman"], 6, 20],//SVD supp
    ["rhsusf_acc_aac_762sd_silencer", "muzzles", ["Rifleman"], 8, 20],//m110 supp
    ["uk3cb_muzzle_snds_g3", "muzzles", ["Rifleman"], 8, 20], // SR supp
    ["muzzle_snds_M", "muzzles", ["Rifleman"], 8, 20],
    ["muzzle_snds_B_snd_F", "muzzles", ["Rifleman"], 8, 20],
    ["hlc_muzzle_TiRant9S", "muzzles", ["Rifleman"], 8, 20],
    ["rhsusf_acc_SR25S", "muzzles", ["Rifleman"], 8, 20],
    ["hlc_muzzle_556NATO_rotexiiic_tan", "muzzles", ["Rifleman"], 000, 20],
    ["muzzle_snds_m_snd_F", "muzzles", ["Rifleman"], 8, 20],
    ["muzzle_snds_B", "muzzles", ["Rifleman"], 8, 20],
    ["rhsgref_sdn6_suppressor", "muzzles", ["Rifleman"], 10, 20]
];

GRLIB_arsenal_HandGrenade = [
    ["ACE_M84", "handGrenade", ["Rifleman"], 5, 60],
    ["SmokeShell", "handGrenade", ["Rifleman"], 3, 200],
    ["rhssaf_mag_brd_m83_green", "handGrenade", ["Rifleman"], 4, 20],
    ["rhssaf_mag_brd_m83_red", "handGrenade", ["Rifleman"], 4, 20],
    ["SmokeShellPurple", "handGrenade", ["Rifleman"], 4, 20],
    ["HandGrenade", "handGrenade", ["Rifleman"], 6, 40],
    ["MS_Strobe_Mag_1", "handGrenade", ["Special Force"], 5, 30],
    ["MS_Strobe_Mag_2", "handGrenade", ["Special Force"], 5, 30]
];


GRLIB_arsenal_explosives = [
    ["SatchelCharge_Remote_Mag", "explosives", ["EOD"], 20, 10],
    ["DemoCharge_Remote_Mag", "explosives", ["EOD"],10, 20],
    ["AMP_Breaching_Charge_Mag", "explosives", ["EOD"], 5, 20],
    ["ATMine_Range_Mag", "explosives", ["EOD"], 12, 10],
    ["APERSMine_Range_Mag", "explosives", ["EOD"], 5, 0],
    ["rhsusf_mine_m14_mag", "explosives", ["EOD"], 5, 0],
    ["APERSTripMine_Wire_Mag", "explosives", ["EOD"], 3, 0],
    ["APERSBoundingMine_Range_Mag", "explosives", ["EOD"], 5, 0],
    ["SLAMDirectionalMine_Wire_Mag", "explosives", ["EOD"], 3, 0],
    ["ClaymoreDirectionalMine_Remote_Mag", "explosives", ["EOD"], 5, 0],
    ["rhs_mine_M3_tripwire_mag", "explosives", ["EOD"], 2, 30]
];


GRLIB_arsenal_backpacks = [
    ["eaf_private_bag", "backpacks", ["Rifleman"], 2, 40],
    ["rhs_rpg_6b2", "backpacks", ["AT","AA"], 3, 40],
    ["gear_assaultpack_SAKA_01", "backpacks", ["Special Force"], 5, 30],
    ["gear_assaultpack_SAKA_03", "backpacks", ["Special Force"], 5, 30],
    ["gear_assaultpack_SAKA_04", "backpacks", ["Special Force"], 5, 30],
    ["gear_assaultpack_SAKA_02", "backpacks", ["Special Force"], 5, 30],
    ["gear_FastPack_SAKA_03", "backpacks", ["EOD","Engineer","Medic"], 8, 20],
    ["gear_FastPack_SAKA_01", "backpacks", ["EOD","Engineer","Medic"], 8, 20],
    ["gear_FastPack_SAKA_04", "backpacks", ["EOD","Engineer","Medic"], 8, 20],
    ["gear_FastPack_SAKA_02", "backpacks", ["EOD","Engineer","Medic"], 8, 20],
    ["gear_Carryall_SAKA_02", "backpacks", ["EOD","Engineer","Medic"], 10, 15],
    ["gear_Carryall_SAKA_01", "backpacks", ["EOD","Engineer","Medic"], 10, 15],
    ["eaf_parachute_01_pack", "backpacks", ["EOD","Engineer","Medic"], 2, 10],
    ["Saka_tf_rt1523g_DES", "backpacks", ["JTAC","Officer"], 6, 10],
    ["Saka_tf_rt1523g_big_DES", "backpacks", ["JTAC","Officer"], 12, 15]
];

GRLIB_arsenal_other = [
    ["ACE_MapTools", "navigation", ["Special Force"], 2, 50],
    ["ACE_microDAGR", "navigation", ["Special Force"], 10, 30],
    ["ACE_EntrenchingTool", "tools", ["Rifleman"], 2, 10],
    ["ACE_Fortify", "tools", ["Engineer"], 2, 20],
    ["ToolKit", "engineering", ["Engineer"], 20, 30],
    ["ACE_wirecutter", "engineering", ["EOD"], 3, 10],
    ["ACE_DefusalKit", "engineering", ["EOD"], 5, 10],
    ["MineDetector", "engineering", ["EOD"], 15, 10],
    ["ACE_M26_Clacker", "engineering", ["EOD"], 20, 10],
    ["ACE_Clacker", "engineering", ["EOD"], 50, 20],
    ["ItemAndroid", "communications", ["Special Force"], 20, 10],
    ["ItemcTab", "communications", ["Officer"], 50, 5],
    ["ACE_CableTie", "others", ["Rifleman"], 1, 100],
    ["ACE_UAVBattery", "drones", ["Drone Operator"], 5, 20],
    ["ITC_Land_B_AR2i_Packed", "drones", ["Drone Operator"], 600, 5],
    ["sps_black_hornet_01_Static_F", "drones", ["Drone Operator"], 200, 10],
    ["eaf_beef_can", "foods", ["Rifleman"], 3, 100],
    ["eaf_foul_can", "foods", ["Rifleman"], 2, 200],
    ["eaf_fig_jam", "foods", ["Rifleman"], 1, 200],
    ["eaf_water_bottle", "foods", ["Rifleman"], 1, 200],
    ["ACE_Canteen", "foods", ["Rifleman"], 2, 100],
    ["ACE_bodyBag", "medical", ["Rifleman"], 2, 100],
    ["ACE_EarPlugs", "others", ["Rifleman"], 1, 200],
    ["ACE_Flashlight_MX991", "others", ["Rifleman"], 5, 50],
    ["ACE_Flashlight_XL50", "others", ["Rifleman"], 5, 50],
    ["ACE_RangeCard", "tools", ["Sniper","Marksman"], 5, 20],
    ["ACE_rope12", "others", ["Rifleman"], 5, 10],
    ["ACE_rope15", "others", ["Rifleman"], 8, 10],
    ["ACE_rope18", "others", ["Rifleman"], 10, 10],
    ["ACE_rope27", "others", ["Rifleman"], 12, 10],
    ["ACE_rope36", "others", ["Rifleman"], 15, 10],
    ["ACE_Tripod", "tools", ["Rifleman"], 15, 10],
    ["ACE_elasticBandage", "medical", ["Medic"], 5, 150],
    ["kat_guedel", "medical", ["Medic"], 3, 100],
    ["ACE_packingBandage", "medical", ["Rifleman"], 4, 300],
    ["ACE_quikclot", "medical", ["Rifleman"], 3, 200],
    ["ACE_fieldDressing", "medical", ["Rifleman"], 2, 300],
    ["ACE_morphine", "medical", ["Medic"], 3, 200],
    ["ACE_epinephrine", "medical", ["Medic"], 3, 200],
    ["ACE_bloodIV", "medical", ["Medic"], 6, 100],
    ["ACE_bloodIV_250", "medical", ["Medic"], 1, 300],
    ["ACE_bloodIV_500", "medical", ["Medic"], 3, 200],
    ["ACE_salineIV", "medical", ["Medic"], 6, 100],
    ["ACE_salineIV_250", "medical", ["Medic"], 1, 300],
    ["ACE_salineIV_500", "medical", ["Medic"], 3, 200],
    ["ACE_plasmaIV", "medical", ["Medic"], 6, 100],
    ["ACE_plasmaIV_250", "medical", ["Medic"], 1, 300],
    ["ACE_plasmaIV_500", "medical", ["Medic"], 3, 200],
    ["kat_accuvac", "medical", ["Medic"], 000, 20],
    ["kat_larynx", "medical", ["Medic"], 000, 50],
    ["ACE_splint", "medical", ["Rifleman"], 3, 100],
    ["ACE_tourniquet", "medical", ["Rifleman"], 2, 100],
    ["ACE_personalAidKit", "medical", ["Medic"], 000, 20],
    ["ACE_surgicalKit", "medical", ["Medic"], 5, 100],
    ["ACE_ATNAA", "medical", ["Medic"], 000, 20],
    ["kat_X_AED", "medical", ["Medic"], 000, 20],
    ["kat_chestSeal", "medical", ["Medic"], 000, 50],
    ["kat_aatKit", "medical", ["Medic"], 000,50],
    ["kat_Pulseoximeter", "medical", ["Medic"], 000,20],
    ["ACE_ATragMX", "tools", ["Sniper","Marksman"], 10, 5],
    ["ACE_Kestrel4500", "tools", ["Sniper","Marksman"], 8, 5],
    ["ACE_IR_Strobe_Item", "tools", ["Rifleman"], 5, 20],
    ["ACE_adenosine", "medical", ["Medic"], 000,100],
    ["kat_AED", "medical", ["Medic"], 000, 20],
    ["ItemcTabHCam", "tools", ["Special Force"], 12, 10],
    ["kat_stethoscope", "medical", ["Medic"], 000, 50],
    ["MRH_TacticalDisplay", "tools", ["Officer"], 100, 5],
    ["tfw_blade", "tools", ["JTAC"], 5, 0],
    ["tfw_whip", "tools", ["JTAC"], 5, 0],
    ["tfw_dd", "tools", ["JTAC"], 5, 0],
    ["MRH_FoldedSatcomAntenna", "tools", ["JTAC"], 50, 5],
    ["ITC_Land_B_RemoteGLTD_Packed", "tools", ["Special Force"], 50, 5],
    ["ACE_HuntIR_monitor", "tools", ["Special Force"], 100, 5],
    ["MRH_BluForTransponder", "tools", ["Special Force"], 30, 5]
];