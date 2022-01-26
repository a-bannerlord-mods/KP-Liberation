/*
    Needed Mods:
    - None

    Optional Mods:
    - BWMod
    - RHSUSAF
    - F-15C
    - F/A-18
    - CUP Weapons
    - CUP Vehicles
    - USAF Main Pack
    - USAF Fighters Pack
    - USAF Utility Pack
*/

/*
    --- Support classnames ---
    Each of these should be unique.
    The same classnames for different purposes may cause various unpredictable issues with player actions.
    Or not, just don't try!
*/

Custom_First_Names = ["Ahmed", "Mohamed", "Ziad", "Ibrahim", "Samy", "Ramy", "Hatem", "Hazem", "Adam", "Khaled", "Kareem", "Kamal", "Mahmoud", "Amir", "Islam", "Kamel", "Hassan", "Hussien", "Yasser", "Ali", "Mamdoh", "Amr", "Omar", "Marawan", "Waleed", "Ayman", "Nader"];
Custom_Last_Names = Custom_First_Names + ["Nasser", "Abo El Nasr", "Abo El Magd", "Awad", "Ryaad", "Mazen", "El Helw", "El Eskandrany", "Abbas", "Farok", "Fayez", "Galal", "Hosni", "Abdul Hadi", "Abdul Wahhab"];


blufor_flag_texture = "USP_flags\data\mideast\flag_egypt_co.paa";
FOB_typename = "Land_Cargo_HQ_V3_F";                                    // This is the main FOB HQ building.
FOB_box_typename = "B_Slingload_01_Cargo_F";                            // This is the FOB as a container.
FOB_truck_typename = "RHS_Ural_Repair_MSV_01";                                // This is the FOB as a vehicle.
Respawn_truck_typename = "B_Truck_01_medical_F";                        // This is the mobile respawn (and medical) truck.
huron_typename = "EAF_CH47";                       						// This is Spartan 01, a multipurpose mobile respawn as a helicopter.
crewman_classname = "B_crew_F";                                         // This defines the crew for vehicles.
pilot_classname = "EgyptPilot_EAF_BLACKHAWK_Gloves";                                      // This defines the pilot for helicopters.
KP_liberation_little_bird_classname = "EAF_uh60";              // These are the little birds which spawn on the Freedom or at Chimera base.
KP_liberation_boat_classname = "B_Boat_Transport_01_F";                 // These are the boats which spawn at the stern of the Freedom.
KP_liberation_loadoutbox_classname = "B_supplyCrate_F";                 // These are the box contains loadout

KP_liberation_civ_car_classname = "LOP_TAK_Civ_Hatchback";  
KP_liberation_car_armed_classname = "rhsusf_m1043_d_s_m2"; 
KP_liberation_car_unarmed_classname = "rhsusf_m1043_d_s"; 

KP_liberation_truck_classname = "RHS_Ural_Open_Flat_MSV_01";            // These are the trucks which are used in the logistic convoy system.
KP_liberation_truck_ammo_classname = "rhs_gaz66_ammo_vdv"; 
KP_liberation_truck_fuel_classname = "RHS_Ural_Fuel_VV_01"; 
KP_liberation_truck_repair_classname = "RHS_Ural_Repair_VV_01"; 

KP_liberation_small_storage_building = "ContainmentArea_02_sand_F";     // A small storage area for resources.
KP_liberation_large_storage_building = "ContainmentArea_01_sand_F";     // A large storage area for resources.
KP_liberation_recycle_building = "Land_RepairDepot_01_tan_F";           // The building defined to unlock FOB recycling functionality.
KP_liberation_air_vehicle_building = "Land_Airport_Tower_F";             // The building defined to unlock FOB air vehicle functionality.
KP_liberation_heli_slot_building = "Land_HelipadSquare_F";              // The helipad used to increase the GLOBAL rotary-wing cap.
KP_liberation_plane_slot_building = "Land_TentHangar_V1_F";             // The hangar used to increase the GLOBAL fixed-wing cap.
KP_liberation_supply_crate = "CargoNet_01_box_F";                       // This defines the supply crates, as in resources.
KP_liberation_ammo_crate = "B_CargoNet_01_ammo_F";                      // This defines the ammunition crates.
KP_liberation_fuel_crate = "CargoNet_01_barrels_F";                     // This defines the fuel crates.


