CCC_Feed_Single_Screens = [
	["Land_TripodScreen_01_large_black_F",[0]],
	["Tactical_Screen_F",[0]],
	["Land_PCSet_01_screen_F",[0]],
	["Land_FlatTV_01_F",[0]]];
CCC_Feed_Double_Screens = [["Land_TripodScreen_01_dual_v1_black_F",[0,1]]];
CCC_Feed_Trible_Screens = [["Land_MultiScreenComputer_01_black_F",[1,2,3]]];
CCC_Feed_All_Screens = CCC_Feed_Single_Screens + CCC_Feed_Double_Screens;
[player] call CCC_addPlayerActions;
player addEventHandler ["Respawn", {[player] call CCC_addPlayerActions}];