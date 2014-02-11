///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Select 0	//Weapons					Box_NATO_Wps_F
//Select 1  //Ammo						Box_NATO_Ammo_F
//Select 2	//LAUNCHERS					Box_NATO_WpsLaunch_F
//Select 3  //Grenade explosive Ammo	Box_NATO_Grenades_F
//Select 4  //Helmets/HATS/Clothing		B_supplyCrate_F

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

//ACRE Check
if (isClass(configFile >> "cfgPatches" >> "acre_main")) then 
{
ammo_acre = "ACRE_Radiobox" createVehicle [(getMarkerpos "ACRE" select 0),(getMarkerpos "ACRE" select 1)]; ammo_acre setPos [(getMarkerpos "ACRE" select 0),(getMarkerpos "ACRE" select 1),0]; ammo_acre setDir 90; 
ammo_acre = "ACRE_Radiobox" createVehicle [(getMarkerpos "ACRE_1" select 0),(getMarkerpos "ACRE_1" select 1)]; ammo_acre setPos [(getMarkerpos "ACRE_1" select 0),(getMarkerpos "ACRE_1" select 1),0]; ammo_acre setDir 90; 
ammo_acre = "ACRE_Radiobox" createVehicle [(getMarkerpos "ACRE_2" select 0),(getMarkerpos "ACRE_2" select 1)]; ammo_acre setPos [(getMarkerpos "ACRE_2" select 0),(getMarkerpos "ACRE_2" select 1),0]; ammo_acre setDir 90; 
};

///// Create boxes ///////
BTC_clothing 	= "B_supplyCrate_F" 	createVehicleLocal [(getMarkerpos "mrk_ammo" select 0),  (getMarkerpos "mrk_ammo" select 1),0];
BTC_weapons 	= "Box_NATO_Wps_F" 		createVehicleLocal [(getMarkerpos "mrk_ammo_1" select 0),(getMarkerpos "mrk_ammo_1" select 1),0];
BTC_magazines	= "Box_NATO_Ammo_F" 	createVehicleLocal [(getMarkerpos "mrk_ammo_2" select 0),(getMarkerpos "mrk_ammo_2"  select 1),0];
BTC_launchers 	= "Box_NATO_WpsLaunch_F" createVehicleLocal[(getMarkerpos "mrk_ammo_3" select 0),(getMarkerpos "mrk_ammo_3"  select 1),0];
BTC_explosive 	= "Box_NATO_AmmoOrd_F" 	createVehicleLocal [(getMarkerpos "mrk_ammo_4" select 0),(getMarkerpos "mrk_ammo_4"  select 1),0];	

///// Move boxes ///////
BTC_clothing setPos  [(getMarkerpos "mrk_ammo" select 0),(getMarkerpos "mrk_ammo" select 1),0];
BTC_weapons setPos   [(getMarkerpos "mrk_ammo_1" select 0),(getMarkerpos "mrk_ammo_1" select 1),0];
BTC_magazines setPos [(getMarkerpos "mrk_ammo_2" select 0),(getMarkerpos "mrk_ammo_2"  select 1),0];
BTC_launchers setPos [(getMarkerpos "mrk_ammo_3" select 0),(getMarkerpos "mrk_ammo_3"  select 1),0];
BTC_explosive setPos [(getMarkerpos "mrk_ammo_4" select 0),(getMarkerpos "mrk_ammo_4"  select 1),0];	

{_x setDir 225} foreach [BTC_magazines,BTC_explosive,BTC_VAS];
{_x setDir 135} foreach [BTC_weapons,BTC_launchers,BTC_clothing];
{player reveal _x; _x allowDamage false;ClearWeaponCargo _x;ClearMagazineCargo _x;ClearItemCargo _x;} 
foreach [BTC_weapons,BTC_magazines,BTC_launchers,BTC_explosive,BTC_clothing];

