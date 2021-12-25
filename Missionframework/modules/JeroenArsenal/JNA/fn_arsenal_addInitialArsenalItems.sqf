_mags = GRLIB_arsenal_magazines apply { [(_x select 0) ,(_x select 4)]}; 

{ 
	_numberAvailable = -1; 
	_wmags = [ (_x select 0) ] call jn_fnc_arsenal_getCompatibleMagazines; 
	_mags =_mags +(_wmags  apply { [_x  , _numberAvailable ]}); 
} forEach (GRLIB_arsenal_weapons_primary select {(_x select 5)});


//[cursorObject] call jn_fnc_arsenal_addInitialArsenalItems
_items = [
//Weapons	
GRLIB_arsenal_weapons_primary apply { [(_x select 0) ,(_x select 4)]}
//launcher
,GRLIB_arsenal_weapons_secondary apply { [(_x select 0) , (_x select 4)]}
//handguns
,GRLIB_arsenal_weapons_handgun apply { [(_x select 0) , (_x select 4)]}
//uniforms
,GRLIB_arsenal_weapons_handgun apply { [(_x select 0) , (_x select 4)]}
//vests
,GRLIB_arsenal_vests apply { [(_x select 0) ,( _x select 4)]}
//bags
,GRLIB_arsenal_backpacks apply { [(_x select 0) , (_x select 4)]}
//headgear
,[]
//facewear
,[]
//nightvision
,[]
//rangefinders
,[]
//maps
,[]
//terminal
,[]
//radio
,[]
//compass
,[]

//watchs
,[]
,[]
,[]
,[]
//optics
,[]
//flash and laser
,[]
//muzzles
,[]
,[]
//HandGrenade
,[]
//explosives
,[]
//items
,[]

//bipods
,[]
//mags
,_mags
];

// _names= [];
//	 {
//	 _names pushBack ( getText(configFile >> "CfgWeapons" >> (_x select 0) >> "displayName"));	
//	 } forEach _weapons;
// _names


_this setVariable ["jna_dataList" ,_items,true];



// //[cursorObject] call jn_fnc_arsenal_addInitialArsenalItems
// _items = [
// //Weapons	
// [
// // ["eaf_maadi",-1], //AK-47N
// //["eaf_maadi_gl",-1], //AK-47N	

//  ["rhs_weap_akms",-1]	//AKMS
// ,["uk3cb_ak47n",-1] //AK-47N
// ,["rhs_weap_akm_zenitco01_b33",-1]
// ,["rhs_weap_akmn_gp25_npz",-1]
// ,["CUP_arifle_AK74_top_rail",-1] //AK-74N (RIS mount)
// ,["CUP_arifle_AK74_GL_top_rail",-1] //AK-74N GP-25 (RIS mount)
// ,["rhs_weap_ak103_zenitco01_b33",-1] //AK-103 (Zenitco/B-33)
// ,["rhs_weap_ak103_gp25_npz",-1] //AK-103 (GP-25/B-13)
// ,["rhs_weap_ak104_zenitco01_b33",-1] //AK-104 (Zenitco/B-33)
// ,["rhs_weap_m4a1",-1] //M4A1 PIP
// //,["CUP_arifle_M4A1_SOMMOD_tan",-1]//M4A1 SOPMOD Block II (AFG/Tan)
// //,["CUP_arifle_M4A1_SOMMOD_Grip_black",-1] //M4A1 SOPMOD Block II (Grip/Black)

// ,["drg_arx160",-1]//Beretta ARX160A1
// ,["drg_arx160_gls",-1]//Beretta ARX160A1 GL
// ,["JAS_SIG516_14_5_CTR_Tan",-1]//SIG516 14.5inch Tactical Patrol CTR Stock(Tan)

// ,["UK3CB_MP5N_UGL",-1] //HK MP5N UGL
// ,["UK3CB_MP5N",-1]  //HK MP5N
// ,["rhsusf_weap_MP7A2_grip3",-1] //MP7A2

// ,["rhs_weap_hk416d10",-1]
// ,["rhs_weap_hk416d10_m320",-1]
// ,["rhs_weap_hk416d10_LMT",-1]
// ,["rhs_weap_hk416d10_LMT_d",-1]
// ,["rhs_weap_hk416d145",-1]
// ,["rhs_weap_hk416d145_d",-1]
// ,["rhs_weap_hk416d145_d_2",-1]

// ,["UK3CB_SVD_OLD_NPZ",-1]//SVD NPZ
// ,["rhs_weap_svds_npz",-1]//SVDS (NPZ)
// ,["rhs_weap_sr25",-1] //Mk 11 Mod 0
// ,["rhs_weap_sr25_ec",-1]//Mk 11 Mod 0 (EC)
// ,["rhs_weap_sr25_ec_d",-1] //Mk 11 Mod 0 (EC/Desert)
// ,["rhs_weap_sr25_d",-1] //Mk 11 Mod 0 (Desert)
// ,["UK3CB_PSG1A1_RIS",-1] //HK PSG1A1 (RIS)
// ,["arifle_SPAR_03_blk_F",-1] //HK417A2 20"" (Black)

// ,["rhs_weap_pkm",-1]//PKM
// ,["UK3CB_RPK",-1]//RPK
// ,["LMG_03_F",-1]//FN Minimi SPW

