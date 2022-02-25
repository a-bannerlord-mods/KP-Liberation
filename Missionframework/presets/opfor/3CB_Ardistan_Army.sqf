/*
    Needed Mods:
    - RHS USAF
    - RHS AFRF
    - Project OPFOR

    Optional Mods:
    - None
*/
// Enemy infantry classes
opfor_flag_texture = "\UK3CB_Factions\addons\UK3CB_Factions_ARD\Flag\ARD_flag_co.paa";
opfor_flag_militia_texture = "po_main\data\UI\flags\flag_isis_co.paa";
opfor_officer = "UK3CB_ARD_O_OFF";                                     
opfor_officer_cars = ["LOP_ISTS_OPF_M998_D_4DR","LOP_ISTS_OPF_M1025_W_M2"];                                     
opfor_squad_leader = "UK3CB_ARD_O_JNR_OFF";                        // Squad Leader (Warlord)
opfor_team_leader = "UK3CB_ARD_O_RADIO";                         // Team Leader (Chief)
opfor_sentry = "UK3CB_ARD_O_RIF_2";                        // Rifleman (AKM)
opfor_rifleman = "UK3CB_ARD_O_RIF_1";                    // Rifleman (AK-74)
opfor_rpg = "UK3CB_ARD_O_AT";                                 // Rifleman (RPG-7)
opfor_grenadier = "UK3CB_ARD_O_GL";                           // Grenadier (AKM GP-25)
opfor_machinegunner = "UK3CB_ARD_O_AR";                  // Autorifleman (AR_Asst)
opfor_heavygunner = "UK3CB_ARD_O_MG";                         // Heavy Gunner (PKM)
opfor_marksman = "UK3CB_ARD_O_MK";                    // Marksman (Lee Enfield)
opfor_sharpshooter = "UK3CB_ARD_O_SPOT";                  // Sharpshooter (SVD)
opfor_sniper = "UK3CB_ARD_O_SNI";                        // Sniper (SVD)
opfor_at = "UK3CB_ARD_O_AT";                                  // AT Specialist (RPG-7)
opfor_aa = "UK3CB_ARD_O_AA";                                  // AA Specialist (RPG-7)
opfor_medic = "UK3CB_ARD_O_MD";                         // Combat Life Saver (Bonesetter)
opfor_engineer = "UK3CB_ARD_O_ENG";                      // Engineer (Bomber)
opfor_paratrooper = "UK3CB_ARD_O_SF_LAT";                               // Paratrooper (AKM PM-63)


opfor_sf_squad_leader = "UK3CB_ARD_O_SF_SL";                        // Squad Leader (Warlord)
opfor_sf_team_leader = "UK3CB_ARD_O_SF_TL";                         // Team Leader (Chief)
opfor_sf_sentry = "UK3CB_ARD_O_SF_RIF_1";                        // Rifleman (AKM)
opfor_sf_rifleman = "UK3CB_ARD_O_SF_RIF_2";                    // Rifleman (AK-74)
opfor_sf_rpg = "UK3CB_ARD_O_SF_AT";                                 // Rifleman (RPG-7)
opfor_sf_grenadier = "UK3CB_ARD_O_SF_GL";                           // Grenadier (AKM GP-25)
opfor_sf_machinegunner = "UK3CB_ARD_O_SF_AR";                  // Autorifleman (AR_Asst)
opfor_sf_heavygunner = "UK3CB_ARD_O_SF_MG";                         // Heavy Gunner (PKM)
opfor_sf_marksman = "UK3CB_ARD_O_SF_MK";                    // Marksman (Lee Enfield)
opfor_sf_at = "UK3CB_ARD_O_SF_AT";                                  // AT Specialist (RPG-7)
opfor_sf_aa = "UK3CB_ARD_O_SF_AA";                                  // AA Specialist (RPG-7)
opfor_sf_medic = "UK3CB_ARD_O_SF_MD";                         // Combat Life Saver (Bonesetter)
opfor_sf_engineer = "UK3CB_ARD_O_SF_ENG";                      // Engineer (Bomber)

opfor_JTACs = [opfor_sf_squad_leader,opfor_sf_team_leader,opfor_officer];

