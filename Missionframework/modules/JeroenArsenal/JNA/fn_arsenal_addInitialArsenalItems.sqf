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
,GRLIB_arsenal_uniforms apply { [(_x select 0) , (_x select 4)]}
//vests
,GRLIB_arsenal_vests apply { [(_x select 0) ,( _x select 4)]}
//bags
,GRLIB_arsenal_backpacks apply { [(_x select 0) , (_x select 4)]}
//headgear
,GRLIB_arsenal_headgear  apply { [(_x select 0) ,( _x select 4)]}
//facewear
,GRLIB_arsenal_facegear apply { [(_x select 0) ,( _x select 4)]}
//nightvision
,GRLIB_arsenal_nightvision apply { [(_x select 0) ,( _x select 4)]}
//rangefinders
,GRLIB_arsenal_rangefinders apply { [(_x select 0) ,( _x select 4)]}
//maps
,GRLIB_arsenal_maps apply { [(_x select 0) ,( _x select 4)]}
//terminal
,GRLIB_arsenal_terminal apply { [(_x select 0) ,( _x select 4)]}
//radio
,GRLIB_arsenal_radio apply { [(_x select 0) ,( _x select 4)]}
//compass
,GRLIB_arsenal_compass apply { [(_x select 0) ,( _x select 4)]}

//watchs
,GRLIB_arsenal_watchs apply { [(_x select 0) ,( _x select 4)]}
,[]
,[]
,[]
//optics
,GRLIB_arsenal_optics apply { [(_x select 0) ,( _x select 4)]}
//flash and laser
,GRLIB_arsenal_flashlaser apply { [(_x select 0) ,( _x select 4)]}
//muzzles
,GRLIB_arsenal_muzzles apply { [(_x select 0) ,( _x select 4)]}
,[]
//HandGrenade
,GRLIB_arsenal_HandGrenade apply { [(_x select 0) ,( _x select 4)]}
//explosives
,GRLIB_arsenal_explosives apply { [(_x select 0) ,( _x select 4)]}
//items
,GRLIB_arsenal_other apply { [(_x select 0) ,( _x select 4)]}

//bipods
,GRLIB_arsenal_bipods apply { [(_x select 0) ,( _x select 4)]}
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

// ]


// //vests


// //bags
// ,

// //headgear
// ,

// //facewear


// //nightvision


// //rangefinders


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
// 
// ]

// //flash and laser
// ,[

// ]

// //muzzles
// ,[
// 
// ]

// ,[]

// //HandGrenade
// ,[

// ]

// //explosives
// ,[

// ]

// //items
// ,[

// ]

// //bipods
// ,[

// ]


// //mags
// ,[
//]


// ];

// // _names= [];
// //	 {
// //	 _names pushBack ( getText(configFile >> "CfgWeapons" >> (_x select 0) >> "displayName"));	
// //	 } forEach _weapons;
// // _names

// _this setVariable ["jna_dataList" ,_items,true];