// ,["rhs_weap_m249_pip",-1] //M249 PIP
// ,["rhs_weap_fnmag",-1] //FN MAG

// //,["CUP_srifle_M24_blk",-1] //M24 (Black)
// //,["CUP_srifle_M40A3",-1] //M40A3
// //,["CUP_srifle_AWM_blk",-1] //L115A3 LRR (Black)
// ,["srifle_LRR_F",-1] //M200 Intervention
// ,["rhs_weap_m82a1",-1] //M82A1
// ,["rhs_weap_t5000",-1] //T-5000

// ,["rhs_weap_m32",-1] //M32 MGL
// ,["CUP_glaunch_6G30",-1] //6G30
// ]


// //launcher
// ,[["rhs_weap_rpg7",-1]
// ,["rhs_weap_m72a7",-1]
// ,["launch_RPG32_green_F",-1]
// ,["launch_O_Vorona_brown_F",-1]
// ,["rhs_weap_igla",-1]
// ,["CUP_launch_9K32Strela_Loaded",-1]
// ,["rhs_weap_fim92",-1]
// ,["ace_csw_kordCarryTripod",-1]
// ,["ace_csw_staticM2ShieldCarry",-1]
// ,["ace_csw_m3CarryTripod",-1]
// ,["ace_compat_rhs_usf3_tow_carry",-1]
// ,["ace_csw_m220CarryTripod",-1]
// ,["ace_compat_rhs_gref3_dshkm_carry",-1]

// ]
// //handguns
// ,[["rhsusf_weap_m9",-1]
// ,["hlc_pistol_P226US",-1]
// ,["rhsusf_weap_m1911a1",-1]
// ,["rhsusf_weap_glock17g4",-1]
// ,["rhs_weap_M320",-1]
// ,["hgun_Pistol_heavy_01_F",-1]
// //,["CUP_hgun_CZ75",-1]
// ]

// //uniforms
// ,[
//  ["eaf_full_private_inf_uniform",-1]
// ,["eaf_shirt_private_inf_uniform",-1]
// ,["eaf_ss_private_inf_uniform",-1]
// ,["eaf_2lt_inf_uniform",-1]
// ,["eaf_1lt_inf_uniform",-1]
// ,["eaf_cap_inf_uniform",-1]
// ,["eaf_maj_inf_uniform",-1]
// ,["eaf_full_private_cav_uniform",-1]
// ,["eaf_shirt_private_cav_uniform",-1]
// ,["eaf_ss_private_cav_uniform",-1]
// ,["eaf_2lt_cav_uniform",-1]
// ,["eaf_1lt_cav_uniform",-1]
// ,["eaf_cap_cav_uniform",-1]
// ,["eaf_maj_cav_uniform",-1]
// ,["eaf_full_private_recon_uniform",-1]
// ,["eaf_shirt_private_recon_uniform",-1]
// ,["eaf_ss_private_recon_uniform",-1]
// ,["eaf_2lt_recon_uniform",-1]
// ,["eaf_1lt_recon_uniform",-1]
// ,["eaf_cap_recon_uniform",-1]
// ,["eaf_maj_recon_uniform",-1]

// ,["eaf_full_private_saka_uniform",-1]
// ,["eaf_shirt_private_saka_uniform",-1]
// ,["eaf_ss_private_saka_uniform",-1]
// ,["eaf_full_sp_saka_uniform",-1]
// ,["eaf_2lt_saka_uniform",-1]
// ,["eaf_1lt_saka_uniform",-1]
// ,["eaf_cap_saka_uniform",-1]
// ,["eaf_maj_saka_uniform",-1]
// ,["eaf_ltc_saka_uniform",-1]
// ,["eaf_col_saka_uniform",-1]


