///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

SIDE_PLAYER_WEST = FALSE; SIDE_PLAYER_EAST = FALSE; SIDE_PLAYER_AAF = FALSE;

///////////////// COMMON \\\\\\\\\\\\\\\\\\

BTC_refill_ammo =
{
	_array = _this select 0;
	_refill_time = _this select 1;
	{
		private ["_box","_cargo","_weapon_type"];
		_box = _x select 0;
		//_box allowDamage false;
		ClearWeaponCargo _box;ClearMagazineCargo _box;ClearItemCargo _box;
		_cargo = _x select 1;
		for "_i" from 0 to (count _cargo - 1) do 
		{
			_weapon_type = getNumber (configFile >> "cfgWeapons" >> ((_cargo select _i) select 0) >> "type");
			switch (true) do
			{
				case ((isClass (configFile >> "cfgWeapons" >> ((_cargo select _i) select 0))) && (_weapon_type in [1,2,4,5,4096])) : {_box addWeaponCargo (_cargo select _i);};
				case (isClass (configFile >> "cfgMagazines" >> ((_cargo select _i) select 0))) : {_box addMagazineCargo (_cargo select _i);};
				case ((isClass (configFile >> "cfgWeapons" >> ((_cargo select _i) select 0))) && (!(_weapon_type in [1,2,4,5,4096]))) : {_box addItemCargo (_cargo select _i);};
			};
		};
		player reveal _box;
	} foreach _array;
	sleep _refill_time;
	_refill = [_array,_refill_time] spawn BTC_refill_ammo;
};

BTC_heal_player =
{
titletext ["Healing player...","PLAIN"];
player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 3; 
player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 4; 
player Setdammage 0;
titletext ["Healing player complete!","PLAIN"];
sleep 5;
titletext ["","PLAIN"];
};

BTC_primary_wep_sadr =
{		
		titletext ["Equipping SADR rifle!","BLACK OUT"];
		sleep 1;
		removeAllWeapons player;
		{player addMagazine "20Rnd_556x45_UW_mag"} foreach [1,2,3,4,5,6,7,8,9,10];
		player addWeapon "arifle_SDAR_F";
		player selectWeapon "arifle_SDAR_F";
		if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
		sleep 1;
		titletext ["Change DONE","BLACK IN"];
		sleep 1;
		titletext ["","PLAIN"];
};


switch (BTC_side_enemy) do
{	
	case 0 :{SIDE_PLAYER_WEST = TRUE; SIDE_PLAYER_EAST = FALSE; SIDE_PLAYER_AAF = FALSE;};
	case 1 :{SIDE_PLAYER_WEST = TRUE; SIDE_PLAYER_EAST = FALSE; SIDE_PLAYER_AAF = FALSE;};
	case 2 :{SIDE_PLAYER_WEST = TRUE; SIDE_PLAYER_EAST = FALSE; SIDE_PLAYER_AAF = FALSE;};
	case 3 :{SIDE_PLAYER_WEST = FALSE; SIDE_PLAYER_EAST = TRUE; SIDE_PLAYER_AAF = FALSE;};
	case 4 :{SIDE_PLAYER_WEST = FALSE; SIDE_PLAYER_EAST = TRUE; SIDE_PLAYER_AAF = FALSE;};
	case 5 :{SIDE_PLAYER_WEST = FALSE; SIDE_PLAYER_EAST = TRUE; SIDE_PLAYER_AAF = FALSE;};
	case 6 :{SIDE_PLAYER_WEST = FALSE; SIDE_PLAYER_EAST = FALSE; SIDE_PLAYER_AAF = TRUE;};
	case 7 :{SIDE_PLAYER_WEST = FALSE; SIDE_PLAYER_EAST = FALSE; SIDE_PLAYER_AAF = TRUE;};
};

BTC_prim_wep_65_snip	= "srifle_LRR_F";
BTC_prim_wep_65_h_snip	= "srifle_GM6_F";
BTC_prim_opt_snip	= "optic_SOS"; // "optic_MRCO","optic_NVS","optic_tws"

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

