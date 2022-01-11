


KP_Capture_Objectives = [

	[
		"farooq_ali",
		"bigtown_6",
		"capture",
		"Capture Farooq Ali",
		"Description",
		[
			"O_officer_F",
			"Farooq Ali",
			["UK3CB_ARD_O_SF_AR", "UK3CB_ARD_O_SF_ENG", "UK3CB_ARD_O_SF_MK", "UK3CB_ARD_O_SF_MG", "UK3CB_ARD_O_SF_SNI", "UK3CB_ARD_O_SF_MD", "UK3CB_ARD_O_SF_AT", "UK3CB_ARD_O_SF_GL"],
			["rhs_tigr_sts_msv", "rhs_tigr_m_msv","rhs_tigr_sts_msv"]
		],
		{	
			if (typeof _this == "O_officer_F") then {
				[_this,"asczHeadbeardyA3","ace_novoice"] call BIS_fnc_setIdentity;
			};
			//init unit
			
		},
		{	
			//condition
		},
		{	
			//onsucess
		},
		{	
			//onfail
		},
		{	
			//onsucesseffect
		},
		{	
			//onfaileffect
		}
		
	],
	[
		"abu_nawaf",
		"bigtown_5",
		"capture",
		"Capture Abu Nawaf",
		"Description",
		[
			"O_Officer_Parade_Veteran_F",
			"Abu Nawaf",
			["LOP_ISTS_OPF_Infantry_TL"],
			["LOP_ISTS_OPF_M1025_W_M2","LOP_ISTS_OPF_M998_D_4DR","LOP_ISTS_OPF_M1025_W_M2"]
		],
		{	
			//init unit
			[_this,"asczHeadloganA3","ace_novoice"] call BIS_fnc_setIdentity; 
			sleep 3;
			_this addGoggles "G_Aviator";
		},
		{	
			//condition
		},
		{	
			//onsucess
		},
		{	
			//onfail
		},
		{	
			//onsucesseffect
		},
		{	
			//onfaileffect
		}
		
	],
	[
		"michael_cohen",
		"bigtown_2",
		"capture",
		"Capture Michael Cohen",
		"Description",
		[
			"O_Officer_Parade_F",
			"Michael Cohen",
			["O_G_Soldier_universal_F"],
			["UK3CB_AAF_O_SUV_Armed", "UK3CB_AAF_O_SUV_Armoured" , "UK3CB_AAF_O_SUV_Armed"]
		],
		{	
			//init unit
			if (typeof _this == "O_Officer_Parade_F") then {
				[_this,"Face43","male03chi"] call BIS_fnc_setIdentity;
				sleep 3;
				_this addGoggles "G_Aviator";
			};
			if (typeof _this == "O_G_Soldier_universal_F") then {
				_this addGoggles "G_Bandanna_blk";
			};
			
		},
		{	
			//condition
		},
		{	
			//onsucess
		},
		{	
			//onfail
		},
		{	
			//onsucesseffect
		},
		{	
			//onfaileffect
		}
		
	]
];

KP_Rescue_Objectives = [
	[
		"haftar_jafar",
		"bigtown_3",
		"rescue",
		"Rescue Haftar Jafar",
		"description",
		[
			"B_T_Officer_F",
			"Haftar Jafar",
			["UK3CB_ARD_O_SF_AR", "UK3CB_ARD_O_SF_ENG", "UK3CB_ARD_O_SF_MK", "UK3CB_ARD_O_SF_MG", "UK3CB_ARD_O_SF_SNI", "UK3CB_ARD_O_SF_MD", "UK3CB_ARD_O_SF_AT", "UK3CB_ARD_O_SF_GL"],
			[]
		],

		{	
			//init unit
			[_this,"Ivan","ace_novoice"] call BIS_fnc_setIdentity;
		},
		{	
			//condition
		},
		{	
			//onsucess
		},
		{	
			//onfail
		},
		{	
			//onsucesseffect
		},
		{	
			//onfaileffect
		}
		
	]
];

KP_Destroy_Objectives = [
	[
		"SCUD_Destroy",
		"bigtown_1",
		"destroy",
		"Destroy SCUD",
		"description",
		[
			[scud1,scud2,scud3]
		],

		{	
			//init unit
		},
		{	
			//condition
		},
		{	
			//onsucess
		},
		{	
			//onfail
		},
		{	
			//onsucesseffect
		},
		{	
			//onfaileffect
		}
		
	]
];


KP_Objectives = KP_Capture_Objectives + KP_Rescue_Objectives + KP_Destroy_Objectives; 