/*
    --- Friendly classnames ---
    Each array below represents one of the 7 pages within the build menu.
    Format: ["vehicle_classname",supplies,ammunition,fuel],
    Example: ["B_APC_Tracked_01_AA_F",300,150,150],
    The above example is the NATO IFV-6a Cheetah, it costs 300 supplies, 150 ammunition and 150 fuel to build.
    IMPORTANT: The last element inside each array must have no comma at the end!
*/
infantry_units = [
    ["B_EGSAKA_Operator_D_01",280,0,0]                                    // Rifleman (Light)
];

light_vehicles = [
    ["UK3CB_B_M151_Jeep_Closed_HIDF",100,0,100],
	["UK3CB_CW_US_B_EARLY_M151_Jeep_Open",100,0,100],   
    ["UK3CB_CW_US_B_EARLY_M151_Jeep_HMG",100,0,100],   
    ["UK3CB_CW_US_B_EARLY_M151_Jeep_TOW",100,0,100],  

	    
    ["rhsusf_m998_d_4dr",150,0,100],                                        // M1025A2
    ["rhsusf_m998_d_2dr_fulltop",150,0,100],                                    // M1025A2 (M2)
    ["rhsusf_m998_d_4dr_halftop",150,0,100],                                  // M1025A2 (Mk19)
    
	["rhsusf_m1043_d_s",200,0,120],                                           // Strider
	["rhsusf_m1043_d_s_m2",200,0,150],                                      // Hunter (GMG)

    ["rhsusf_m1151_usarmy_d",120,0,150],                                  // Quad Bike
    ["rhsusf_m1151_m240_v1_usarmy_d",250,0,150],                                         // Prowler (AT)
    ["rhsusf_m1151_m240_v2_usarmy_d",250,0,160],                                      // Hunter (HMG)
	["rhsusf_m1151_m2_v1_usarmy_d",250,0,150],                                           // Hunter
	["rhsusf_m1151_m2_v2_usarmy_d",250,0,160],                                           // Hunter
    ["rhsusf_m1151_m2crows_usarmy_d",400,0,200],                                     // Prowler
    ["rhsusf_m1151_m2_lras3_v1_usarmy_d",400,0,200],                                      // Prowler (HMG)

    ["rhsusf_M1220_usarmy_d",400,0,250],                             
    ["rhsusf_M1220_M2_usarmy_d",400,0,250],                            // M1220 (M2)
    ["rhsusf_M1220_M153_M2_usarmy_d",700,0,300],                                // auto

	["rhsusf_M1232_usarmy_d",500,0,300],
	["rhsusf_M1232_M2_usarmy_d",500,0,300],                                      // Eagle IV  
	
    ["rhsusf_M1230_M2_usarmy_d",600,0,250],                                // M1220
	["rhsusf_M1230a1_usarmy_d",600,0,250],                          //  medical
    ["rhsusf_M1237_M2_usarmy_d",600,0,250],                          // M1220 (Mk19)

    ["rhsusf_M1117_D",600,0,250],                             // Eagle IV (FLW 100) 
    ["UK3CB_B_MaxxPro_M2_US",500,0,250]                              // M1230A1 (MEDEVAC)
    //["rhsgref_BRDM2_ins",0,0,0],                                // HEMTT Transport
    //["rhsusf_M1117_D",0,0,0]                                 // HEMTT Transport (Covered)                                         
];