//CLOTHES/UNIFORM/HELMETS
{_x addAction ["<t color='#CC9900'>DRESS LAND SUIT</t>","_nul = [] spawn BTC_std_soldier"]} foreach [BTC_clothing]; 
{_x addAction ["<t color='#CC9900'>DRESS GHILLIE SUIT</t>","_nul = [] spawn BTC_std_sniper"]} foreach [BTC_clothing]; 
{_x addAction ["<t color='#CC9900'>DRESS WET SUIT</t>","_nul = [] spawn BTC_std_diver"]} foreach [BTC_clothing]; 
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK SMALL EMPTY</t>","_nul = [] spawn BTC_give_small_bkp"]} foreach [BTC_clothing];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK BIG EMPTY</t>","_nul = [] spawn BTC_give_big_bkp"]} foreach [BTC_clothing];
//RIFLE BOX
{_x addAction ["<t color='#CC9900'>TAKE RIFLE 5.56</t>","_nul = [] spawn BTC_primary_wep_556"]} foreach [BTC_weapons]; 
{_x addAction ["<t color='#CC9900'>TAKE RIFLE 6.5</t>","_nul = [] spawn BTC_primary_wep_65"]} foreach [BTC_weapons]; 
{_x addAction ["<t color='#CC9900'>TAKE RIFLE 6.5 GL</t>","_nul = [] spawn BTC_primary_wep_65_GL"]} foreach [BTC_weapons]; 
{_x addAction ["<t color='#CC9900'>TAKE MG 6.5 LIGHT</t>","_nul = [] spawn BTC_mg65_litgh"]} foreach [BTC_weapons]; 
{_x addAction ["<t color='#CC9900'>TAKE MG 6.5</t>","_nul = [] spawn BTC_mg65_wep"]} foreach [BTC_weapons]; 
{_x addAction ["<t color='#CC9900'>TAKE MG 7.62</t>","_nul = [] spawn BTC_mg762_wep"]} foreach [BTC_weapons]; 
{_x addAction ["<t color='#CC9900'>TAKE 'SNIPER' RIFLE</t>","_nul = [] spawn BTC_primary_wep_snip"]} foreach [BTC_weapons];
{_x addAction ["<t color='#CC9900'>TAKE 'HEAVY SNIPER' RIFLE</t>","_nul = [] spawn BTC_primary_wep_H_snip"]} foreach [BTC_weapons];
{_x addAction ["<t color='#CC9900'>TAKE 'SDAR' RIFLE</t>","_nul = [] spawn BTC_primary_wep_sadr"]} foreach [BTC_weapons];
//AMMO BOX
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK SMALL EMPTY</t>","_nul = [] spawn BTC_give_small_bkp"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK BIG EMPTY</t>","_nul = [] spawn BTC_give_big_bkp"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK MEDIC</t>","_nul = [] spawn BTC_give_medic_bkp"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK SNIPER</t>","_nul = [] spawn BTC_give_rec_bkp_408"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK HEAVY SNIPER</t>","_nul = [] spawn BTC_give_rec_bkp_127"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK MG cal. 6.50 LIGHT NATO</t>","_nul = [] spawn BTC_give_MGL_bkp"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK MG cal. 6.50</t>","_nul = [] spawn BTC_give_MG_bkp_650_200rnd"]} foreach [BTC_magazines];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK MG cal. 7.62</t>","_nul = [] spawn BTC_give_MG_bkp_762_150rnd"]} foreach [BTC_magazines];
//LAUNCHERS BOX
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK HEAVY AT</t>","_nul = [] spawn BTC_give_ATH_bkp"]} foreach [BTC_launchers];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK LIGHT AT</t>","_nul = [] spawn BTC_give_ATL_bkp"]} foreach [BTC_launchers];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK AA</t>","_nul = [] spawn BTC_give_AA_bkp"]} foreach [BTC_launchers];
//EXPLOSIVE BOX
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK SATCHEL</t>","_nul = [] spawn BTC_give_EXP_bkp_H"]} foreach [BTC_explosive];
{_x addAction ["<t color='#CC9900'>TAKE BACKPACK EXPLOSIVES</t>","_nul = [] spawn BTC_give_EXP_bkp_L"]} foreach [BTC_explosive];

_refill =   [[[BTC_weapons,(BTC_ammo_cont select 0)]],90] spawn BTC_refill_ammo;
_refill = [[[BTC_magazines,(BTC_ammo_cont select 1)]],90] spawn BTC_refill_ammo;
_refill = [[[BTC_launchers,(BTC_ammo_cont select 2)]],90] spawn BTC_refill_ammo;
_refill = [[[BTC_explosive,(BTC_ammo_cont select 3)]],90] spawn BTC_refill_ammo;
_refill =  [[[BTC_clothing,(BTC_ammo_cont select 4)]],90] spawn BTC_refill_ammo;

{_x setVariable ["BTC_cannot_lift",1,true]} foreach [BTC_weapons,BTC_magazines,BTC_launchers,BTC_explosive,BTC_clothing,BTC_VAS,BTC_VAS_1,BTC_VAS_2,BTC_VAS_3];
{_x setVariable ["BTC_cannot_load",1,true]} foreach [BTC_weapons,BTC_magazines,BTC_launchers,BTC_explosive,BTC_clothing,BTC_VAS,BTC_VAS_1,BTC_VAS_2,BTC_VAS_3];
{_x setVariable ["BTC_cannot_drag",1,true]} foreach [BTC_weapons,BTC_magazines,BTC_launchers,BTC_explosive,BTC_clothing,BTC_VAS,BTC_VAS_1,BTC_VAS_2,BTC_VAS_3];
	
{_x addAction ["<t color='#ff0000'>-VIRTUAL AMMOBOX SYSTEM-</t>","VAS\open.sqf", [], 6]} foreach [BTC_VAS,BTC_VAS_1,BTC_VAS_2,BTC_VAS_3,BTC_VAS_4,BTC_VAS_5,BTC_VAS_6,BTC_VAS_7];	

{_x addAction ["<t color='#CC9900'>TAKE PARACHUTE</t>","_nul = [] spawn BTC_give_parachute",[],7];} 
foreach [BTC_base_flag_west,BTC_base_flag_west_1,BTC_base_flag_west_2,BTC_base_flag_west_3,BTC_base_flag_west_4,BTC_base_flag_west_5];
{_x addAction ["<t color='#CC9900'>HALO JUMP</t>","scripts\para\letsjump.sqf",[],6];}
foreach [BTC_base_flag_west,BTC_base_flag_west_1,BTC_base_flag_west_2,BTC_base_flag_west_3,BTC_base_flag_west_4,BTC_base_flag_west_5];
//Rally point
if (rank player == "MAJOR") then 
{
BTC_rally_point = RALLY_POINT addaction ["<t color='#CC9900'>TAKE RALLY POINT</t>","scripts\BTC_rally_point.sqf",nil,7,true,true]; BTC_RALLY_DEPLOYED = false; publicVariable "BTC_RALLY_DEPLOYED";
};
	
	