// ,["CAPPA_camo",-1]
// ,["CWU27P_EAF_AH64",-1]
// ,["CWU27P_EAF_BLACKHAWK",-1]
// ,["CWU27P_EAF_C130",-1]
// ,["CWU27P_EAF_CH47",-1]
// ,["CWU27P_EAF_F16",-1]
// ,["CSU13BP_EAF_F16",-1]
// ,["CWU27P_EAF_KA50",-1]
// ,["CWU27P_EAF_MI8",-1]
// ,["amf_pilot_01_f",-1]
// ,["AFWC_camo",-1]
// ,["AF_Unif_AIR",-1]
// ,["AF_Unif_AIR2",-1]
// ,["AF_Unif_AIR_c",-1]
// ,["2LT_camo",-1]
// ,["1LT_camo",-1]
// ,["CAP_camo",-1]
// ,["MAJ_camo",-1]
// ,["LTC_camo",-1]
// ,["COL_camo",-1]
// ,["TB_Unif_saka",-1]
// ,["TB_Unif_saka_J",-1]
// ,["TB_Unif_saka_JC",-1]
// ,["TB_Unif_saka2",-1]
// ,["TB_Unif_saka2_j",-1]
// ,["TB_Unif_saka_c",-1]
// ,["TB_Unif_saka_cj",-1]
// //,["CUP_U_B_BAF_DDPM_GHILLIE",-1]
// ,["CSU13BP_EAF_F16",-1]
// // ,["CFP_U_KhetPartug_Long_Olive",-1]
// // ,["CFP_U_KhetPartug_Short_Olive",-1]
// // ,["CFP_U_KhetPartug_Long_Light_Olive",-1]
// // ,["CFP_U_KhetPartug_Short_Light_Olive",-1]
// // ,["CFP_U_KhetPartug_Long_Black" ,-1]
// // ,["CFP_U_KhetPartug_Short_GreenOlive" ,-1]
// // ,["CFP_U_KhetPartug_Long_Blue" ,-1]
// // ,["CFP_U_KhetPartug_Long_BlueGrey" ,-1]
// // ,["CFP_U_KhetPartug_Long_Brown",-1]
// // ,["CFP_U_KhetPartug_Long_Creme",-1]
// // ,["CFP_U_KhetPartug_Long_Grey",-1]
// // ,["CFP_U_KhetPartug_Long_Purple",-1]
// // ,["CFP_U_KhetPartug_Long_Tan",-1]
// // ,["CFP_U_KhetPartug_Long_White" ,-1]
// // ,["CFP_U_KhetPartug_Short_Blue" ,-1]
// // ,["CFP_U_KhetPartug_Short_BlueGrey",-1]
// // ,["CFP_U_KhetPartug_Short_Brown",-1]
// // ,["CFP_U_KhetPartug_Short_Creme",-1]
// // ,["CFP_U_KhetPartug_Short_Grey" ,-1]
// // ,["CFP_U_KhetPartug_Short_Purple" ,-1]
// // ,["CFP_U_KhetPartug_Short_Tan",-1]
// // ,["CFP_U_KhetPartug_Short_White",-1]
// // ,["CFP_U_KhetPartug_Short_Black",-1]
// ]


// //vests
// ,[
//  ["rhsusf_mbav",-1]
// ,["rhsusf_mbav_medic",-1]
// ,["rhsusf_mbav_mg",-1]
// ,["rhsusf_mbav_light",-1]
// ,["rhsusf_mbav_grenadier",-1]
// ,["rhsusf_mbav_rifleman",-1]
// ,["CPC_103gpcoy",-1]
// ,["CPC_103gprgr",-1]
// ,["CPC_belt_762gpcoy",-1]
// ,["CPC_belt_762gprgr",-1]
// ,["CFP_LBT6094_operator_OGA",-1]
// ,["SRU21P_LPU9P_PCU15AP",-1]
// ,["gear_tacvest_SAKA_02",-1]
// ,["gear_tacvest_SAKA_01",-1]
// ,["VSM_RAV_Breacher_OGA",-1]
// ,["VSM_RAV_MG_OGA",-1]
// ,["VSM_RAV_operator_OGA",-1]
// ,["VSM_OGA_Vest_1",-1]
// ,["VSM_OGA_Vest_2",-1]
// ,["VSM_OGA_Vest_3",-1]
// ,["VSM_OGA_OD_Vest_3",-1]
// ,["VSM_OGA_OD_Vest_2",-1]
// ,["VSM_OGA_OD_Vest_1",-1]
// ,["VSM_RAV_operator_OGA_OD",-1]
// ,["VSM_RAV_MG_OGA_OD",-1]
// ,["VSM_RAV_Breacher_OGA_OD",-1]
// ,["VSM_LBT6094_operator_OGA_OD",-1]
// ,["VSM_LBT6094_MG_OGA_OD",-1]
// ,["VSM_LBT6094_breacher_OGA_OD",-1]
// ,["VSM_CarrierRig_Operator_OGA_OD",-1]
// ,["VSM_CarrierRig_Gunner_OGA_OD",-1]
// ,["VSM_CarrierRig_Breacher_OGA_OD",-1]
// ,["VSM_FAPC_Operator_OGA_OD",-1]
// ,["VSM_FAPC_MG_OGA_OD",-1]
// ,["VSM_FAPC_Breacher_OGA_OD",-1]
// ,["VSM_LBT6094_operator_OGA",-1]
// ,["VSM_LBT6094_MG_OGA",-1]
// ,["VSM_LBT6094_breacher_OGA",-1]
// ,["VSM_CarrierRig_Operator_OGA",-1]
// ,["VSM_CarrierRig_Gunner_OGA",-1]
// ,["VSM_CarrierRig_Breacher_OGA",-1]
// ,["VSM_FAPC_Operator_OGA",-1]
// ,["VSM_FAPC_MG_OGA",-1]
// ,["VSM_FAPC_Breacher_OGA",-1]
// ]

// //bags
// ,[
// // ["tfw_ilbe_whip_coy",-1]
// //,["tfw_ilbe_DD_coy",-1]
// //,["tfw_ilbe_blade_coy",-1]
// //,["eaf_private_bag",-1]
// //,["eaf_Engnieer_electronic_warfare_rf",-1]
// //,["eaf_Engnieer_electronic_warfare_gsm",-1],
// ["gear_assaultpack_SAKA_01",-1]
// ,["gear_assaultpack_SAKA_03",-1]
// ,["gear_assaultpack_SAKA_04",-1]
// ,["gear_assaultpack_SAKA_02",-1]
// ,["gear_FastPack_SAKA_03",-1]
// ,["gear_FastPack_SAKA_01",-1]
// ,["gear_Carryall_SAKA_02",-1]
// ,["gear_Carryall_SAKA_01",-1]
// ,["gear_FastPack_SAKA_04",-1]
// ,["gear_FastPack_SAKA_02",-1]
// ,["eaf_parachute_01_pack",-1]
// ,["Saka_tf_rt1523g_DES",-1]
// ,["Saka_tf_rt1523g_big_DES",-1]
// ]