// CASE: NATO
If (SIDE_PLAYER_WEST) then 
{
//Ammo
BTC_mag_30rnd  	= "30Rnd_65x39_caseless_mag";
BTC_mag_30rndT 	= "30Rnd_65x39_caseless_mag_Tracer";
BTC_mag_30rndS 	= "30Rnd_556x45_Stanag";
BTC_mag_20rnd  	= "20Rnd_762x51_Mag";
BTC_Back_LAT	= "NLAW_F";
BTC_Back_AA		= "Titan_AA";
BTC_Ammo_LMG	= "200Rnd_65x39_cased_Box";
BTC_Ammo_LMG2	= "200Rnd_65x39_cased_Box_Tracer";
BTC_Ammo_HMG	= "150Rnd_762x51_Box";
BTC_Ammo_HMG2	= "150Rnd_762x51_Box_Tracer";
BTC_Back_S408	= "7Rnd_408_Mag";
BTC_Back_S127	= "5Rnd_127x108_Mag";
BTC_granade		= "HandGrenade";
BTC_smoke		= "SmokeShellBlue";
//Weapon
BTC_prim_wep_65_TL = "arifle_MX_GL_F";
BTC_prim_wep_65	= "arifle_MX_F";
BTC_prim_wep_556= "arifle_Mk20_plain_F";
BTC_MG_light	= "arifle_MX_SW_F";
BTC_MG_ammo		= "100Rnd_65x39_caseless_mag";
BTC_MG_65		= "LMG_Mk200_F";
BTC_MG_65_ammo	= "200Rnd_65x39_cased_Box";
BTC_MG_762		= "LMG_Zafir_F";
BTC_MG_762_ammo	= "150Rnd_762x51_Box";
BTC_prim_opt	= "optic_Hamr";
//uniform
BTC_landsuite 	= "U_B_CombatUniform_mcam";
BTC_carrier		= "V_PlateCarrierGL_rgr";
BTC_Night_vis	= "NVGoggles";
BTC_helmet		= "H_HelmetB";
BTC_wetsuite	= "U_B_Wetsuit";
BTC_Rebreather 	= "V_RebreatherB";
BTC_Dive_goog	= "G_Diving";
BTC_ghilliesuit	= "U_B_GhillieSuit";
//Backpacks
BTC_Back_EXP	= "B_Bergen_mcamo";
BTC_backpack	= "B_AssaultPack_mcamo";
BTC_Dive_back	= "B_AssaultPack_blk";
BTC_Back_small 	= "B_AssaultPack_mcamo";
BTC_Back_big	= "B_Carryall_mcamo";
BTC_Parachute	= "B_Parachute";
BTC_Back_medic	= "B_Kitbag_mcamo";
BTC_Back_HAT	= "B_Bergen_mcamo";
BTC_Back_LMG	= "B_AssaultPack_mcamo";
BTC_Back_Snip	= "B_Carryall_mcamo";
//Explosives
BTC_Ammo_EXP	= ["SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","APERSBoundingMine_Range_Mag"];
BTC_Back_mine 	= ["APERSTripMine_Wire_Mag","APERSBoundingMine_Range_Mag"];
//Box
BTC_Box_Grenade = "Box_NATO_Grenades_F";
BTC_Box_Weapon	= "Box_NATO_WpsSpecial_F";
BTC_Box_launch	= "Box_NATO_WpsLaunch_F";
};

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