opfor_sf_sharpshooter = "UK3CB_ARD_O_SF_SPOT";                  // Sharpshooter (SVD)
opfor_sf_sniper = "UK3CB_ARD_O_SF_SNI";                        // Sniper (SVD)

// Enemy vehicles used by secondary objectives.
opfor_mrap = "UK3CB_ARD_O_GAZ_Vodnik";                                    // Offroad
opfor_mrap_armed = "UK3CB_ARD_O_GAZ_Vodnik_PKT";                           // Offroad (M2)
opfor_transport_helo = "UK3CB_ARD_O_Mi8";                           // Mi-8MT (Cargo)
opfor_transport_truck = "UK3CB_ARD_O_Ural";                                 // Ural-4320 (Covered)
opfor_ammobox_transport = "LOP_TKA_Ural_open";                          // Ural-4320 (Open) -> Has to be able to transport resource crates!
opfor_fuel_truck = "UK3CB_ARD_O_Ural_Fuel";                              // Ural-4320 (Fuel)
opfor_ammo_truck = "UK3CB_ARD_O_Ural_Ammo";                                // GAZ-66 (Ammo)
opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F";             // Taru Fuel Pod
opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F";             // Taru Ammo Pod
opfor_flag = "USP_FLAG_LIBYA";                                          // Flag

/* Adding a value to these arrays below will add them to a one out of however many in the array, random pick chance.
Therefore, adding the same value twice or three times means they are more likely to be chosen more often. */

/* Militia infantry. Lightweight soldier classnames the game will pick from randomly as sector defenders.
Think of them like garrison or military police forces, which are more meant to control the local population instead of fighting enemy armies. */
militia_squad = [
    "LOP_AM_OPF_Infantry_Rifleman",                                     // Rifleman (AKM)
    "LOP_AM_OPF_Infantry_Rifleman",                                     // Rifleman (AKM)
    "LOP_AM_OPF_Infantry_Rifleman_5",                                   // Rifleman (AKM-74)
    "LOP_AM_OPF_Infantry_Rifleman_5",                                   // Rifleman (AKM-74)
    "LOP_AM_OPF_Infantry_AT",                                           // Rifleman (RPG-7)
    "LOP_AM_OPF_Infantry_AR",                                           // Autorifleman (PKM)
    "LOP_AM_OPF_Infantry_Rifleman_3",                                   // Marksman (Lee Enfield)
    "LOP_AM_OPF_Infantry_Corpsman",                                     // Medic (Bonesetter)
    "LOP_AM_OPF_Infantry_Engineer"                                      // Engineer (Bomber)
];

// Militia vehicles. Lightweight vehicle classnames the game will pick from randomly as sector defenders. Can also be empty for only infantry milita.
militia_vehicles = [
    "LOP_ISTS_OPF_Landrover_M2", 
    "LOP_ISTS_OPF_Landrover_SPG9", 
    "LOP_ISTS_OPF_Nissan_PKM", 
    "LOP_ISTS_OPF_Offroad_M2", 
    "LOP_ISTS_OPF_Offroad_AT"                                            
];

// All enemy vehicles that can spawn as sector defenders and patrols at high enemy combat readiness (aggression levels).
opfor_vehicles = [
"UK3CB_ARD_O_GAZ_Vodnik_PKT", 
"UK3CB_ARD_O_Hilux_GMG", 
"UK3CB_ARD_O_Hilux_Dshkm", 
"UK3CB_ARD_O_Hilux_Pkm", 
"UK3CB_ARD_O_Hilux_Spg9", 
"UK3CB_ARD_O_UAZ_MG", 
"UK3CB_ARD_O_UAZ_SPG9", 
"UK3CB_ARD_O_T55", 
"UK3CB_ARD_O_T34", 
"UK3CB_ARD_O_BTR40_MG"
];