// //headgear
// ,[
// ["eaf_metal_helmet",-1]
// ,["eaf_camo_helmet",-1]
// ,["SSO_Helmet_Basic_MARPAT",-1]
// ,["rhsusf_opscore_ut_pelt_nsw_cam",-1]
// ,["rhsusf_opscore_ut_pelt",-1]
// ,["rhsusf_opscore_ut",-1]
// ,["eaf_inf_patrolcap",-1]
// ,["eaf_cav_patrolcap",-1]
// ,["eaf_recon_patrolcap",-1]
// ,["mgsr_headbag",-1]
// ,["gear_Boonie_SAKA_01",-1]
// ,["gear_Boonie_SAKA_02",-1]
// ,["gear_ballcap_SAKA_01",-1]
// ,["gear_patrolcap_SAKA_02",-1]
// ,["CFP_BoonieHat_DCU",-1]
// ,["beret",-1]
// ,["FIR_JHMCS",-1]
// ,["rhsusf_cvc_ess",-1]
// // ,["CUP_H_TKI_SkullCap_06",-1]
// // ,["CUP_H_TKI_SkullCap_04",-1]
// // ,["CUP_H_C_Beanie_04",-1]
// // ,["CUP_H_TKI_SkullCap_02",-1]
// // ,["CUP_H_TKI_Lungee_Open_01",-1]
// // ,["CUP_H_TKI_Lungee_Open_06",-1]
// // ,["CUP_H_TKI_SkullCap_03",-1]
// // ,["CUP_H_TKI_Lungee_Open_05",-1]
// // ,["CUP_H_C_Beanie_02",-1]
// // ,["CFP_Lungee_Open_Tan",-1]
// // ,["CFP_Lungee_Open_LightOlive",-1]
// // ,["CFP_Lungee_Open_Grey",-1]
// // ,["CFP_Lungee_Open_Creme",-1]
// // ,["CFP_Lungee_Open_Brown",-1]
// // ,["CFP_Lungee_Open_BlueGrey",-1]
// // ,["CFP_Lungee_Open_Blue",-1]
// ]

// //facewear
// ,[
// ["UK3CB_G_Balaclava2_DES",-1]
// ,["rhsusf_shemagh_gogg_tan",-1]
// ,["rhsusf_shemagh2_gogg_tan",-1]
// ,["rhsusf_shemagh_tan",-1]
// ,["rhsusf_shemagh2_tan",-1]
// ,["VSM_Balaclava2_tan_Goggles",-1]
// ,["VSM_balaclava2_Black",-1]
// ,["G_CBRN_M04_Hood",-1]
// ]

// //nightvision
// ,[
//  ["rhsusf_ANPVS_15",-1]
// ,["rhs_1PN138",-1]
// ,["CUP_NVG_PVS15_tan",-1]
// ]

// //rangefinders
// ,[
//  ["Binocular",-1]
// ,["rhsusf_bino_m24",-1]
// ,["Rangefinder",-1]
// ,["ACE_Vector",-1]
// ,["Laserdesignator",-1]
// ,["Nikon_DSLR_HUD",-1]
// ]

// //maps
// ,[["ItemMap",-1]]

// //terminal
// ,[["ItemGPS",-1]
// ,["B_UavTerminal",-1]]

// //radio
// ,[["tf_anprc152",-1]]

// //compass
// ,[["ItemCompass",-1]]

// //watchs
// ,[["ItemWatch",-1]
// ,["ACE_Altimeter",-1]]
// ,[]
// ,[]
// ,[]

// //optics
// ,[
// ["CUP_optic_AIMM_MICROT1_BLK",-1]
// ,["Tier1_ATACR18_Geissele_Docter_Black_PIP",-1]
// ,["optic_AMS",-1]
// ,["optic_Aco",-1]
// ,["CUP_optic_CompM4",-1]
// ,["ACE_optic_LRPS_PIP",-1]
// ,["rhs_acc_pgo7v2",-1]
// ,["rhs_acc_pgo7v3",-1]
// ,["FHQ_optic_AC11704_tan",-1]
// ,["CUP_optic_LeupoldMk4_20x40_LRT",-1]
// ,["FHQ_optic_AC11704",-1]
// ,["rhs_acc_ekp1",-1]
// ,["hlc_optic_ZF95Base",-1]
// ,["CUP_optic_Elcan_SpecterDR_KF_RMR",-1]
// ,["CUP_optic_ZeissZPoint",-1]
// ,["rhsusf_acc_ACOG_RMR",-1]