// CASE: CSAT
If (SIDE_PLAYER_EAST) then 
{
//Ammo
BTC_mag_30rnd  	= "30Rnd_65x39_caseless_green";
BTC_mag_30rndT 	= "30Rnd_65x39_caseless_green_mag_Tracer";
BTC_mag_30rndS 	= "30Rnd_556x45_Stanag";
BTC_mag_20rnd  	= "20Rnd_762x51_Mag";
BTC_Back_LAT	= "RPG32_F";
BTC_Back_AA		= "Titan_AA";
BTC_Ammo_LMG	= "200Rnd_65x39_cased_Box";
BTC_Ammo_LMG2	= "200Rnd_65x39_cased_Box_Tracer";
BTC_Ammo_HMG	= "150Rnd_762x51_Box";
BTC_Ammo_HMG2	= "150Rnd_762x51_Box_Tracer";
BTC_Back_S408	= "7Rnd_408_Mag";
BTC_Back_S127	= "5Rnd_127x108_Mag";
BTC_granade		= "HandGrenade";
BTC_smoke		= "SmokeShellRed";
//Weapon
BTC_prim_wep_65_TL = "arifle_Katiba_GL_F";
BTC_prim_wep_65	= "arifle_Katiba_F";
BTC_prim_wep_556= "arifle_Mk20_F";
BTC_MG_light	= "arifle_MX_SW_F";
BTC_MG_ammo		= "100Rnd_65x39_caseless_mag";
BTC_MG_65		= "LMG_Mk200_F";
BTC_MG_65_ammo	= "200Rnd_65x39_cased_Box";
BTC_MG_762		= "LMG_Zafir_F";
BTC_MG_762_ammo	= "150Rnd_762x51_Box";
BTC_prim_opt	= "optic_Arco";
//uniform
BTC_landsuite 	= "U_O_CombatUniform_ocamo";
BTC_carrier		= "V_HarnessOGL_brn";
BTC_Night_vis	= "NVGoggles_OPFOR";
BTC_helmet		= "H_HelmetLeaderO_ocamo";
BTC_wetsuite	= "U_O_Wetsuit";
BTC_Rebreather 	= "V_RebreatherIR";
BTC_Dive_goog	= "G_Diving";
BTC_ghilliesuit = "U_O_GhillieSuit";
//Backpacks
BTC_Back_EXP	= "B_TacticalPack_ocamo";
BTC_backpack	= "B_AssaultPack_ocamo";
BTC_Dive_back	= "B_AssaultPack_blk";
BTC_Back_small 	= "B_AssaultPack_rgr";
BTC_Back_big	= "B_Carryall_ocamo";
BTC_Parachute	= "B_Parachute";
BTC_Back_medic	= "B_FieldPack_ocamo";
BTC_Back_HAT	= "B_TacticalPack_ocamo";
BTC_Back_LMG	= "B_TacticalPack_ocamo";
BTC_Back_Snip	= "B_Carryall_ocamo";
//Explosives
BTC_Ammo_EXP	= ["SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","APERSBoundingMine_Range_Mag"];
BTC_Back_mine 	= ["APERSTripMine_Wire_Mag","APERSBoundingMine_Range_Mag"];
//Box
BTC_Box_Grenade = "Box_East_AmmoOrd_F";
BTC_Box_Weapon	= "Box_East_WpsSpecial_F";
BTC_Box_launch	= "Box_NATO_WpsLaunch_F";
};

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

// CASE: AAF
If (SIDE_PLAYER_AAF) then 
{
//Ammo
BTC_mag_30rnd  	= "30Rnd_65x39_caseless_green";
BTC_mag_30rndT 	= "30Rnd_556x45_Stanag_Tracer_Green";
BTC_mag_30rndS 	= "30Rnd_556x45_Stanag";
BTC_mag_20rnd  	= "20Rnd_762x51_Mag";
BTC_Back_LAT	= "RPG32_F";
BTC_Back_AA		= "Titan_AA";
BTC_Ammo_LMG	= "200Rnd_65x39_cased_Box";
BTC_Ammo_LMG2	= "200Rnd_65x39_cased_Box_Tracer";
BTC_Ammo_HMG	= "150Rnd_762x51_Box";
BTC_Ammo_HMG2	= "150Rnd_762x51_Box_Tracer";
BTC_Back_S408	= "7Rnd_408_Mag";
BTC_Back_S127	= "5Rnd_127x108_Mag";
BTC_granade		= "HandGrenade";
BTC_smoke		= "SmokeShellGreen";
//Weapon
BTC_prim_wep_65_TL = "arifle_Katiba_GL_F";
BTC_prim_wep_65	= "arifle_Katiba_F";
BTC_prim_wep_556= "arifle_Mk20C_F";
BTC_MG_light	= "arifle_MX_SW_F";
BTC_MG_ammo		= "100Rnd_65x39_caseless_mag";
BTC_MG_65		= "LMG_Mk200_F";
BTC_MG_65_ammo	= "200Rnd_65x39_cased_Box";
BTC_MG_762		= "LMG_Zafir_F";
BTC_MG_762_ammo	= "150Rnd_762x51_Box";
BTC_prim_opt	= "optic_Arco";

//uniform
BTC_landsuite 	= "U_I_CombatUniform";
BTC_landghillie	= "U_I_GhillieSuit";
BTC_carrier		= "V_PlateCarrierIA1_dgtl";
BTC_Night_vis	= "NVGoggles_INDEP";
BTC_helmet		= "H_HelmetIA";
BTC_wetsuite	= "U_I_Wetsuit";
BTC_Rebreather 	= "V_RebreatherIA";
BTC_Dive_goog	= "G_Diving";
BTC_ghilliesuit = "U_I_GhillieSuit";
//Backpacks
BTC_Back_EXP	= "B_Bergen_rgr";
BTC_backpack	= "B_AssaultPack_sgg";
BTC_Dive_back	= "B_AssaultPack_blk";
BTC_Back_small 	= "B_FieldPack_oli";
BTC_Back_big	= "B_Carryall_oli";
BTC_Parachute	= "B_Parachute";
BTC_Back_medic	= "B_FieldPack_oli";
BTC_Back_HAT	= "B_Bergen_rgr";
BTC_Back_LMG	= "B_TacticalPack_oli";
BTC_Back_Snip	= "B_Carryall_oli";
//Explosives
BTC_Ammo_EXP	= ["SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","APERSBoundingMine_Range_Mag"];
BTC_Back_mine 	= ["APERSTripMine_Wire_Mag","APERSBoundingMine_Range_Mag"];
//Box
BTC_Box_Grenade = "Box_IND_AmmoOrd_F";
BTC_Box_Weapon	= "Box_IND_WpsSpecial_F";
BTC_Box_launch	= "Box_IND_WpsLaunch_F";
};

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////




