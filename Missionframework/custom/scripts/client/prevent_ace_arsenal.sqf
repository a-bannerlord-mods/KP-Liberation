
ace_arsenal_displayOpened = {
    if (getPlayerUID player in KP_liberation_commander_actions) then {
        
    } else {
        (_this select 0) closeDisplay 1;
    };
};
["ace_arsenal_displayOpened", ace_arsenal_displayOpened] call CBA_fnc_addEventHandler; 


//[["rhs_GDM40",1],["rhs_GRD40_Green",1],["rhs_GRD40_Red",1],["rhs_GRD40_White",1],["",0],["",0],["",0],["",0],["",0],["",0],["rhs_VG40TB",1],["rhs_VG40SZ",1],["",0],["",0],["UGL_FlareCIR_F",1],["UGL_FlareRed_F",1],["UGL_FlareWhite_F",1],["UGL_FlareYellow_F",1],["UGL_FlareGreen_F",1],["rhs_VOG25P",1],["ACE_40mm_Flare_white",1],["rhs_mag_M583A1_white",1],["rhs_mag_M585_white_cluster",1],["ACE_40mm_Flare_green",1],["ACE_40mm_Flare_red",1],["rhs_mag_M663_green_cluster",1],["ACE_HuntIR_M203",1],["rhs_mag_m716_yellow",1],["ACE_40mm_Flare_ir",1],["1Rnd_SmokeBlue_Grenade_shell",1],["1Rnd_SmokeGreen_Grenade_shell",1],["1Rnd_SmokeOrange_Grenade_shell",1],["1Rnd_SmokeRed_Grenade_shell",1],["1Rnd_SmokePurple_Grenade_shell",1],["1Rnd_Smoke_Grenade_shell",1],["1Rnd_SmokeYellow_Grenade_shell",1],["rhs_mag_M664_red_cluster",1],["Tier1_20Rnd_9x19_JHP",20],["Tier1_20Rnd_9x19_FMJ",20],["Tier1_15Rnd_9x19_JHP",15],["9Rnd_45ACP_Mag",8],["rhsusf_mag_7x45acp_MHP",7],["10Rnd_762x54_Mag",10],["ACE_10Rnd_762x54_Tracer_mag",10]]