// ,["hsusf_acc_ACOG2_USMC",-1]
// ,["rhsusf_acc_ACOG3_USMC",-1]
// ,["rhsusf_acc_ACOG_USMC",-1]
// ,["rhsgref_acc_l1a1_anpvs2",-1]
// ,["rhsusf_acc_anpvs27",-1]
// ,["rhs_acc_dh520x56",-1]
// ,["rhs_acc_ekp8_02",-1]
// ,["rhs_acc_ekp8_18",-1]
// ,["rhsusf_acc_g33_T1",-1]
// ,["rhsusf_acc_g33_xps3",-1]
// ,["rhsusf_acc_g33_xps3_tan",-1]
// ,["rhsusf_acc_eotech_552",-1]
// ,["rhsusf_acc_eotech_552_d",-1]
// ,["rhsusf_acc_compm4",-1]
// ,["rhsusf_acc_M8541",-1]
// ,["rhsusf_acc_M8541_d",-1]
// ,["rhsusf_acc_M8541_low",-1]
// ,["rhsusf_acc_M8541_low_d",-1]
// ,["rhsusf_acc_M8541_low_wd",-1]
// ,["rhsusf_acc_M8541_mrds",-1]
// ,["rhsusf_acc_premier_low",-1]
// ,["rhsusf_acc_premier_anpvs27",-1]
// ,["rhsusf_acc_premier",-1]
// ,["rhsusf_acc_premier_mrds",-1]
// ,["rhsgref_mg42_acc_AAsight",-1]
// ,["rhsusf_acc_LEUPOLDMK4",-1]
// ,["rhsusf_acc_LEUPOLDMK4_2",-1]
// ,["rhsusf_acc_LEUPOLDMK4_d",-1]
// ,["rhsusf_acc_LEUPOLDMK4_wd",-1]
// ,["rhsusf_acc_LEUPOLDMK4_2_d",-1]
// ,["rhsusf_acc_LEUPOLDMK4_2_mrds",-1]
// ,["optic_MRD",-1]
// ,["optic_MRD_black",-1]
// ,["rhsusf_acc_mrds",-1]
// ,["rhsusf_acc_mrds_fwd",-1]
// ,["rhsusf_acc_mrds_c",-1]
// ,["rhsusf_acc_mrds_fwd_c",-1]
// ,["rhsusf_acc_nxs_3515x50_md",-1]
// ,["rhsusf_acc_nxs_3515x50f1_h58",-1]
// ,["rhsusf_acc_nxs_3515x50f1_md",-1]
// ,["rhsusf_acc_nxs_3515x50f1_h58_sun",-1]
// ,["rhsusf_acc_nxs_3515x50f1_md_sun",-1]
// ,["rhsusf_acc_nxs_5522x56_md",-1]
// ,["rhsusf_acc_nxs_5522x56_md_sun",-1]
// ,["rhs_acc_okp7_dovetail",-1]
// ,["rhs_acc_pgo7v",-1]
// ,["rhs_acc_pgo7v2",-1]
// ,["rhs_acc_okp7_picatinny",-1]
// ,["rhs_acc_pgo7v3",-1]
// ,["rhs_acc_pkas",-1]
// ,["rhs_acc_pso1m2",-1]
// ,["rhs_acc_pso1m21",-1]
// ,["uk3cb_optic_artel_m14",-1]
// ,["rhsusf_acc_RM05_fwd",-1]
// ,["rhsusf_acc_RX01_NoFilter",-1]
// ,["rhsgref_acc_RX01_NoFilter_camo",-1]
// ,["rhsgref_acc_RX01_camo",-1]
// ,["rhsusf_acc_RX01",-1]
// ,["rhsusf_acc_RX01_NoFilter_tan",-1]
// ,["rhs_weap_optic_smaw",-1]
// ,["rhsusf_acc_su230",-1]
// ,["rhsusf_acc_su230_c",-1]
// ,["rhsusf_acc_su230_mrds",-1]
// ,["rhsusf_acc_su230_mrds_c",-1]
// ,["rhsusf_acc_T1_low",-1]
// ,["rhsusf_acc_T1_high",-1]
// ,["rhsusf_acc_ACOG_MDO",-1]
// ,["rhsusf_acc_su230a_mrds_c",-1]
// ,["rhsusf_acc_su230a_mrds",-1]
// ,["rhsusf_acc_su230a_c",-1]
// ,["rhsusf_acc_su230a",-1]
// ,["rhsusf_acc_T1_low_fwd",-1]
// ,["rhsusf_acc_ACOG_d",-1]
// ,["rhsusf_acc_ACOG_wd",-1]
// ,["rhsusf_acc_ACOG_RMR",-1]
// ,["rhsusf_acc_eotech_xps3",-1]
// ]

// //flash and laser
// ,[
// ["rhsusf_acc_anpeq15",-1]
// ,["rhsusf_acc_anpeq15A",-1]
// ,["rhs_acc_perst3_2dp_light_h",-1]
// ,["JAS_SFDBAL_Charlie_516_TOP_Blk",-1]
// ,["rhs_acc_2dpZenit_ris",-1]
// ,["CUP_Mxx_camo",-1]
// ,["CUP_acc_Glock17_Flashlight",-1]
// ,["hlc_acc_DBALPL",-1]
// ,["CUP_acc_LLM01_F",-1]
// ,["CUP_acc_XM8_light_module",-1]
// ,["acc_flashlight",-1]
// ,["rhs_acc_perst1ik",-1]
// ,["rhs_acc_2dpZenit",-1]
// ]