//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// PRIMARY RIFLE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////////////////////////////////////////////////////////////////
	BTC_primary_wep_65_GL =
	{
			titletext ["Equipping FACTION rifle!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_mag_30rnd} foreach [1,2,3,4,5,6,7,8,9,10,11,12];
			{player addMagazine BTC_granade} foreach [1,2];
			{player addMagazine BTC_smoke} foreach [1,2];
			{player addMagazine "1Rnd_HE_Grenade_shell"} foreach [1,2,3,4,5];
			player addWeapon BTC_prim_wep_65_TL; //arifle_MX_GL_ACO_F
			player selectWeapon BTC_prim_wep_65_TL;
			player addPrimaryWeaponItem BTC_prim_opt;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
	

	BTC_primary_wep_65 =
	{
			titletext ["Equipping FACTION rifle!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_mag_30rnd} foreach [1,2,3,4,5,6,7,8,9,10,11,12];
			{player addMagazine BTC_granade} foreach [1,2,3];
			{player addMagazine BTC_smoke} foreach [1,2,3];
			player addWeapon BTC_prim_wep_65;
			player selectWeapon BTC_prim_wep_65;
			player addPrimaryWeaponItem BTC_prim_opt;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
	
	BTC_primary_wep_556 =
	{
			titletext ["Equipping FACTION rifle!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_mag_30rndS} foreach [1,2,3,4,5,6,7,8,9,10,11,12];
			{player addMagazine BTC_granade} foreach [1,2,3];
			{player addMagazine BTC_smoke} foreach [1,2,3];
			player addWeapon BTC_prim_wep_556;
			player selectWeapon BTC_prim_wep_556;
			player addPrimaryWeaponItem BTC_prim_opt;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
///////////////////// MACHINE GUNNER \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\	
	BTC_mg65_litgh =
	{
			titletext ["Equipping FACTION MG!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_MG_ammo} foreach [1,2,3,4,5,6];
			player addWeapon BTC_MG_light;
			player selectWeapon BTC_MG_light;
			player addPrimaryWeaponItem BTC_prim_opt;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
	
	BTC_mg65_wep =
	{
			titletext ["Equipping FACTION MG!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_MG_65_ammo} foreach [1,2,3,4];
			player addWeapon BTC_MG_65;
			player selectWeapon BTC_MG_65;
			player addPrimaryWeaponItem BTC_prim_opt;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
	
	BTC_mg762_wep =
	{
			titletext ["Equipping FACTION MG!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_MG_762_ammo} foreach [1,2,3,4];
			player addWeapon BTC_MG_762;
			player selectWeapon BTC_MG_762;
			player addPrimaryWeaponItem BTC_prim_opt;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
////////////////////////////////////////////////////////////////////////////////////

///////////////////// SNIPERS RIFLES \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	BTC_primary_wep_snip =
	{
			titletext ["Equipping SNIPER rifle!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_Back_S408} foreach [1,2,3,4,5,6,7,8,9,10];
			{player addMagazine BTC_smoke} foreach [1,2,3,4,5];
			player addWeapon BTC_prim_wep_65_snip;
			player selectWeapon BTC_prim_wep_65_snip;
			player addPrimaryWeaponItem BTC_prim_opt_snip;
			player addWeapon "laserdesignator"; player assignItem "laserdesignator"; player addMagazine "Laserbatteries";
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
	
	BTC_primary_wep_H_snip =
	{
			titletext ["Equipping SNIPER rifle!","BLACK OUT"];
			sleep 1;
			removeAllWeapons player;
			{player addMagazine BTC_Back_S127} foreach [1,2,3,4,5,6,7,8,9,10];
			{player addMagazine BTC_smoke} foreach [1,2,3,4,5];
			player addWeapon BTC_prim_wep_65_h_snip;
			player selectWeapon BTC_prim_wep_65_h_snip;
			player addPrimaryWeaponItem BTC_prim_opt_snip;
			player addWeapon "laserdesignator"; player assignItem "laserdesignator"; player addMagazine "Laserbatteries";
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			titletext ["Change DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];
	};
////////////////////////////////////////////////////////////////////////////////////	
	
	
//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// UNIFORMS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////////////////////////////////////////////////////////////////

	BTC_std_soldier =
	{		//this removeAction 0; clearAllItemsFromBackpack this; this addAction ["<t color='#966f39'>Togli Muta SUB</t>","_nul = [] spawn BTC_soldier"]; this allowDamage false; 
		titletext ["Dressing wet suit...","BLACK OUT"];
		_uniform = uniform player;
		sleep 1;
		titletext ["Change suit...","BLACK FADED"];
		removeuniform player; removevest player; removeheadgear player;	removeBackPack player;
		if ((_uniform == "U_B_Wetsuit")||(_uniform == "U_I_Wetsuit")||(_uniform == "U_O_Wetsuit"))
		then {removegoggles player; player addGoggles "G_Tactical_Clear"; player assignItem "G_Tactical_Clear";	};
		player addUniform BTC_landsuite; player addVest BTC_carrier; player addItem BTC_Night_vis; player assignItem BTC_Night_vis;	player addBackPack BTC_backpack;		player addItem BTC_helmet; player assignItem BTC_helmet;
		if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
		sleep 1;
		titletext ["Change suit DONE","BLACK IN"];
		sleep 1;
		titletext ["","PLAIN"];
	};

	BTC_std_diver =
	{		//this removeAction 0; clearAllItemsFromBackpack this; this addAction ["<t color='#528ad8'>Prendi Muta SUB</t>","_nul = [] spawn BTC_diver"]; this allowDamage false; 
			_uniform = uniform player;
			if ((_uniform == "U_B_Wetsuit")||(_uniform == "U_I_Wetsuit")||(_uniform == "U_O_Wetsuit"))
			exitwith {titletext ["You have the diving wet suit!","PLAIN"];};
			titletext ["Dressing Diving suite...","BLACK OUT"];
			sleep 1; 
			removeuniform player;
			removevest player;
			removeheadgear player;
			removegoggles player;
			removeBackPack player;
			titletext ["Change suit...","BLACK FADED"];
			player addUniform BTC_wetsuite;	player addVest BTC_Rebreather; player addGoggles BTC_Dive_goog; player addBackPack BTC_Dive_back;
			if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
			sleep 1;
			titletext ["Change suit DONE","BLACK IN"];
			sleep 1;
			titletext ["","PLAIN"];	
	};

	BTC_std_sniper =
	{		//this removeAction 0; clearAllItemsFromBackpack this; this addAction ["<t color='#966f39'>Togli Muta SUB</t>","_nul = [] spawn BTC_soldier"]; this allowDamage false; 
		titletext ["Dressing ghillie suit...","BLACK OUT"];
		_uniform = uniform player;
		sleep 1;
		titletext ["Change suit...","BLACK FADED"];
		removeuniform player; 
		removevest player; 
		removeheadgear player;	
		removeBackPack player; 
		removegoggles player;
		player addUniform BTC_ghilliesuit; 
		player addVest BTC_carrier; 
		player addItem BTC_Night_vis; 
		player assignItem BTC_Night_vis;	
		player addWeapon "laserdesignator"; player assignItem "laserdesignator"; player addMagazine "Laserbatteries";
		if !(player hasWeapon "FirstAidKit") then {player addItem "FirstAidKit";};
		sleep 1;
		titletext ["Change suit DONE","BLACK IN"];
		sleep 1;
		titletext ["","PLAIN"];
	};
	
	
//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// BACKPACKS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////////////////////////////////////////////////////////////////
	
	BTC_give_small_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_small;
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_big_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino GRANDE</t>","_nul = [] spawn BTC_give_backpack_big"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_big;
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 1;
		titletext ["","PLAIN"];
};

BTC_give_parachute =
{
		//this addAction ["<t color='#298A08'>Prendi zaino GRANDE</t>","_nul = [] spawn BTC_give_backpack_big"]; 
		titletext ["Equipping Parachute...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Parachute;
		sleep 1;
		titletext ["Parachute equipped!","BLACK IN"];
		sleep 1;
		titletext ["","PLAIN"];
};

BTC_give_medic_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_medic;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addItemCargoGlobal ["FirstAidKit", 10]; 	
		_backpack addItemCargoGlobal ["Medikit", 1]; 
		_backpack addMagazineCargoGlobal [BTC_smoke, 10]; 
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_ATH_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_HAT;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal ["Titan_AT", 2];
		_backpack addMagazineCargoGlobal ["Titan_AP", 1];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_ATL_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_HAT;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Back_LAT, 3];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_AA_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_HAT;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Back_AA, 2];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};


BTC_give_MGL_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_LMG;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_MG_ammo, 6]; 
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_MG_bkp =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_LMG;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Ammo_LMG, 4]; 
		_backpack addMagazineCargoGlobal [BTC_Ammo_LMG2, 4]; 
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_MG_bkp_650_200rnd =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_LMG;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Ammo_LMG, 2]; 
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_MG_bkp_762_150rnd =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_LMG;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Ammo_HMG, 3]; 
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_EXP_bkp_L =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_EXP;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		//_backpack addItemCargoGlobal ["Toolkit", 1];
		//_backpack addItemCargoGlobal ["MineDetector", 1];
		_backpack addMagazineCargoGlobal [(BTC_Ammo_EXP select 1), 4];
		_backpack addMagazineCargoGlobal [(BTC_Ammo_EXP select 2), 2];	
		_backpack addMagazineCargoGlobal [(BTC_Ammo_EXP select 3), 2];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_EXP_bkp_H =
{
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_EXP;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		//_backpack addItemCargoGlobal ["Toolkit", 1];
		//_backpack addItemCargoGlobal ["MineDetector", 1];
		_backpack addMagazineCargoGlobal [(BTC_Ammo_EXP select 0), 2];	
		_backpack addMagazineCargoGlobal [(BTC_Ammo_EXP select 2), 2];	
		_backpack addMagazineCargoGlobal [(BTC_Ammo_EXP select 3), 2];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_rec_bkp_408 =
{
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_Snip;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Back_S408, 10];
		_backpack addMagazineCargoGlobal [(BTC_Back_mine select 0), 5];	_backpack addMagazineCargoGlobal [(BTC_Back_mine select 1), 5];
		_backpack addItemCargoGlobal ["FirstAidKit", 2];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};

BTC_give_rec_bkp_127 =
{
		//this addAction ["<t color='#298A08'>Prendi zaino ASSALTO</t>","_nul = [] spawn BTC_give_backpack_small"]; 
		titletext ["Equipping backpack...","BLACK FADED"];
		sleep 1;
		removeBackPack player;
		player addBackPack BTC_Back_Snip;
		_backpack = unitBackpack player;
		clearItemCargoGlobal _backpack;
		_backpack addMagazineCargoGlobal [BTC_Back_S127, 10];
		_backpack addMagazineCargoGlobal [(BTC_Back_mine select 0), 5];	_backpack addMagazineCargoGlobal [(BTC_Back_mine select 1), 5];
		_backpack addItemCargoGlobal ["FirstAidKit", 2];
		sleep 1;
		titletext ["Backpack equipped!","BLACK IN"];
		sleep 2;
		titletext ["","PLAIN"];
};


BTC_spw_UAV = 
{	//_NUL = [] spawn BTC_spw_UAV;
	titletext ["Creating requested UAV...","PLAIN"];
	sleep 1;
	titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
	_Vehiclepos 	= getMarkerPos "drones";
	_Vehicleradius 	= 10;
	_Vehicle = [];
	_Vehicle = nearestObjects [_Vehiclepos, ["Air"], _Vehicleradius];
	if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
	sleep 1;
	_veh = createVehicle [(BTC_UAV select 0), getMarkerPos "drones", [], 0, "NONE"];
	createVehicleCrew _veh;
	_veh setDir 240; 
	_group = group driver _veh;
	if (BTC_markers == 1) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
	titletext ["UAV Ready","PLAIN"];
};

BTC_spw_UAV_cas = 
{	//_NUL = [] spawn BTC_spw_UAV;
	titletext ["Creating requested UAV...","PLAIN"];
	sleep 1;
	titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
	_Vehiclepos 	= getMarkerPos "drones";
	_Vehicleradius 	= 10;
	_Vehicle = [];
	_Vehicle = nearestObjects [_Vehiclepos, ["Air"], _Vehicleradius];
	if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
	sleep 1;
	_veh = createVehicle [(BTC_UAV select 1), getMarkerPos "drones", [], 0, "NONE"];
	createVehicleCrew _veh;
	_veh setDir 240; 
	_group = group driver _veh;
	if (BTC_markers == 1) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
	titletext ["UAV Ready","PLAIN"];
};

BTC_spw_DARTEN = 
{	//_NUL = [] spawn BTC_spw_UAV;
	titletext ["Creating requested UAV...","PLAIN"];
	sleep 1;
	titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
	_Vehicle = [];
	_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["ReammoBox","LandVehicle","Air"], 4];
	if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
	sleep 1;
	_veh = createVehicle [(BTC_UAV select 2), getMarkerPos "Logistic_mrk", [], 0, "NONE"];
	createVehicleCrew _veh;
	_veh setDir 240;
	_group = group driver _veh;
	if (BTC_markers == 1) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
	titletext ["UAV Ready","PLAIN"];
};

BTC_spw_UGV = 
{	//_NUL = [] spawn BTC_spw_UAV;
	titletext ["Creating requested vehicle...","PLAIN"];
	sleep 1;
	titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
	_Vehicle = [];
	_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["ReammoBox","LandVehicle","Air"], 4];
	if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
	sleep 1;
	_veh = createVehicle [(BTC_UGV select 0), getMarkerPos "Logistic_mrk", [], 0, "NONE"];
	createVehicleCrew _veh;
	_veh setDir 15; 
	_group = group driver _veh;
	if (BTC_markers == 1) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
	titletext ["STOMPER Ready","PLAIN"];
};

BTC_spw_UGV_rcws = 
{	//_NUL = [] spawn BTC_spw_UAV;
	titletext ["Creating requested vehicle...","PLAIN"];
	sleep 1;
	titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
	_Vehicle = [];
	_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["ReammoBox","LandVehicle","Air"], 4];
	if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
	sleep 1;
	_veh = createVehicle [(BTC_UGV select 1), getMarkerPos "Logistic_mrk", [], 0, "NONE"];
	createVehicleCrew _veh;
	_veh setDir 15; 
	_group = group driver _veh;
	if (BTC_markers == 1) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
	titletext ["STOMPER RCWS Ready","PLAIN"];
};


//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////// LOGISTIC \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//////////////////////////////////////////////////////////////////////////////////////////

BTC_missile_crate =
{
		// this addAction ["<t color='#FFF600'>Request Missile crate</t>","_nul = [] spawn BTC_missile_crate"];  
		titletext ["Creating Ammo Crate...","PLAIN"];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		_Vehicle = [];
		_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["Reammobox","landVehicle","Air"], 4];
		if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
		Sleep 1;
		BTC_btc_box = BTC_Box_launch createVehicle [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		BTC_btc_box setPos [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		clearWeaponCargoGlobal BTC_btc_box; clearMagazineCargoGlobal BTC_btc_box;	clearItemCargoGlobal BTC_btc_box; clearBackpackCargoGlobal BTC_btc_box;
		BTC_btc_box addMagazineCargo [ BTC_Back_LAT, 10];
		BTC_btc_box addMagazineCargo ["Titan_AA", 10];
		BTC_btc_box addMagazineCargo ["Titan_AT", 10];
		BTC_btc_box addMagazineCargo ["Titan_AP", 10];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		sleep 2;
		titletext ["Logistic Box ready! Remove the box before request another.","PLAIN"];
		sleep 10;
		titletext ["","PLAIN"];
};

BTC_ordenance_crate =
{
		// this addAction ["<t color='#FFF600'>Request Ordenance crate</t>","_nul = [] spawn BTC_ordenance_crate"]; 
		titletext ["Creating Ammo Crate...","PLAIN"];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		_Vehicle = [];
		_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["Reammobox","landVehicle","Air"], 4];
		if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
		sleep 1;
		BTC_btc_box = BTC_Box_Grenade createVehicle [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		BTC_btc_box setPos [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		clearWeaponCargoGlobal BTC_btc_box; clearMagazineCargoGlobal BTC_btc_box;	clearItemCargoGlobal BTC_btc_box; clearBackpackCargoGlobal BTC_btc_box;
		BTC_btc_box addMagazineCargo [BTC_granade, 20]; 
		BTC_btc_box addMagazineCargo ["DemoCharge_Remote_Mag", 5];
		BTC_btc_box addMagazineCargo ["SatchelCharge_Remote_Mag", 5];
		BTC_btc_box addMagazineCargo ["Laserbatteries", 5];
		BTC_btc_box addMagazineCargo [BTC_smoke, 20];
		BTC_btc_box addMagazineCargo ["ATMine_Range_Mag", 10];
		BTC_btc_box addMagazineCargo ["APERSMine_Range_Mag", 10];
		BTC_btc_box addMagazineCargo ["APERSBoundingMine_Range_Mag", 10];
		BTC_btc_box addMagazineCargo ["SLAMDirectionalMine_Wire_Mag", 10];
		BTC_btc_box addMagazineCargo ["APERSTripMine_Wire_Mag", 10];
		BTC_btc_box addMagazineCargo ["FlareWhite_F", 10];
		BTC_btc_box addMagazineCargo ["UGL_FlareWhite_F", 10];
		BTC_btc_box addMagazineCargo ["1Rnd_HE_Grenade_shell", 10];
		BTC_btc_box addMagazineCargo ["1Rnd_smoke_Grenade_shell", 10];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		sleep 2;
		titletext ["Logistic Box ready! Remove the box before request another.","PLAIN"];
		sleep 10;
		titletext ["","PLAIN"];
};

BTC_ammo_crate =
{		
		// this addAction ["<t color='#FFF600'>Request Ammo crate</t>","_nul = [] spawn BTC_ammo_crate"];
		titletext ["Creating Ammo Crate...","PLAIN"];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		_Vehicle = [];
		_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["Reammobox","landVehicle","Air"], 4];
		if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
		sleep 1;
		BTC_btc_box = BTC_Box_Weapon createVehicle [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		BTC_btc_box setPos [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		clearWeaponCargoGlobal BTC_btc_box; clearMagazineCargoGlobal BTC_btc_box;	clearItemCargoGlobal BTC_btc_box; clearBackpackCargoGlobal BTC_btc_box;
		BTC_btc_box addMagazineCargo [BTC_mag_30rnd, 20];
		BTC_btc_box addMagazineCargo [BTC_mag_30rndT, 20];
		BTC_btc_box addMagazineCargo [BTC_Ammo_LMG, 10];
		BTC_btc_box addMagazineCargo [BTC_Ammo_LMG2, 10];
		BTC_btc_box addMagazineCargo [BTC_Ammo_HMG, 10];
		BTC_btc_box addMagazineCargo [BTC_Ammo_HMG2, 10];
		BTC_btc_box addMagazineCargo [BTC_mag_30rndS, 20];
		BTC_btc_box addMagazineCargo [BTC_mag_20rnd, 20];
		BTC_btc_box addMagazineCargo [BTC_Back_S408, 20];
		BTC_btc_box addMagazineCargo [BTC_Back_S127, 20];  
		BTC_btc_box addMagazineCargo ["FlareWhite_F", 20];
		BTC_btc_box addMagazineCargo ["UGL_FlareWhite_F", 20];
		BTC_btc_box addMagazineCargo ["1Rnd_HE_Grenade_shell", 20];
		BTC_btc_box addMagazineCargo ["1Rnd_smoke_Grenade_shell", 20];
		BTC_btc_box addMagazineCargo [BTC_smoke, 20];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		sleep 2;
		titletext ["Logistic Box ready! Remove the box before request another.","PLAIN"];
		sleep 10;
		titletext ["","PLAIN"];
};

BTC_empty_crate =
{		
		// this addAction ["<t color='#FFF600'>Request Empty crate</t>","_nul = [] spawn BTC_empty_crate"];
		titletext ["Creating Ammo Crate...","PLAIN"];
		sleep 2;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		_Vehicle = [];
		_Vehicle = nearestObjects [getMarkerpos "Logistic_mrk", ["Reammobox","landVehicle","Air"], 4];
		if (count _Vehicle > 0) then {{deleteVehicle _x}foreach _Vehicle;};
		sleep 1;
		BTC_btc_box = BTC_Box_Weapon createVehicle [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		BTC_btc_box setPos [(getMarkerpos "Logistic_mrk" select 0),(getMarkerpos "Logistic_mrk" select 1),0];
		clearWeaponCargoGlobal BTC_btc_box; clearMagazineCargoGlobal BTC_btc_box;	clearItemCargoGlobal BTC_btc_box; clearBackpackCargoGlobal BTC_btc_box;
		sleep 1;
		titletext ["**** DO NOT ENTER THE WORKING AREA BEFORE COMPLETE ****","PLAIN"];
		sleep 1;
		titletext ["Logistic Box ready! Remove the box before request another.","PLAIN"];
		sleep 3;
		titletext ["","PLAIN"];
};


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