// All enemy vehicles that can spawn as sector defenders and patrols but at a lower enemy combat readiness (aggression levels).
opfor_vehicles_low_intensity = [
    "UK3CB_ARD_O_GAZ_Vodnik_PKT", 
    "UK3CB_ARD_O_Hilux_GMG", 
    "UK3CB_ARD_O_Hilux_Dshkm", 
    "UK3CB_ARD_O_Hilux_Pkm", 
    "UK3CB_ARD_O_Hilux_Spg9",  
    "UK3CB_ARD_O_UAZ_MG", 
    "UK3CB_ARD_O_UAZ_SPG9", 
    "UK3CB_ARD_O_T55", 
    "UK3CB_ARD_O_T34", 
    "UK3CB_ARD_O_BTR40", 
    "UK3CB_ARD_O_BTR40_MG"
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at high enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles = [
    "UK3CB_ARD_O_T72A", 
    "UK3CB_ARD_O_T72B", 
    "UK3CB_ARD_O_T72BM", 
    "UK3CB_ARD_O_T72BA", 
    "UK3CB_ARD_O_T72BB", 
    "UK3CB_ARD_O_T72BC", 
    "UK3CB_ARD_O_BMP2", 
    "UK3CB_ARD_O_BMP2K", 
    "UK3CB_ARD_O_BTR60", 
    "UK3CB_ARD_O_BTR70", 
    "UK3CB_ARD_O_BTR80", 
    "UK3CB_ARD_O_BTR80a",
    "UK3CB_ARD_O_2S6M_Tunguska", 
    "UK3CB_ARD_O_ZsuTank"
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at lower enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles_low_intensity = [
    "UK3CB_ARD_O_BRDM2", 
    "UK3CB_ARD_O_BRDM2_ATGM", 
    "UK3CB_ARD_O_GAZ_Vodnik_Cannon", 
    "UK3CB_ARD_O_GAZ_Vodnik_KVPT", 
    "UK3CB_ARD_O_Hilux_Zu23",
    "UK3CB_ARD_O_2S6M_Tunguska", 
    "UK3CB_ARD_O_MTLB_ZU23", 
    "UK3CB_ARD_O_BTR80a", 
    "UK3CB_ARD_O_BTR80", 
    "UK3CB_ARD_O_BTR70", 
    "UK3CB_ARD_O_BTR60", 
    "UK3CB_ARD_O_BMP2", 
    "UK3CB_ARD_O_T55", 
    "UK3CB_ARD_O_T34",
    "UK3CB_ARD_O_Ural", 
    "UK3CB_ARD_O_Ural_Open", 
    "UK3CB_ARD_O_Zil131_Open", 
    "UK3CB_ARD_O_Zil131_Covered" ,
    "UK3CB_ARD_O_BTR40", 
    "UK3CB_ARD_O_BTR40_MG",
    "UK3CB_ARD_O_MTLB_ZU23", 
    "UK3CB_ARD_O_Ural_Zu23"
];


opfor_tanks = [
    "UK3CB_ARD_O_T55", 
    "UK3CB_ARD_O_T34",
    "UK3CB_ARD_O_T72A", 
    "UK3CB_ARD_O_T72B", 
    "UK3CB_ARD_O_T72BM", 
    "UK3CB_ARD_O_T72BA", 
    "UK3CB_ARD_O_T72BB", 
    "UK3CB_ARD_O_T72BC"
];

opfor_aa_vehicles = [
    "UK3CB_ARD_O_2S6M_Tunguska", 
    "UK3CB_ARD_O_ZsuTank",
    "UK3CB_ARD_O_Hilux_Zu23",
    "UK3CB_ARD_O_2S6M_Tunguska", 
    "UK3CB_ARD_O_MTLB_ZU23"
];

/* All vehicles that spawn within battlegroups (see the above 2 arrays) and also hold 8 soldiers as passengers.
If something in this array can't hold all 8 soldiers then buggy behaviours may occur.    */
opfor_troup_transports = [
    "UK3CB_ARD_O_BRDM2", 
    "UK3CB_ARD_O_BRDM2_ATGM", 
    "UK3CB_ARD_O_MTLB_ZU23",
    "UK3CB_ARD_O_BMP1", 
    "UK3CB_ARD_O_BMP2", 
    "UK3CB_ARD_O_BMP2K", 
    "UK3CB_ARD_O_BRM1K", 
    "UK3CB_ARD_O_BTR40", 
    "UK3CB_ARD_O_BTR40_MG", 
    "UK3CB_ARD_O_BTR60", 
    "UK3CB_ARD_O_BTR70", 
    "UK3CB_ARD_O_BTR80", 
    "UK3CB_ARD_O_BTR80a", 
    "UK3CB_ARD_O_MTLB_PKT", 
    "UK3CB_ARD_O_Ural", 
    "UK3CB_ARD_O_Ural_Open", 
    "UK3CB_ARD_O_Zil131_Open", 
    "UK3CB_ARD_O_Zil131_Covered",
    "UK3CB_ARD_O_Mi8AMT", 
    "UK3CB_ARD_O_Mi8",
    "UK3CB_MDF_O_C130J"                                
];

// Enemy rotary-wings that will need to spawn in flight.
opfor_choppers = [
    "UK3CB_ARD_O_Mi_24P", 
    "UK3CB_ARD_O_Mi_24V", 
    "UK3CB_ARD_O_Mi8AMTSh", 
    "UK3CB_ARD_O_Mi8AMT",
    "UK3CB_ARD_O_Mi8"  
];

// Enemy fixed-wings that will need to spawn in the air.
opfor_air = [
    "UK3CB_ARD_O_MIG29S", 
    "UK3CB_ARD_O_MIG29SM", 
    "UK3CB_ARD_O_Su25SM_CAS", 
    "UK3CB_ARD_O_Su25SM_Cluster", 
    "UK3CB_ARD_O_Su25SM_KH29",
    "UK3CB_MDF_O_C130J"
];

opfor_air_fighter = [
    "UK3CB_ARD_O_MIG29S", 
    "UK3CB_ARD_O_MIG29SM"
];

opfor_military_AP_mine = [
    "ModuleMine_APERSMine_F",
    "rhs_mine_a200_dz35_module",
    "rhs_mine_M7A2_module",
    "rhs_mine_a200_bz_module",
    "rhs_mine_pfm1_module",
    "rhs_mine_pmn2_module"
];

opfor_military_AP_tripwires = [
"ModuleMine_APERSTripMine_F",
"rhs_mine_m2a3b_trip_module",
"rhs_mine_M3_tripwire_module"
];

// Enemy SAM sites 
opfor_SAM = [
    //["RadarClass","LauncherClass"]
    ["O_Radar_System_02_F","O_SAM_System_3000_M"]
    //["O_Radar_System_02_F","O_SAM_System_04_F"]
];

opfor_search_light = "UK3CB_ARD_O_Searchlight";

// Enemy light Artillery  (mortars)
opfor_light_artillery = [
    "rhsgref_tla_2b14"
];

opfor_artillery_ammo = createHashMap;

opfor_artillery_ammo set ["rhsgref_tla_2b14",
    [
        ["rhs_mag_3vo18_10", "HE",600,3000,20]
    ]
];
opfor_artillery_ammo set ["rhs_2s3_tv",
    [
        ["rhs_mag_HE_2a33", "HE",2500,5000,80],
        ["rhs_mag_WP_2a33", "HE",2500,5000,80],
        ["rhs_mag_LASER_2a33", "LASER",2500,5000,90],
        ["rhs_mag_SMOKE_2a33", "SMOKE",2000,5000,30],
        ["rhs_mag_ILLUM_2a33", "FLARE",2000,5000,10]
    ]
];

// Enemy heavy Artillery 
opfor_heavy_artillery = [
    "rhs_2s3_tv"
];

opfor_cram_systems = [
    "UK3CB_ARD_O_2S6M_Tunguska"
];

// Enemy static guns
opfor_static_guns = [
    "LOP_ISTS_OPF_Static_DSHKM", 
    "LOP_ISTS_OPF_Kord_High", 
    "LOP_ISTS_OPF_Static_M2",
    "UK3CB_ARD_O_PKM_nest_des"
];

opfor_AT_static_guns = [
    "LOP_ISTS_OPF_Static_AT4", 
    "LOP_ISTS_OPF_Static_SPG9",
    "rhs_Kornet_9M133_2_msv"
];

opfor_AA_static_guns = [
    "LOP_ISTS_OPF_Igla_AA_pod", 
    "LOP_TKA_ZU23"
];

opfor_heavy_static_guns =[
    "LOP_TKA_ZU23",
    "UK3CB_ARD_O_PKM_nest_des"
];