// //muzzles
// ,[
// ["rhs_acc_tgpv2",-1]
// ,["rhsusf_acc_aac_762sd_silencer",-1]
// ,["muzzle_snds_M",-1]
// ,["rhsusf_acc_SR25S",-1]
// ,["rhs_acc_dtk4screws",-1]
// ,["uk3cb_muzzle_snds_g3",-1]
// ,["rhs_acc_dtk",-1]
// ,["rhs_acc_pgs64",-1]
// ,["rhs_acc_dtkakm",-1]
// ,["hlc_muzzle_556NATO_rotexiiic_tan",-1]
// ,["muzzle_snds_m_snd_F",-1]
// ,["CUP_muzzle_snds_KZRZP_SVD",-1]
// ,["rhs_acc_pbs1",-1]
// ,["muzzle_snds_B",-1]
// ,["hlc_muzzle_TiRant9S",-1]
// ,["uk3cb_muzzle_snds_mp5",-1]
// ,["rhsusf_acc_rotex_mp7",-1]
// ,["CUP_muzzle_snds_AWM",-1]
// ,["hlc_muzzle_snds_ROTEX3P",-1]
// ,["CUP_muzzle_mfsup_SCAR_H",-1]
// ,["hlc_muzzle_556NATO_M42000",-1]
// ,["rhs_acc_dtk3",-1]
// ,["rhs_acc_ak5",-1]
// ]

// ,[]

// //HandGrenade
// ,[
//  ["ACE_M84",-1]
// ,["SmokeShell",-1]
// ,["rhssaf_mag_brd_m83_green",-1]
// ,["rhssaf_mag_brd_m83_red",-1]
// ,["SmokeShellPurple",-1]
// ,["HandGrenade",-1]
// ,["MS_Strobe_Mag_1",-1]
// ,["MS_Strobe_Mag_2",-1]
// ]

// //explosives
// ,[
//  ["SatchelCharge_Remote_Mag",-1]
// ,["DemoCharge_Remote_Mag",-1]
// ,["AMP_Breaching_Charge_Mag",-1]
// ,["ATMine_Range_Mag",-1]
// ,["APERSMine_Range_Mag",-1]
// ,["rhsusf_mine_m14_mag",-1]
// ,["APERSTripMine_Wire_Mag",-1]
// ,["APERSBoundingMine_Range_Mag",-1]
// ,["SLAMDirectionalMine_Wire_Mag",-1]
// ,["ClaymoreDirectionalMine_Remote_Mag",-1]
// ,["rhs_mine_M3_tripwire_mag",-1]
// ]

// //items
// ,[
//  ["ACE_MapTools",-1]
// ,["ACE_microDAGR",-1]
// ,["ACE_EntrenchingTool",-1]
// ,["ACE_Fortify",-1]
// ,["ToolKit",-1]
// ,["ACE_wirecutter",-1]
// ,["ACE_DefusalKit",-1]
// ,["MineDetector",-1]
// ,["ACE_M26_Clacker",-1]
// ,["ACE_Clacker",-1]
// ,["ItemAndroid",-1]
// ,["ItemcTab",-1]
// ,["ACE_CableTie",-1]
// ,["ACE_UAVBattery",-1]
// ,["ITC_Land_B_AR2i_Packed",-1]
// ,["sps_black_hornet_01_Static_F",-1]
// ,["eaf_beef_can",-1]
// ,["eaf_foul_can",-1]
// ,["eaf_fig_jam",-1]
// ,["eaf_water_bottle",-1]
// ,["ACE_Canteen",-1]
// ,["ACE_bodyBag",-1]
// ,["ACE_EarPlugs",-1]
// ,["ACE_Flashlight_MX991",-1]
// ,["ACE_RangeCard",-1]
// ,["ACE_rope12",-1]
// ,["ACE_rope15",-1]
// ,["ACE_rope18",-1]
// ,["ACE_rope27",-1]
// ,["ACE_rope36",-1]
// ,["ACE_Tripod",-1]
// ,["tfw_rf3080Item",-1]
// ,["ACE_elasticBandage",-1]
// ,["kat_guedel",-1]
// ,["ACE_packingBandage",-1]
// ,["ACE_quikclot",-1]
// ,["ACE_fieldDressing",-1]
// ,["ACE_morphine",-1]
// ,["ACE_epinephrine",-1]
// ,["ACE_bloodIV",-1]
// ,["ACE_bloodIV_250",-1]
// ,["ACE_bloodIV_500",-1]
// ,["ACE_salineIV",-1]
// ,["ACE_salineIV_250",-1]
// ,["ACE_salineIV_500",-1]
// ,["ACE_plasmaIV",-1]
// ,["ACE_plasmaIV_250",-1]
// ,["ACE_plasmaIV_500",-1]
// ,["kat_accuvac",-1]
// ,["kat_larynx",-1]
// ,["ACE_splint",-1]
// ,["ACE_tourniquet",-1]
// ,["ACE_personalAidKit",-1]
// ,["ACE_surgicalKit",-1]
// ,["ACE_ATNAA",-1]
// ,["kat_X_AED",-1]
// ,["kat_chestSeal",-1]
// ,["kat_aatKit",-1]
// ,["kat_Pulseoximeter",-1]
// ,["ACE_ATragMX",-1]
// ,["ACE_Flashlight_XL50",-1]
// ,["ACE_Kestrel4500",-1]
// ,["ACE_IR_Strobe_Item",-1]
// ,["ACE_adenosine",-1]
// ,["kat_AED",-1]
// ,["ItemcTabHCam",-1]
// ,["kat_stethoscope",-1]
// ,["MRH_TacticalDisplay",-1]
// ,["tfw_blade",-1]
// ,["tfw_whip",-1]
// ,["tfw_dd",-1]
// ,["ALIVE_Tablet",-1]
// ,["MRH_FoldedSatcomAntenna",-1]
// ,["ITC_Land_B_RemoteGLTD_Packed",-1]
// ,["ACE_HuntIR_monitor",-1]
// ,["MRH_BluForTransponder",-1]
// ]