heavy_vehicles = [
    ["rhsusf_m113d_usarmy_supply",500,0,400],                  // M1083A1P2 Transport
    ["rhsusf_m113d_usarmy",500,0,800],                       // M1083A1P2 Transport (Covered)
    ["rhsusf_m113d_usarmy_M240",600,0,400],               // M1083A1P2
    ["rhsusf_m113d_usarmy_medical",600,0,400],                          // M977A4 BKIT
    ["rhsusf_m113d_usarmy_MK19",600,0,400],                      // M977A4 BKIT (HMG)
    ["rhsusf_m113d_usarmy_unarmed",500,0,400],                                       // M1117 ASV
    ["rhs_bmp1p_vdv",700,0,400],                                            // UGV StomperX
    ["rhsusf_m1a1aimd_usarmy",1200,0,800],                                      // UGV Stomper (RCWS)
    ["UK3CB_B_M60A1_HIDF",800,0,500],                                 // Assault Boat
    ["UK3CB_B_M60A3_HIDF",800,0,500],                            // Speedboat Minigun
    ["LOP_IA_T55",700,0,500],                                      // Mk.V SOCOM
    ["rhs_t80u",1000,0,600],                                         // SDV
    ["rhs_t80uk",1000,0,600],                                           // SDV
    ["rhs_t90sm_tv",1200,0,700]  
];

air_vehicles = [
    // ["vtx_UH60M",0,0,0],                                             
    // ["vtx_UH60M_SLICK",0,0,0],                                             
    // ["vtx_MH60S_GAU21L",0,0,0],                                    
    // ["vtx_MH60S_Pylons",0,0,0],                  
    // ["RHS_MELB_MH6M",0,0,0],                                     
    // ["RHS_MELB_AH6M",0,0,0],                                      
    // ["vtx_MH60M",0,0,0],                          
    ["EAF_ah64",2500,0,1200],                  
    ["EAF_ka52",2200,0,1000],                                  
    ["EAFhmt",1800,0,800],                                        
    ["EAF_uh60",1500,0,800],                  
    ["EAF_CH47",2000,0,1500],  
    ["AMF_RAFALE_M_01_F",3000,0,2000],     
    ["EAF_F16_1",5000,0,3000],     
    ["EAF_C130",4000,0,3000]  
];

static_vehicles = [
    ["B_SAM_System_03_F",2500,0,200],                                   
    ["LOP_IA_Static_DSHKM", 100,0,0],
    ["LOP_IA_M119", 250,0,0],
    ["LOP_IA_Static_M2", 140,0,0],
    ["LOP_IA_ZU23", 300,0,0],
    ["RHS_Stinger_AA_pod_D", 200,0,0],
    ["RHS_M2StaticMG_D", 160,0,0],
    ["RHS_TOW_TriPod_D", 300,0,0],
    ["UK3CB_O_SearchlightAA_CSAT_B", 20,0,0],
    ["UK3CB_O_Searchlight_CSAT_B", 20,0,0],
    ["LOP_IRA_Igla_AA_pod", 250,0,0],
    ["rhssaf_army_o_metis_9k115", 300,0,0],
    ["rhssaf_army_o_nsv_tripod", 120,0,0],
    ["LOP_SYR_Kord_High", 140,0,0],
    ["rhsgref_ins_SPG9M", 180,0,0],
    ["UK3CB_NFA_O_PKM_nest_des",200,0,0]
];

