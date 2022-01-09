
sleep 5;

missionNameSpace setVariable ["RydFFE_FiredShells",[]];

if (isNil "RydFFE_Active") then {RydFFE_Active = true};
if (isNil "RydFFE_Manual") then {RydFFE_Manual = false};
if (isNil "RydFFE_NoControl") then {RydFFE_NoControl = []};
if (isNil "RydFFE_ArtyShells") then {RydFFE_ArtyShells = 5};
if (isNil "RydFFE_Interval") then {RydFFE_Interval = 10};
if (isNil "RydFFE_Debug") then {RydFFE_Debug = false};
if (isNil "RydFFE_FO") then {RydFFE_FO = []};
if (isNil "RydFFE_2PhWithoutFO") then {RydFFE_2PhWithoutFO = false};
if (isNil "RydFFE_OnePhase") then {RydFFE_OnePhase = false};

if (isNil ("RydFFE_Amount")) then {RydFFE_Amount = 6};
//if (isNil ("RydFFE_Disp")) then {RydFFE_Disp = 0.4};
if (isNil ("RydFFE_Acc")) then {RydFFE_Acc = 5};
if (isNil ("RydFFE_Safe")) then {RydFFE_Safe = 300};
if (isNil ("RydFFE_Monogamy")) then {RydFFE_Monogamy = true};
if (isNil ("RydFFE_ShellView")) then {RydFFE_ShellView = false};
if (isNil ("RydFFE_FOAccGain")) then {RydFFE_FOAccGain = 0.5};
if (isNil ("RydFFE_FOClass")) then {RydFFE_FOClass =
	[
	"i_spotter_f",
	"o_spotter_f",
	"b_spotter_f",
	"o_recon_jtac_f",
	"b_recon_jtac_f",
	"i_sniper_f",
	"o_sniper_f",
	"b_sniper_f",
	"i_soldier_m_f",
	"o_soldier_m_f",
	"b_g_soldier_m_f",
	"b_soldier_m_f",
	"o_recon_m_f",
	"b_recon_m_f",
	"o_soldieru_m_f",
	"i_uav_01_f",
	"i_uav_02_cas_f",
	"i_uav_02_f",
	"o_uav_01_f",
	"o_uav_02_cas_f",
	"o_uav_02_f",
	"b_uav_01_f",
	"b_uav_02_cas_f",
	"b_uav_02_f"
	]};

if (isNil "RydFFE_Add_SPMortar") then {RydFFE_Add_SPMortar = []};
if (isNil "RydFFE_Add_Mortar") then {RydFFE_Add_Mortar = []};
if (isNil "RydFFE_Add_Rocket") then {RydFFE_Add_Rocket = []};
if (isNil "RydFFE_Add_Other") then {RydFFE_Add_Other = []};
if (isNil "RydFFE_IowaMode") then {RydFFE_IowaMode = false};

RydFFE_SPMortar = ["o_mbt_02_arty_f","b_mbt_01_arty_f"] + RydFFE_Add_SPMortar;
RydFFE_Mortar = ["i_mortar_01_f","b_mortar_01_f"] + RydFFE_Add_Mortar;
RydFFE_Rocket = ["b_mbt_01_mlrs_f"] + RydFFE_Add_Rocket;
RydFFE_Ace_Mortar = ["o_mortar_01_f","o_g_mortar_01_f"];
RydFFE_rhs_Mortar = ["rhs_2b14_82mm_vmf","rhsgref_tla_2b14","rhs_2b14_82mm_vdv","rhs_2b14_82mm_msv","rhsgref_ins_2b14"];
RydFFE_UK3CB_Mortar = ["UK3CB_AAF_O_2b14_82mm", "UK3CB_ADA_O_2b14_82mm", "UK3CB_ADR_O_2b14_82mm", "UK3CB_ADG_O_2b14_82mm", "UK3CB_ADG_O_2b14_82mm_ISL", "UK3CB_ADE_O_2b14_82mm", "UK3CB_ADM_O_2b14_82mm", "UK3CB_ARD_O_2b14_82mm", "UK3CB_CHD_O_2b14_82mm", "UK3CB_CHD_W_O_2b14_82mm", "UK3CB_CW_SOV_O_Early_2b14_82mm", "UK3CB_CW_SOV_O_Early_VDV_2b14_82mm", "UK3CB_CW_SOV_O_Late_2b14_82mm", "UK3CB_CW_SOV_O_Late_VDV_2b14_82mm", "UK3CB_KDF_O_2b14_82mm", "UK3CB_NAP_O_2b14_82mm", "UK3CB_NFA_O_2b14_82mm", "UK3CB_TKM_O_2b14_82mm", "UK3CB_TKA_O_2b14_82mm"];
RydFFE_Other = [] + RydFFE_Add_Other;