// //bipods
// ,[
//  ["rhsusf_acc_grip2",-1]
// ,["rhsusf_acc_saw_bipod",-1]
// ,["JAS_SIG516_Rail_Cover_Right",-1]
// ,["CUP_bipod_VLTOR_Modpod",-1]
// ,["CUP_bipod_VLTOR_Modpod_black",-1]
// ,["dzn_tripod_rifle",-1]
// ,["rhsusf_acc_grip3",-1]
// ]


// //mags
// ,[
//  ["UK3CB_AK47_30Rnd_Magazine",-1]
// ,["rhs_30Rnd_545x39_7N6M_AK",-1]
// ,["CUP_30Rnd_762x39_AK47_M",-1]
// ,["grcb_30Rnd_762x39mm_polymer_mix",-1]
// ,["grcb_30Rnd_545x39_7N6M_AK_mix",-1]
// ,["grcb_mag_30Rnd_556x45_M855A1_L5",-1]
// ,["grcb_mag_30Rnd_556x45_M855A1_L5_mix",-1]
// ,["grcb_mag_30Rnd_556x45_M995_EPM",-1]
// ,["grcb_mag_30Rnd_556x45_M995_EPM_mix",-1]
// ,["grcb_mag_30Rnd_556x45_Mk318_L5",-1]
// ,["grcb_mag_30Rnd_556x45_Mk318_L5_mix",-1]
// ,["UK3CB_MP5_30Rnd_9x19_Magazine",-1]
// ,["rhs_mag_m4009",-1]
// ,["ACE_HuntIR_M203",-1]
// ,["WNZ_Taser_30Rnd_9mm_Mag",-1]
// ,["rhsusf_mag_40Rnd_46x30_AP",-1]
// ,["CUP_20Rnd_46x30_MP7",-1]
// ,["CUP_10Rnd_762x54_SVD_M",-1]
// ,["ACE_10Rnd_762x54_Tracer_mag",-1]
// ,["rhsusf_20Rnd_762x51_SR25_m118_special_Mag",-1]
// ,["grcb_20Rnd_762x51_SR25_m61_Mag",-1]
// ,["CUP_20Rnd_TE1_Red_Tracer_762x51_M110",-1]
// ,["20Rnd_762x51_Mag",-1]
// ,["ACE_10Rnd_762x51_M118LR_Mag",-1]
// ,["ACE_10Rnd_762x51_M993_AP_Mag",-1]
// ,["ACE_10Rnd_762x51_Mk319_Mod_0_Mag",-1]
// ,["ACE_20Rnd_762x51_Mag_Tracer_Dim",-1]
// ,["UK3CB_G3_20rnd_762x51_RT",-1]
// ,["CUP_-1Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",-1]
// ,["150Rnd_762x54_Box",-1]
// ,["grcb_75Rnd_762x39mm_89_mix",-1]
// ,["rhs_75Rnd_762x39mm_89",-1]
// ,["CUP_200Rnd_TE4_Green_Tracer_556x45_M249",-1]
// ,["rhsusf_200Rnd_556x45_M855_soft_pouch_coyote",-1]
// ,["ACE_20Rnd_762x51_M118LR_Mag",-1]
// ,["ACE_20Rnd_762x51_M993_AP_Mag",-1]
// ,["ACE_20Rnd_762x51_Mk319_Mod_0_Mag",-1]
// ,["ACE_20Rnd_762x51_Mag_Tracer",-1]
// ,["rhsusf_50Rnd_762x51_m61_ap",-1]
// ,["hlc_200Rnd_762x51_Mdim_M60E4",-1]
// ,["150Rnd_762x51_Box",-1]
// ,["CUP_-1Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M",-1]



// ,["rhsusf_mag_15Rnd_9x19_FMJ",-1]
// ,["hlc_15Rnd_9x19_B_P226",-1]
// ,["CUP_7Rnd_45ACP_1911",-1]
// ,["rhsusf_mag_17Rnd_9x19_FMJ",-1]
// ,["11Rnd_45ACP_Mag",-1]
// ,["WNZ_Taser_Mag_11Rnd_45ACP",-1]
// ,["CUP_16Rnd_9x19_cz75",-1]