buildings = [
    ["Land_Cargo_House_V1_F",0,0,0],
    ["Land_Cargo_Patrol_V1_F",0,0,0],
    ["Land_Cargo_Tower_V1_F",0,0,0],
	
	
    ["Egypt_flag",0,0,0],
    ["Egyptian_EAF_flaf",0,0,0],
    ["eaf_flag_army",0,0,0],
    ["Egypt_navy_flag",0,0,0],
    ["eaf_flag_ammo_suppies",0,0,0],
    ["eaf_flag_infantry",0,0,0],
    ["eaf_flag_engineering",0,0,0],
    ["eaf_flag_electronic_warfare",0,0,0],
    ["eaf_flag_border_guard",0,0,0],
    ["eaf_flag_artillery",0,0,0],
    ["eaf_flag_egypt",0,0,0],
    ["eaf_flag_airforce",0,0,0],
    ["eaf_flag_airforce2",0,0,0],
    ["eaf_flag_airborne",0,0,0],

    [KPLIB_alarm_speaker,0,0,0],
    ["Land_Medevac_house_V1_F",0,0,0],
    ["Land_Medevac_HQ_V1_F",0,0,0],
    ["Flag_RedCrystal_F",0,0,0],
    ["CamoNet_BLUFOR_F",0,0,0],
    ["CamoNet_BLUFOR_open_F",0,0,0],
    ["CamoNet_BLUFOR_big_F",0,0,0],
    ["Land_PortableLight_single_F",0,0,0],
    ["Land_PortableLight_double_F",0,0,0],
    ["Land_LampSolar_F",0,0,0],
    ["Land_LampHalogen_F",0,0,0],
    ["Land_LampStreet_small_F",0,0,0],
    ["Land_LampAirport_F",0,0,0],
    ["Land_HelipadCircle_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["Land_HelipadRescue_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["PortableHelipadLight_01_blue_F",0,0,0],
    ["PortableHelipadLight_01_green_F",0,0,0],
    ["PortableHelipadLight_01_red_F",0,0,0],
    ["Land_CampingChair_V1_F",0,0,0],
    ["Land_CampingChair_V2_F",0,0,0],
    ["Land_CampingTable_F",0,0,0],
    ["Land_MapBoard_F",0,0,0],
    ["Land_Pallet_MilBoxes_F",0,0,0],
    ["Land_PaperBox_open_empty_F",0,0,0],
    ["Land_PaperBox_open_full_F",0,0,0],
    ["Land_PaperBox_closed_F",0,0,0],
    ["Land_DieselGroundPowerUnit_01_F",0,0,0],
    ["Land_ToolTrolley_02_F",0,0,0],
    ["Land_WeldingTrolley_01_F",0,0,0],
    ["Land_Workbench_01_F",0,0,0],
    ["Land_GasTank_01_blue_F",0,0,0],
    ["Land_GasTank_01_khaki_F",0,0,0],
    ["Land_GasTank_01_yellow_F",0,0,0],
    ["Land_GasTank_02_F",0,0,0],
    ["Land_BarrelWater_F",0,0,0],
    ["Land_BarrelWater_grey_F",0,0,0],
    ["Land_WaterBarrel_F",0,0,0],
    ["Land_WaterTank_F",0,0,0],
    ["Land_BagFence_Round_F",0,0,0],
    ["Land_BagFence_Short_F",0,0,0],
    ["Land_BagFence_Long_F",0,0,0],
    ["Land_BagFence_Corner_F",0,0,0],
    ["Land_BagFence_End_F",0,0,0],
    ["Land_BagBunker_Small_F",0,0,0],
    ["Land_BagBunker_Large_F",0,0,0],
    ["Land_BagBunker_Tower_F",0,0,0],
    ["Land_HBarrier_1_F",0,0,0],
    ["Land_HBarrier_3_F",0,0,0],
    ["Land_HBarrier_5_F",0,0,0],
    ["Land_HBarrier_Big_F",0,0,0],
    ["Land_HBarrierWall4_F",0,0,0],
    ["Land_HBarrierWall6_F",0,0,0],
    ["Land_HBarrierWall_corner_F",0,0,0],
    ["Land_HBarrierWall_corridor_F",0,0,0],
    ["Land_HBarrierTower_F",0,0,0],
    ["Land_CncBarrierMedium_F",0,0,0],
    ["Land_CncBarrierMedium4_F",0,0,0],
    ["Land_Concrete_SmallWall_4m_F",0,0,0],
    ["Land_Concrete_SmallWall_8m_F",0,0,0],
    ["Land_CncShelter_F",0,0,0],
    ["Land_CncWall1_F",0,0,0],
    ["Land_CncWall4_F",0,0,0],
    ["Land_Sign_WarningMilitaryArea_F",0,0,0],
    ["Land_Sign_WarningMilAreaSmall_F",0,0,0],
    ["Land_Sign_WarningMilitaryVehicles_F",0,0,0],
    ["Land_Razorwire_F",0,0,0],
    ["Land_ClutterCutter_large_F",0,0,0]
// "Land_Vez", 
// "Land_Hlaska", 
// "Land_Strazni_vez", 
// "Land_Fort_Watchtower_EP1", 
// "Land_fortified_nest_small", 
// "Fort_Nest", 
// "Land_fortified_nest_big", 
// "Land_CamoNetVar_NATO_EP1", 
// "WarfareBCamp", 
// "TK_WarfareBBarrier10x_EP1", 
// "US_WarfareBBarrier10xTall_EP1", 
// "TK_WarfareBBarrier5x_EP1", 
// "Land_fort_artillery_nest_EP1", 
// "Land_CzechHedgehog_01_new_F", 
// "Land_DragonsTeeth_01_4x2_new_F", 
// "Land_LampAirport_F", 
// "Land_ControlTower_01_F", 
// "Land_GuardTower_01_F", 
// "Land_SandbagBarricade_01_hole_F", 
// "Land_SandbagBarricade_01_F", 
// "Land_SandbagBarricade_01_half_F", 
// "Land_Vez_svetla", 
// "Land_jezekbeton", 
// "Land_Airport_Tower_F"
];

support_vehicles = [
    [KP_liberation_loadoutbox_classname,10,0,0],
    [Respawn_truck_typename,200,0,100],
    [FOB_box_typename,300,500,0],
    [FOB_truck_typename,300,500,75],
    [KP_liberation_small_storage_building,0,0,0],
    [KP_liberation_large_storage_building,0,0,0],
    [KP_liberation_recycle_building,250,0,0],
    [KP_liberation_air_vehicle_building,1000,0,0],
    [KP_liberation_heli_slot_building,250,0,0],
    [KP_liberation_plane_slot_building,500,0,0],
	[KP_liberation_truck_classname,100,0,50],
	[KP_liberation_truck_fuel_classname,200,0,50],
	[KP_liberation_truck_ammo_classname,200,0,50],
    ["ACE_Wheel",10,0,0],
    ["ACE_Track",20,0,0],
    ["USAF_missileCart_W_AGM114",50,150,0],                             // Missile Cart (AGM-114)
    ["USAF_missileCart_AGMMix",50,150,0],                               // Missile Cart (AGM-65 Mix)
    ["USAF_missileCart_AGM1",50,150,0],                                 // Missile Cart (AGM-65D)
    ["USAF_missileCart_AGM2",50,150,0],                                 // Missile Cart (AGM-65E)
    ["USAF_missileCart_AGM3",50,150,0],                                 // Missile Cart (AGM-65K)
    ["USAF_missileCart_AA1",50,150,0],                                  // Missile Cart (AIM-9M/AIM-120)
    ["USAF_missileCart_AA2",50,150,0],                                  // Missile Cart (AIM-9X/AIM-120)
    ["USAF_missileCart_GBU12_green",50,150,0],                          // Missile Cart (GBU12 Green)
    ["USAF_missileCart_GBU12_maritime",50,150,0],                       // Missile Cart (GBU12 Maritime)
    ["USAF_missileCart_GBU12",50,150,0],                                // Missile Cart (GBU12)
    ["USAF_missileCart_Gbu31",50,150,0],                                // Missile Cart (GBU31)
    ["USAF_missileCart_GBU39",50,150,0],                                // Missile Cart (GBU39)
    ["USAF_missileCart_Mk82",50,150,0],                                 // Missile Cart (Mk82)
    //["B_Truck_01_Repair_F",800,0,100],                                   // HEMTT Repair
    ["B_Truck_01_fuel_F",400,0,100],                                    // HEMTT Fuel
    ["B_Truck_01_ammo_F",400,0,100],                                   // HEMTT Ammo
    ["LOP_TAK_Civ_Hatchback",80,0,50],
    ["LOP_TAK_Civ_Landrover",100,0,50],
    ["LOP_TAK_Civ_Offroad",120,0,50]
];

/*
    --- Squads ---
    Pre-made squads for the commander build menu.
    These shouldn't exceed 10 members.
*/

// Light infantry squad.
blufor_squad_inf_light = [
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01"
];

// Heavy infantry squad.
blufor_squad_inf = [
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01"
];

// AT specialists squad.
blufor_squad_at = [
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01"
];

// AA specialists squad.
blufor_squad_aa = [
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01"
];

// Force recon squad.
blufor_squad_recon = [
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01"
];

// Paratroopers squad (The units of this squad will automatically get parachutes on build)
blufor_squad_para = [
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01",
    "B_EGSAKA_Operator_D_01"
];

/*
    --- Elite vehicles ---
    Classnames below have to be unlocked by capturing military bases.
    Which base locks a vehicle is randomized on the first start of the campaign.
*/
elite_vehicles = [

];


/*
    --- Elite vehicles ---
    Classnames below have to be unlocked by capturing military bases.
    Which base locks a vehicle is randomized on the first start of the campaign.
*/
C130_halo_allowed_vehicles = [
    [FOB_box_typename,[],[],[]],
    [KP_liberation_loadoutbox_classname,[],[],[]],
    ["UK3CB_B_M151_Jeep_Closed_HIDF",[],[],[]],
	["UK3CB_CW_US_B_EARLY_M151_Jeep_Open",[],[],[]],   
    ["UK3CB_CW_US_B_EARLY_M151_Jeep_HMG",[],[],[]],   
    ["UK3CB_CW_US_B_EARLY_M151_Jeep_TOW",[],[],[]],  
    ["rhsusf_m998_d_4dr",[],[],[]],                                     
    ["rhsusf_m998_d_2dr_fulltop",[],[],[]],                                
    ["rhsusf_m998_d_4dr_halftop",[],[],[]],                             
    
	["rhsusf_m1043_d_s",[],[],[]],                                          
	["rhsusf_m1043_d_s_m2",[],[],[]],                                    

    ["rhsusf_m1151_usarmy_d",[],[],[]],                                 
    ["rhsusf_m1151_m240_v1_usarmy_d",[],[],[]],                                      
    ["rhsusf_m1151_m240_v2_usarmy_d",[],[],[]],                                
	["rhsusf_m1151_m2_v1_usarmy_d",[],[],[]],                                         
	["rhsusf_m1151_m2_v2_usarmy_d",[],[],[]],                                    
    ["rhsusf_m1151_m2crows_usarmy_d",[],[],[]],                                 
    ["rhsusf_m1151_m2_lras3_v1_usarmy_d",[],[],[]]                                    
];

blufor_transport_support_vehicles = [
    ["EAF_CH47",50],
    ["EAF_uh60",20],
    ["EAFhmt",20],

    [KP_liberation_truck_fuel_classname,10],
    [KP_liberation_truck_ammo_classname,10],
    [KP_liberation_truck_classname,10],
    ["B_Truck_01_Repair_F",10],
    ["B_Truck_01_fuel_F",10],
    ["B_Truck_01_Repair_F",10]
];

blufor_cas_support_vehicles = [
    ["EAF_ka52",50],
    ["EAF_ah64",60]
];

blufor_jet_support_vehicles = [
    ["EAF_F16_1",180],
    ["AMF_RAFALE_M_01_F",200]
];

// Military alphabet used for FOBs and convois
military_alphabet = [markerText "startbase_marker","Sadat", "Naser", "Tantawi", "Orabi", "Abo Ghazala", "Thawra", "Kahera", "25 Jan", "6 October", "Ghadab", "Zaied", "Matroh", "Allamen", "Haram", "Abo Hoal", "Sakr", "Asad", "Nemr", "Nesr", "Fahd", "Dab3", "Deeb"];