_allArty = RydFFE_SPMortar + RydFFE_Mortar + RydFFE_Rocket;

	{
	_allArty = _allArty + (_x select 0)
	}
foreach RydFFE_Other;


[] call compile preprocessFile "modules\RYD_FFE\FFE_fnc.sqf";


//_allArty = [_allArty] call RydFFE_AutoConfig;

_civF = ["civ_f","civ","civ_ru","bis_tk_civ","bis_civ_special"];
_sides = [west,east,resistance];

_enemies = [];
_friends = [];
RydFFE_Fire = false;

if (isNil ("RydFFE_SVRange")) then {RydFFE_SVRange = 3000};

if (RydFFE_ShellView) then {[] spawn Shellview};

Can_See = {
	params [
    ["_looker",objNull,[objNull]],
    ["_target",objNull,[objNull]],
    ["_FOV",70,[0]]];
	if ([position _looker, getdir _looker, _FOV, position _target] call BIS_fnc_inAngleSector) then {
    	if (count (lineIntersectsSurfaces [(AGLtoASL (_looker modelToWorldVisual (_looker selectionPosition "pilot"))), getPosASL _target, _target, _looker, true, 1,"GEOM","NONE"]) > 0) exitWith {false};
    		true
			} else {
    		false
		};
};

Group_Can_See = {
	params [
    ["_group",grpNull,[grpNull ]],
    ["_target",objNull,[objNull]],
    ["_FOV",70,[0]]];
	_FOs = [];
	{	
		if (alive _x && [_x,_eVeh,150] call Can_See ) then{
			_FOs pushBack _x;
			};
	} forEach units _group;
	_FOs
};
_RydFFE_FO_atstart = RydFFE_FO;
while {RydFFE_Active} do
	{
	RydFFE_FO= _RydFFE_FO_atstart;
	if (RydFFE_Manual) then {waitUntil {sleep 0.1;((RydFFE_Fire) or not (RydFFE_Manual))};RydFFE_Fire = false};
	waitUntil {sleep 3;(combat_readiness > RydFFE_Light_Artillery_Enable_On_Combat_Readiness_Above) or (combat_readiness > RydFFE_Heavy_Artillery_Enable_On_Combat_Readiness_Above) };
	_allArty = [];
	if (combat_readiness > RydFFE_Light_Artillery_Enable_On_Combat_Readiness_Above) then {
		_allArty = _allArty + opfor_light_artillery;
	};
	if (combat_readiness > RydFFE_Heavy_Artillery_Enable_On_Combat_Readiness_Above) then {
		_allArty = _allArty + opfor_heavy_artillery;
	};
	_allArty = [_allArty] call RydFFE_AutoConfig;
	_allArty  = _allArty apply {toLower _x} ;
		{
		
		
		_side = _x;

		_eSides = [sideEnemy];
		_fSides = [sideFriendly];

			{
			_getF = _side getFriend _x;
			if (_getF >= 0.6) then
				{
				_fSides set [(count _fSides),_x]
				}
			else
				{
				_eSides set [(count _eSides),_x]
				}
			}
		foreach _sides;

		if (({((side _x) == _side)} count AllGroups) > 0) then
			{
			_artyGroups = [];
			_enemies = [];
			_friends = [];

				{
				_gp = _x;

				if ((side _gp) == _side) then
					{
					if not (_gp in RydFFE_NoControl) then
						{
							{
							if ((toLower (typeOf (vehicle _x))) in _allArty) exitWith
								{
								if not (_gp in _artyGroups) then
									{
									_artyGroups pushBack _gp
									}
								}
							}
						foreach (units _gp)
						}
					};

				_isCiv = false;
				if ((toLower (faction (leader _gp))) in _civF) then {_isCiv = true};

				if not (_isCiv) then
					{
					if (not (isNull _gp) and (alive (leader _gp))) then
						{
						if ((side _gp) in _eSides) then
							{
							if not (_gp in _enemies) then
								{
								_enemies pushBack _gp;
								}
							}
						else
							{
							if ((side _gp) in _fSides) then
								{
								if not (_gp in _friends) then
									{
									_friends pushBack _gp;
									if ( ((count RydFFE_FOClass) == 0)  or 
									count ((units _gp ) select {((toLower (typeOf (_x))) in RydFFE_FOClass)} ) > 0 ) then
										{
										if ((count RydFFE_FO) > 0) then
											{
											if not (_gp in RydFFE_FO) then
												{
												RydFFE_FO pushBack _gp
												}
											}
										}
									}
								}
							}
						}
					}
				}
			foreach allGroups;

			_knEnemies = [];

				{
					{
					_eVeh = vehicle _x;

						{
						if not ((toLower (faction (leader _x))) in _civF) then
							{
							if (((count RydFFE_FO) == 0) or (_x in RydFFE_FO)) then
								{
								//_FOs =[_x,_eVeh] call Group_Can_See;
								if ((_x knowsAbout _eVeh) >= 0.05 
								//&& count _FOs > 0
								) then
									{
									if not (_eVeh in _knEnemies) then
										{
										_eVeh setVariable ["RydFFE_MyFO",(leader _x)];
										_knEnemies pushBack _eVeh
										}
									}
								}
							}
						}
					foreach _friends
					}
				foreach (units _x)
				}
			foreach _enemies;

			_enArmor = [];

				{
				if ((_x isKindOf "Tank") or (_x isKindOf "Wheeled_APC")) then
					{
					if not (_x in _enArmor) then
						{
						_enArmor pushBack _x
						}
					}
				}
			foreach _knEnemies;


			artyGroups =_artyGroups;
			artyknEnemies = _knEnemies;
			artyenArmor = _enArmor;
			artyfriends = _friends;

			[_artyGroups,RydFFE_ArtyShells] call RYD_ArtyPrep;
			_amount = RydFFE_Amount;

			switch (true) do {
				case (combat_readiness > 30): {_amount = _amount +1 };
				case (combat_readiness > 40): {_amount = _amount +1 };
				case (combat_readiness > 50): {_amount = _amount +1 };
				case (combat_readiness > 60): {_amount = _amount +1 };
				case (combat_readiness > 70): {_amount = _amount +1 };
				case (combat_readiness > 80): {_amount = _amount +1 };
				case (combat_readiness > 90): {_amount = _amount +1 };
			};

			[_artyGroups,_knEnemies,_enArmor,_friends,RydFFE_Debug,_amount] call RYD_CFF
			}
		}
	foreach [east];

	sleep RydFFE_Interval;

	_shells = missionNameSpace getVariable ["RydFFE_FiredShells",[]];

		{
		_shell = _x;
		if (isNil "_shell") then
			{
			_shells set [_foreachIndex,0]
			}
		else
			{
			if (isNull _x) then
				{
				_shells set [_foreachIndex,0]
				}
			}
		}
	foreach _shells;

	_shells = _shells - [0];
	missionNameSpace setVariable ["RydFFE_FiredShells",_shells];
	
	};