// ,["rhs_rpg7_PG7V_mag",-1]
// ,["rhs_rpg7_PG7VL_mag",-1]
// ,["rhs_rpg7_PG7VM_mag",-1]
// ,["rhs_rpg7_PG7VS_mag",-1]
// ,["rhs_rpg7_PG7VR_mag",-1]
// ,["rhs_rpg7_OG7V_mag",-1]
// ,["rhs_rpg7_TBG7V_mag",-1]
// ,["RPG32_HE_F",-1]
// ,["RPG32_F",-1]
// ,["rhs_mag_9k38_rocket",-1]
// ,["CUP_Strela_2_M",-1]
// ,["rhs_fim92_mag",-1]
// ,["rhs_rpg7_type69_airburst_mag",-1]

// ,["rhs_mag_30Rnd_556x45_M855A1_PMAG",-1]
// ,["rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan",-1]
// ,["rhs_mag_30Rnd_556x45_M855_PMAG_Tan_Tracer_Red",-1]
// ,["rhs_30Rnd_762x39mm",-1]
// ,["rhs_30Rnd_762x39mm_tracer",-1]
// ,["rhs_30Rnd_762x39mm_polymer",-1]
// ,["rhs_30Rnd_762x39mm_89",-1]
// ,["rhsusf_200rnd_556x45_M855_box",-1]
// ,["rhs_100Rnd_762x54mmR",-1]
// ,["UK3CB_M60_100rnd_762x51",-1]

// ,["rhsusf_mag_7x45acp_MHP",-1]
// ,["UGL_FlareWhite_F",-1]
// ,["UGL_FlareGreen_F",-1]
// ,["UGL_FlareRed_F",-1]
// ,["UGL_FlareYellow_F",-1]
// ,["UGL_FlareCIR_F",-1]
// ,["rhs_mag_30Rnd_556x45_M855A1_Stanag",-1]
// ,["rhs_mag_30Rnd_556x45_M193_Stanag",-1]
// ,["UK3CB_Sten_34Rnd_Magazine",-1]
// ,["rhsusf_mag_6Rnd_M433_HEDP",-1]
// ,["rhsusf_mag_6Rnd_M397_HET",-1]
// ,["rhsusf_mag_6Rnd_M583A1_white",-1]
// ,["rhsusf_mag_6Rnd_m661_green",-1]
// ,["rhsusf_mag_6Rnd_m662_red",-1]
// ,["rhsusf_mag_6Rnd_M713_red",-1]
// ,["rhsusf_mag_6Rnd_M714_white",-1]
// ,["rhsusf_mag_6Rnd_M715_green",-1]
// ,["rhsusf_mag_6Rnd_M716_yellow",-1]
// ,["UK3CB_MP5_30Rnd_10_Magazine",-1]
// ,["rhsusf_20Rnd_762x51_m118_special_Mag",-1]
// ,["rhsusf_20Rnd_762x51_m80_Mag",-1]
// ,["5Rnd_127x108_Mag",-1]
// ,["5Rnd_127x108_APDS_Mag",-1]
// ,["ACE_5Rnd_127x99_Mag",-1]
// ,["rhsusf_mag_10Rnd_STD_50BMG_M33",-1]
// ,["rhsusf_mag_10Rnd_STD_50BMG_mk211",-1]
// ,["ACE_10Rnd_127x99_Mag",-1]
// ,["rhsusf_20Rnd_762x51_SR25_mk316_special_Mag",-1]
// ,["rhsusf_20Rnd_762x51_SR25_m62_Mag",-1]

// ,["CUP_6Rnd_FlareWhite_M203",-1]
// ,["hlc_GRD_blue",-1]
// ,["hlc_GRD_green",-1]
// ,["hlc_GRD_orange",-1]
// ,["hlc_GRD_purple",-1]
// ,["hlc_GRD_Red",-1]
// ,["hlc_GRD_White",-1]
// ,["hlc_GRD_yellow",-1]
// ,["hlc_VOG25_AK",-1]
// ,["CUP_1Rnd_HE_M203",-1]
// ,["ACE_40mm_Flare_white",-1]
// ,["ACE_40mm_Flare_ir",-1]
// ,["CUP_1Rnd_StarCluster_White_M203",-1]
// ,["CUP_1Rnd_StarFlare_White_M203",-1]
// ,["1Rnd_SmokeBlue_Grenade_shell",-1]
// ,["1Rnd_SmokeGreen_Grenade_shell",-1]
// ,["1Rnd_SmokeOrange_Grenade_shell",-1]
// ,["1Rnd_SmokePurple_Grenade_shell",-1]
// ,["1Rnd_SmokeRed_Grenade_shell",-1]
// ,["1Rnd_Smoke_Grenade_shell",-1]
// ,["1Rnd_SmokeYellow_Grenade_shell",-1]
// ,["rhs_mag_M433_HEDP",-1]
// ,["CUP_IlumFlareRed_GP25_M",-1]
// ,["CUP_IlumFlareWhite_GP25_M",-1]
// ,["CUP_IlumFlareGreen_GP25_M",-1]]


// ];

// // _names= [];
// //	 {
// //	 _names pushBack ( getText(configFile >> "CfgWeapons" >> (_x select 0) >> "displayName"));	
// //	 } forEach _weapons;
// // _names

// _this setVariable ["jna_dataList" ,_items,true];


