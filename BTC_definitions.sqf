///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////
//Param
BTC_month           	= (paramsArray select 0);
BTC_day            		= (paramsArray select 1);
BTC_hour            	= (paramsArray select 2);
BTC_minutes         	= (paramsArray select 3);
BTC_AI_skill        	= (paramsArray select 4)/10;
BTC_difficulty			= (paramsArray select 5);
BTC_side_enemy      	= (paramsArray select 6);
BTC_vehicles			= (paramsArray select 7);
BTC_patrols_inf			= (paramsArray select 8);
BTC_patrols_veh			= (paramsArray select 9);
BTC_patrols_ship		= (paramsArray select 10);
BTC_patrols_air			= (paramsArray select 11);
BTC_patrols_base_inf 	= (paramsArray select 12);
BTC_patrols_base_stat	= (paramsArray select 13);
BTC_patrols_fob 		= (paramsArray select 14);
BTC_chs_miss			= (paramsArray select 15);
BTC_search_min			= (paramsArray select 16);
BTC_place_miss			= (paramsArray select 17);
BTC_terrain         	= (paramsArray select 18);
BTC_view_distance   	= (paramsArray select 19);
BTC_arty				= (paramsArray select 20);
BTC_stc_city			= (paramsArray select 21);
BTC_reinforcements		= (paramsArray select 22);
BTC_markers				= (paramsArray select 23);
BTC_civ_city			= (paramsArray select 24)/10;
BTC_weather				= (paramsArray select 25);
BTC_fog					= (paramsArray select 26);
BTC_taxi				= (paramsArray select 27);
BTC_halo_height			= (paramsArray select 28);
BTC_fast_time 			= (paramsArray select 29);
TPWCAS					= (paramsArray select 30);
BTC_debug           	= (paramsArray select 31);

/// Only for test on Editor
If ((isServer) && !(isDedicated)) then 
{
BTC_month           = 5;
BTC_day             = 3;
BTC_hour            = 12;
BTC_minutes         = 00;
BTC_AI_skill        = 0.4;	////****0-1

BTC_difficulty		= 0; 	////****0,3,10,20
BTC_side_enemy		= 2;	////****0-7

BTC_vehicles			= 1;  	////****0/1
BTC_patrols_inf			= 1;  	////****0/1
BTC_patrols_veh			= 1;  	////****0/1
BTC_patrols_ship		= 1;	////****0/1
BTC_patrols_air			= 1;	////****0/1
BTC_patrols_base_inf	= 1;  	////****0/1
BTC_patrols_base_stat 	= 1;	////****0/1
BTC_patrols_fob 		= 1;	////****0/1
BTC_chs_miss			= 0;	//0: lineare, 1: random
BTC_search_min			= 0;	//0, 1000, 2000
BTC_place_miss			= 1; // 0-Anyware, 1-On city/village, 2-Out City/Village
BTC_reinforcements		= 1; // 0-NO, 1-YES, 2-random

BTC_terrain         = 50;
BTC_view_distance   = 4000;
BTC_arty			= 0; //fixare artiglieria
BTC_stc_city		= 1; //Statiche su side missions
BTC_markers			= 1;
BTC_civ_city		= 1;
BTC_weather			= 0;
BTC_fog				= 0;
BTC_taxi			= 0;

BTC_halo_height		= 2000;
BTC_fast_time 		= 0;
TPWCAS				= 0;
BTC_debug           = 1; 


/* 
BTC_side_enemy:
case 0 :// NATO vs CSAT
case 1 :// NATO vs CSAT GUER
case 2 :// NATO vs AAF
case 3 :// EAST vs WEST
case 4 :// EAST vs WEST GUER
case 5 :// EAST vs AAF
case 6 :// AAF vs EAST
case 7 :// AAF vs WEST
*/
};
///////
if (BTC_search_min < 10000) then {BTC_search_max = BTC_search_min;} else {BTC_search_max = 15000; BTC_search_min = 1500;};

//////////////////// Common //////////////////////
BTC_port_mrk_place = ["port_mrk_1","port_mrk_2","port_mrk_3","port_mrk_4","port_mrk_5","port_mrk_6","port_mrk_7","port_mrk_8","port_mrk_9","port_mrk_10","port_mrk_11"];
BTC_sea_miss_array = ["BTC_PTR_MRK_SEA_1","BTC_PTR_MRK_SEA_2","BTC_PTR_MRK_SEA_3","BTC_PTR_MRK_SEA_4","BTC_PTR_MRK_SEA_5","BTC_PTR_MRK_SEA_6","BTC_PTR_MRK_SEA_7","BTC_PTR_MRK_SEA_8","BTC_PTR_MRK_SEA_9","BTC_PTR_MRK_SEA_10","BTC_PTR_MRK_SEA_11","BTC_PTR_MRK_SEA_12","BTC_PTR_MRK_SEA_13","BTC_PTR_MRK_SEA_14","BTC_PTR_MRK_SEA_15","BTC_PTR_MRK_SEA_16","BTC_PTR_MRK_SEA_17","BTC_PTR_MRK_SEA_18","BTC_PTR_MRK_SEA_19","BTC_PTR_MRK_SEA_20","BTC_PTR_MRK_SEA_21","BTC_PTR_MRK_SEA_22","BTC_PTR_MRK_SEA_23","BTC_PTR_MRK_SEA_24","BTC_PTR_MRK_SEA_25","BTC_PTR_MRK_SEA_26","BTC_PTR_MRK_SEA_27","BTC_PTR_MRK_SEA_28","BTC_PTR_MRK_SEA_29","BTC_PTR_MRK_SEA_30","BTC_PTR_MRK_SEA_31"];
BTC_mrk_civ_citys = ["civilian_1","civilian_2","civilian_3","civilian_4","civilian_5","civilian_6","civilian_7","civilian_8","civilian_9","civilian_10","civilian_11","civilian_12","civilian_13","civilian_14","civilian_15","civilian_16","civilian_17","civilian_18","civilian_19","civilian_20","civilian_21","civilian_22","civilian_23","civilian_24","civilian_25","civilian_26","civilian_27","civilian_28","civilian_29","civilian_30","civilian_31","civilian_32","civilian_33","civilian_34","civilian_35","civilian_36","civilian_37","civilian_38","civilian_39","civilian_40","civilian_41","civilian_42","civilian_43","civilian_44","civilian_45","civilian_46","civilian_47","civilian_48","civilian_49","civilian_50","civilian_51","civilian_52","civilian_53","civilian_54","civilian_55","civilian_56","civilian_57","civilian_58","civilian_59","civilian_60","civilian_61","civilian_62","civilian_63"];
BTC_mrk_out_citys = ["mrk_out_city_1","mrk_out_city_2","mrk_out_city_3","mrk_out_city_4","mrk_out_city_5","mrk_out_city_6","mrk_out_city_7","mrk_out_city_8","mrk_out_city_9","mrk_out_city_10","mrk_out_city_11","mrk_out_city_12","mrk_out_city_13","mrk_out_city_14","mrk_out_city_15","mrk_out_city_16","mrk_out_city_17","mrk_out_city_18","mrk_out_city_19","mrk_out_city_20","mrk_out_city_21","mrk_out_city_22","mrk_out_city_23","mrk_out_city_24","mrk_out_city_25","mrk_out_city_26","mrk_out_city_27","mrk_out_city_28","mrk_out_city_29","mrk_out_city_30","mrk_out_city_31","mrk_out_city_32","mrk_out_city_33","mrk_out_city_34","mrk_out_city_35","mrk_out_city_36","mrk_out_city_37","mrk_out_city_38","mrk_out_city_39","mrk_out_city_40","mrk_out_city_41","mrk_out_city_42","mrk_out_city_43","mrk_out_city_44","mrk_out_city_45","mrk_out_city_46","mrk_out_city_47","mrk_out_city_48","mrk_out_city_49","mrk_out_city_50","mrk_out_city_51","mrk_out_city_52","mrk_out_city_53","mrk_out_city_54","mrk_out_city_55","mrk_out_city_56","mrk_out_city_57","mrk_out_city_58","mrk_out_city_59","mrk_out_city_60","mrk_out_city_61","mrk_out_city_62","mrk_out_city_63","mrk_out_city_64","mrk_out_city_65","mrk_out_city_66","mrk_out_city_67","mrk_out_city_68","mrk_out_city_69","mrk_out_city_70","mrk_out_city_71","mrk_out_city_72","mrk_out_city_73","mrk_out_city_74","mrk_out_city_75","mrk_out_city_76","mrk_out_city_77","mrk_out_city_78","mrk_out_city_79","mrk_out_city_80","mrk_out_city_81","mrk_out_city_82","mrk_out_city_83","mrk_out_city_84","mrk_out_city_85","mrk_out_city_86","mrk_out_city_87","mrk_out_city_88","mrk_out_city_89","mrk_out_city_90","mrk_out_city_91","mrk_out_city_92","mrk_out_city_93","mrk_out_city_94","mrk_out_city_95","mrk_out_city_96","mrk_out_city_97","mrk_out_city_98","mrk_out_city_99","mrk_out_city_100","mrk_out_city_101","mrk_out_city_102","mrk_out_city_103","mrk_out_city_104","mrk_out_city_105","mrk_out_city_106","mrk_out_city_107","mrk_out_city_108","mrk_out_city_109","mrk_out_city_110","mrk_out_city_111","mrk_out_city_112","mrk_out_city_113","mrk_out_city_114","mrk_out_city_115"];
BTC_house_4_statics = ["Land_i_House_Small_03_V1_F","Land_i_House_Small_03_V1_dam_F","Land_Unfinished_Building_01_F","Land_Unfinished_Building_02_F","Land_CarService_F","Land_dp_mainFactory_F","Land_Factory_Main_F"];

////////////////// CIVILIANS /////////////////////
BTC_civ_vip 	= ["C_Orestes","C_Nikos","C_man_w_worker_F","C_man_hunter_1_F"];
BTC_civilian 	= [
"C_man_1","Fin_random_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F",
"C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia","C_man_p_beggar_F","C_man_p_beggar_F_afro",
"C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro",
"C_man_p_shorts_1_F_asia","C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F",
"C_man_shorts_2_F_afro","C_man_shorts_2_F_euro","C_man_shorts_2_F_asia","C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro",
"C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro","C_man_shorts_4_F_euro","C_man_shorts_4_F_asia","C_man_polo_1_F_afro",
"C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F_afro",
"C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F_afro",
"C_man_polo_5_F_euro","C_man_polo_5_F_asia","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia",
"Snake_random_F","Snake_random_F","Rabbit_F","Rabbit_F",
"Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F",
"Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F","Fin_random_F"
];
BTC_civ_TL		= "C_Orestes";
BTC_civ_veh 	= ["C_Bergen_red","C_Bergen_grn","C_Bergen_blu","C_SUV_01_F","C_SUV_01_F","C_SUV_01_F","C_Van_01_transport_F","B_G_Van_01_transport_F","C_Van_01_transport_F","B_G_Van_01_transport_F","B_G_Offroad_01_F","C_Offroad_01_F","C_Offroad_01_F","C_Offroad_01_F","C_Offroad_01_F","C_Offroad_01_F","C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F"];
BTC_animals 	= ["Rabbit_F","Rabbit_F","Rabbit_F","Rabbit_F","Rabbit_F","Snake_random_F","Hen_random_F","Cock_random_F","Fin_sand_F","Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Fin_random_F","Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F","Alsatian_Random_F","Sheep_random_F"];
BTC_anim_fish 	= ["Salema_F","Ornate_random_F","Mackerel_F","Tuna_F","Mullet_F","CatShark_F","Turtle_F"];
BTC_sea_corals	= ["land_bw_SetBig_Brains_F","land_bw_SetBig_corals_F","land_bw_SetBig_corals_F","land_bw_SetBig_corals_F","land_bw_SetBig_corals_F","land_bw_SetBig_TubeG_F","land_bw_SetBig_TubeY_F","land_bw_SetSmall_Brains_F","land_bw_SetSmall_TubeG_F","land_bw_SetSmall_TubeY_F"];
BTC_civ_ship	= ["C_Rubberboat","C_Boat_Civil_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F"];


if !(BTC_debug == 1) then 
{
if (BTC_difficulty == 0) then {BTC_resp_enemy_time	= 5400; BTC_val_diff = 0;};//90 min
if (BTC_difficulty == 3) then {BTC_resp_enemy_time	= 3600; BTC_val_diff = 1;};//60 min
if (BTC_difficulty == 10)then {BTC_resp_enemy_time	= 2400; BTC_val_diff = 2;};//40 min
if (BTC_difficulty == 20)then {BTC_resp_enemy_time	= 1200;  BTC_val_diff = 3;}; //20 min
}
else {BTC_val_diff = 3; BTC_resp_enemy_time = 30;};

BTC_man_mines 	= ["APERSMine","APERSBoundingMine","APERSTripMine"]; // Ok list: APERSMine, APERSBoundingMine,
BTC_car_mines 	= ["ATMine","SLAMDirectionalMine"];
BTC_wind		= [];
BTC_intel 		= ["Land_File_F","Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Map_F","Land_Map_unfolded_F","Land_Notepad_F","Land_Photos_V1_F","Land_Photos_V2_F","Land_Photos_V3_F","Land_Photos_V4_F","Land_Photos_V5_F","Land_Photos_V6_F"];
BTC_intel_obj	= ["Land_HandyCam_F","Land_Laptop_F","Land_Laptop_unfolded_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_PortableLongRangeRadio_F","Land_SatellitePhone_F","Land_SurvivalRadio_F","Land_Suitcase_F"];    

switch (BTC_side_enemy) do
{
	case 0 : {mrk_color_start = "ColorOPFOR"; 		mrk_color_end = "ColorBLUFOR";};		// NATO vs CSAT
	case 1 : {mrk_color_start = "ColorOPFOR"; 		mrk_color_end = "ColorBLUFOR";};		// NATO vs CSAT GUER
	case 2 : {mrk_color_start = "ColorIndependent"; mrk_color_end = "ColorBLUFOR";};		// NATO vs AAF
	case 3 : {mrk_color_start = "ColorBLUFOR"; 		mrk_color_end = "ColorOPFOR";};			// EAST vs WEST
	case 4 : {mrk_color_start = "ColorBLUFOR"; 		mrk_color_end = "ColorOPFOR";};			// EAST vs WEST GUER
	case 5 : {mrk_color_start = "ColorIndependent"; mrk_color_end = "ColorOPFOR";};			// EAST vs AAF
	case 6 : {mrk_color_start = "ColorOPFOR"; 		mrk_color_end = "ColorIndependent";};	// AAF vs EAST
	case 7 : {mrk_color_start = "ColorBLUFOR"; 		mrk_color_end = "ColorIndependent";};	// AAF vs WEST
};

// //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  
// //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  // //  

switch (BTC_side_enemy) do
{	
	case 0 :
	{
		BTC_friendly_side1		= WEST;
		BTC_friendly_side2		= WEST;
		// VS
		BTC_enemy_side1			= EAST;
		BTC_enemy_side2			= EAST; 
		BTC_ene_sold_type		= "O_Soldier_base_F";

		BTC_enemy_TL			= "O_Soldier_TL_F";
		BTC_enemy_Off			= "O_officer_F"; 
		BTC_enemy_crewmen 		= "O_crew_F";	
		BTC_enemy_pilot	 		= "O_helipilot_F"; // PLANE PILOT "O_Pilot_F", PARA TROPER "O_soldier_PG_F",
		BTC_friendly_pilot	 	= "B_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_01_F";
		BTC_enemy_medic			= "O_medic_F";
		BTC_enemy_units	 		= ["O_Soldier_lite_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AAA_F","O_soldier_UAV_F"];
		///NEW URBAN UNITS
		BTC_enemy_U_TL			= "O_soldierU_TL_F";
		BTC_enemy_U_units	 	= ["O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_AR_F","O_soldierU_AAR_F","O_soldierU_LAT_F","O_soldierU_AT_F","O_soldierU_AAT_F","O_soldierU_AA_F","O_soldierU_AAA_F","O_SoldierU_SL_F","O_soldierU_medic_F","O_soldierU_repair_F","O_soldierU_exp_F","O_engineer_U_F","O_soldierU_M_F","O_soldierU_A_F","O_SoldierU_GL_F"];
		BTC_enemy_recon			= ["O_spotter_F","O_sniper_F","O_recon_TL_F","O_recon_medic_F","O_recon_M_F","O_recon_LAT_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F"];
		BTC_enemy_veh 			= ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_MRAP_02_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_Truck_02_covered_F","O_Truck_02_transport_F"]; //,"O_Quadbike_01_F"
		BTC_enemy_tracked		= ["O_MBT_02_arty_F","O_APC_Tracked_02_cannon_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F","O_APC_Wheeled_02_rcws_F"];
		BTC_enemy_heli 			= ["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];
		BTC_enemy_boats 		= ["O_Boat_Armed_01_hmg_F","O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F","O_Boat_Transport_01_F","O_SDV_01_F"];
		BTC_enemy_diver			= ["O_diver_F","O_diver_TL_F","O_diver_exp_F"];
		BTC_enemy_diver_TL		= "O_diver_TL_F";
		BTC_enemy_outpost	    = ["O_medic_F","O_soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F"];
		BTC_friendly_outpost	= ["B_medic_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F"];
		BTC_enemy_tent			= "Land_TentA_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["O_APC_Wheeled_02_rcws_F","O_MRAP_02_hmg_F","O_Truck_02_covered_F","O_APC_Tracked_02_AA_F"];
		BTC_enemy_weap_box 		= ["Box_East_WpsSpecial_F","Box_East_WpsLaunch_F","Box_East_Wps_F","Box_East_Support_F","Box_East_Grenades_F","Box_East_AmmoOrd_F","Box_East_Ammo_F"];
		BTC_enemy_static		= ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F"];
		BTC_friendly_static		= ["B_HMG_01_high_F","B_GMG_01_high_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_OPFOR_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["B_UAV_02_F","B_UAV_02_CAS_F","B_UAV_01_F"];
		BTC_UGV					= ["B_UGV_01_F","B_UGV_01_rcws_F"];

		_info=[] spawn {if (BTC_debug == 1) then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'CSAT'"];};};
	};
	
	case 1 :
	{
		BTC_friendly_side1		= WEST;
		BTC_friendly_side2		= WEST;
		// VS
		BTC_enemy_side1			= EAST; // GUER
		BTC_enemy_side2			= EAST;
		BTC_ene_sold_type		= "O_Soldier_base_F";
		
		BTC_enemy_TL			= "O_G_Soldier_TL_F";
		BTC_enemy_Off			= "O_officer_F";
		BTC_enemy_crewmen 		= "O_G_Soldier_lite_F";	
		BTC_enemy_pilot	 		= "O_helipilot_F"; // PLANE PILOT "O_Pilot_F", PARA TROPER "O_soldier_PG_F",
		BTC_friendly_pilot	 	= "B_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_01_F";
		BTC_enemy_medic			= "O_G_medic_F";
		///NEW URBAN UNITS
		BTC_enemy_recon			= ["O_spotter_F","O_sniper_F","O_recon_TL_F","O_recon_medic_F","O_recon_M_F","O_recon_LAT_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F"];
		BTC_enemy_tracked		= ["O_MBT_02_arty_F","O_APC_Tracked_02_cannon_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F","O_APC_Wheeled_02_rcws_F"];
		BTC_enemy_heli 			= ["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];
		BTC_enemy_boats 		= ["O_Boat_Armed_01_hmg_F","O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F","O_Boat_Transport_01_F","O_SDV_01_F"];
		BTC_enemy_diver			= ["O_diver_F","O_diver_TL_F","O_diver_exp_F"];
		BTC_enemy_diver_TL		= "O_diver_TL_F";
		BTC_enemy_outpost	    = ["O_medic_F","O_soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F"];
		BTC_friendly_outpost	= ["B_medic_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F"];
		///NEW INDIPENDENT FACTION
		BTC_enemy_units 		= ["O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_SL_F","O_G_Soldier_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_medic_F","O_G_engineer_F","O_G_Soldier_exp_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_Soldier_LAT_F","O_G_Soldier_A_F"];
		BTC_enemy_veh	 		= ["O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_G_Offroad_01_F","O_G_Van_01_transport_F","O_G_Van_01_transport_F"]; //,"O_G_Quadbike_01_F"
		BTC_enemy_tent			= "Land_TentA_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["O_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F","O_Truck_02_covered_F","O_APC_Tracked_02_AA_F"];
		BTC_enemy_weap_box 		= ["Box_East_WpsSpecial_F","Box_East_WpsLaunch_F","Box_East_Wps_F","Box_East_Support_F","Box_East_Grenades_F","Box_East_AmmoOrd_F","Box_East_Ammo_F"];
		BTC_enemy_static		= ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AA_F","I_static_AT_F","I_Mortar_01_F"];
		BTC_friendly_static		= ["B_HMG_01_high_F","B_GMG_01_high_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_OPFOR_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["B_UAV_02_F","B_UAV_02_CAS_F","B_UAV_01_F"];
		BTC_UGV					= ["B_UGV_01_F","B_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'CSAT GUER'"];};};
	};
	
	
	case 2 :
	{
		BTC_friendly_side1		= WEST;
		BTC_friendly_side2		= WEST;
		// VS
		BTC_enemy_side1			= RESISTANCE;
		BTC_enemy_side2			= RESISTANCE;
		BTC_ene_sold_type		= "I_Soldier_base_F";
		
		BTC_enemy_TL	 		= "I_Soldier_SL_F";
		BTC_enemy_Off			= "I_officer_F";
		BTC_enemy_crewmen 		= "I_crew_F";	
		BTC_enemy_pilot	 		= "I_helipilot_F"; //"I_helicrew_F";
		BTC_friendly_pilot	 	= "B_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_01_F";
		BTC_enemy_medic	 		= "I_medic_F";
		BTC_enemy_units	 		= ["I_Soldier_lite_F","I_Soldier_02_F","I_soldier_F","I_Soldier_02_F","I_soldier_F","I_Soldier_02_F","I_soldier_F","I_Soldier_A_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_M_F","I_Soldier_LAT_F","I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_Spotter_F","I_Sniper_F","I_Soldier_AAR_F","I_Soldier_AAT_F","I_Soldier_AAA_F"];
		BTC_enemy_veh 			= ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Truck_02_covered_F","I_Truck_02_transport_F"]; //,"I_Quadbike_01_F"
		BTC_enemy_recon			= ["I_Spotter_F","I_Sniper_F","I_Spotter_F","I_Sniper_F","I_Soldier_SL_F","I_medic_F"];
		BTC_enemy_tracked		= ["O_MBT_02_arty_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","O_APC_Tracked_02_AA_F","I_APC_Wheeled_03_cannon_F"];
		BTC_enemy_heli 			= ["I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F"];
		BTC_enemy_boats 		= ["I_Boat_Armed_01_minigun_F","I_Boat_Armed_01_minigun_F","I_Boat_Transport_01_F","I_Boat_Transport_01_F","I_SDV_01_F"];
		BTC_enemy_diver			= ["I_diver_F","I_diver_exp_F","I_diver_TL_F"];
		BTC_enemy_diver_TL		= "I_diver_TL_F";
		BTC_enemy_outpost		= ["I_medic_F","I_soldier_AR_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F"];
		BTC_friendly_outpost	= ["B_medic_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F"];
		BTC_enemy_tent			= "Land_TentA_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["I_APC_Wheeled_03_cannon_F","I_MRAP_03_hmg_F","I_Truck_02_covered_F","O_APC_Tracked_02_AA_F"];
		BTC_enemy_weap_box 		= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_AmmoVeh_F"];
		BTC_enemy_static		= ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AA_F","I_static_AT_F","I_Mortar_01_F"];
		BTC_friendly_static		= ["B_HMG_01_high_F","B_GMG_01_high_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_INDP_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["B_UAV_02_F","B_UAV_02_CAS_F","B_UAV_01_F"];
		BTC_UGV					= ["B_UGV_01_F","B_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) 
		then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'RESISTANCE'"];};};
	};
	
	
	case 3 :
	{
		BTC_friendly_side1		= EAST;
		BTC_friendly_side2		= EAST;
		// VS
		BTC_enemy_side1			= WEST;
		BTC_enemy_side2			= WEST;
		BTC_ene_sold_type		= "B_Soldier_base_F";
		
		BTC_enemy_TL	 		= "B_Soldier_SL_F";
		BTC_enemy_Off			= "B_officer_F";
		BTC_enemy_crewmen 		= "B_crew_F";	
		BTC_enemy_pilot	 		= "B_Helipilot_F";
		BTC_friendly_pilot	 	= "O_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_02_F";
		BTC_enemy_medic	 		= "B_medic_F";
		BTC_enemy_units	 		= ["B_Soldier_lite_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_02_f","B_Soldier_03_f","B_Soldier_GL_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_TL_F","B_soldier_M_F","B_soldier_LAT_F","B_medic_F","B_soldier_repair_F","B_soldier_exp_F","B_spotter_F","B_sniper_F","B_Soldier_A_F","B_soldier_AT_F","B_soldier_AA_F","B_engineer_F","B_crew_F","B_officer_F","B_Competitor_F","B_soldier_AAR_F","B_soldier_AAT_F","B_soldier_AAA_F"];
		BTC_enemy_veh 			= ["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_Truck_01_transport_F","B_Truck_01_covered_F"]; //,"B_Quadbike_01_F"
		BTC_enemy_recon			= ["B_spotter_F","B_sniper_F","B_recon_F","B_recon_LAT_F","B_recon_exp_F","B_recon_medic_F","B_recon_TL_F","B_recon_M_F","B_recon_JTAC_F"];
		BTC_enemy_tracked		= ["B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_APC_Wheeled_01_cannon_F"];
		BTC_enemy_heli 			= ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Light_01_F","B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Light_01_F","B_Heli_Transport_01_F"];
		BTC_enemy_boats 		= ["B_Boat_Armed_01_minigun_F","B_Boat_Armed_01_minigun_F","B_Boat_Transport_01_F","B_Boat_Transport_01_F","B_SDV_01_F"];
		BTC_enemy_diver			= ["B_diver_F","B_diver_TL_F","B_diver_exp_F"];
		BTC_enemy_diver_TL		= "B_diver_TL_F";
		BTC_enemy_outpost	    = ["B_medic_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F"];
		BTC_friendly_outpost	= ["O_medic_F","O_soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F"];
		BTC_enemy_tent			= "Land_TentDome_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["B_APC_Wheeled_01_cannon_F","B_MRAP_01_hmg_F","B_Truck_01_covered_F","B_APC_Tracked_01_AA_F"];
		BTC_enemy_weap_box 		= ["Box_NATO_Wps_F","Box_NATO_WpsSpecial_F","Box_NATO_Ammo_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F"];
		BTC_enemy_static		= ["B_HMG_01_high_F","B_GMG_01_high_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F"];
		BTC_friendly_static		= ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_BLUFOR_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["O_UAV_02_F","O_UAV_02_CAS_F","O_UAV_01_F"];
		BTC_UGV					= ["O_UGV_01_F","O_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) 
		then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'NATO'"];};};
	};
	
	case 4 :
	{
		BTC_friendly_side1		= EAST;
		BTC_friendly_side2		= EAST;
		// VS
		BTC_enemy_side1			= WEST; // GUER
		BTC_enemy_side2			= WEST;	
		BTC_ene_sold_type		= "B_Soldier_base_F";

		BTC_enemy_TL	 		= "B_G_Soldier_SL_F";
		BTC_enemy_Off			= "B_G_officer_F";
		BTC_enemy_crewmen 		= "B_crew_F";	
		BTC_enemy_pilot	 		= "B_Helipilot_F";
		BTC_friendly_pilot	 	= "O_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_02_F";
		BTC_enemy_medic	 		= "B_G_medic_F";
		BTC_enemy_recon			= ["B_spotter_F","B_sniper_F","B_recon_F","B_recon_LAT_F","B_recon_exp_F","B_recon_medic_F","B_recon_TL_F","B_recon_M_F","B_recon_JTAC_F"];
		BTC_enemy_tracked		= ["B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_APC_Wheeled_01_cannon_F"];
		BTC_enemy_heli 			= ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Light_01_F","B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Light_01_F","B_Heli_Transport_01_F"];
		BTC_enemy_boats 		= ["B_Boat_Armed_01_minigun_F","B_Boat_Armed_01_minigun_F","B_Boat_Transport_01_F","B_Boat_Transport_01_F","B_SDV_01_F"];
		BTC_enemy_diver			= ["B_diver_F","B_diver_TL_F","B_diver_exp_F"];
		BTC_enemy_diver_TL		= "B_diver_TL_F";
		BTC_enemy_outpost	    = ["B_medic_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F"];
		BTC_friendly_outpost	= ["O_medic_F","O_soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F"];
		BTC_enemy_units 		= ["B_G_Soldier_lite_F","B_G_Soldier_F","B_G_Soldier_SL_F","B_G_Soldier_F","B_G_Soldier_SL_F","B_G_Soldier_F","B_G_Soldier_SL_F","B_G_Soldier_SL_F","B_G_Soldier_TL_F","B_G_Soldier_AR_F","B_G_medic_F","B_G_engineer_F","B_G_Soldier_exp_F","B_G_Soldier_GL_F","B_G_Soldier_M_F","B_G_Soldier_LAT_F","B_G_Soldier_A_F","B_G_officer_F"];
		BTC_enemy_veh 			= ["B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_F","B_G_Van_01_transport_F","B_G_Van_01_transport_F"]; //,"B_G_Quadbike_01_F"
		BTC_enemy_tent			= "Land_TentDome_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["B_G_Offroad_01_armed_F","B_G_Offroad_01_armed_F","B_G_Van_01_transport_F","B_APC_Tracked_01_AA_F"];
		BTC_enemy_weap_box 		= ["Box_NATO_Wps_F","Box_NATO_WpsSpecial_F","Box_NATO_Ammo_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F"];
		BTC_enemy_static		= ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AA_F","I_static_AT_F","I_Mortar_01_F"];
		BTC_friendly_static		= ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_BLUFOR_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["O_UAV_02_F","O_UAV_02_CAS_F","O_UAV_01_F"];
		BTC_UGV					= ["O_UGV_01_F","O_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) 
		then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'NATO GUER'"];};};
		
	};
	
	case case 5 :
	{	
		BTC_friendly_side1		= EAST;
		BTC_friendly_side2		= EAST;
		// VS
		BTC_enemy_side1			= RESISTANCE;
		BTC_enemy_side2			= RESISTANCE;
		BTC_ene_sold_type		= "I_Soldier_base_F";
		
		BTC_enemy_TL	 		= "I_Soldier_SL_F";
		BTC_enemy_Off			= "I_officer_F";
		BTC_enemy_crewmen 		= "I_crew_F";	
		BTC_enemy_pilot	 		= "I_helipilot_F"; //"I_helicrew_F";
		BTC_friendly_pilot	 	= "B_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_01_F";
		BTC_enemy_medic	 		= "I_medic_F";
		BTC_enemy_units	 		= ["I_Soldier_lite_F","I_Soldier_02_F","I_soldier_F","I_Soldier_02_F","I_soldier_F","I_Soldier_02_F","I_soldier_F","I_Soldier_A_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_M_F","I_Soldier_LAT_F","I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_Spotter_F","I_Sniper_F","I_Soldier_AAR_F","I_Soldier_AAT_F","I_Soldier_AAA_F"];
		BTC_enemy_veh 			= ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Truck_02_covered_F","I_Truck_02_transport_F"]; //,"I_Quadbike_01_F"
		BTC_enemy_recon			= ["I_Spotter_F","I_Sniper_F","I_Soldier_SL_F","I_medic_F"];
		BTC_enemy_tracked		= ["O_MBT_02_arty_F","I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","O_APC_Tracked_02_AA_F","I_APC_Wheeled_03_cannon_F"];
		BTC_enemy_heli 			= ["I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_Heli_Transport_02_F"];
		BTC_enemy_boats 		= ["I_Boat_Armed_01_minigun_F","I_Boat_Armed_01_minigun_F","I_Boat_Transport_01_F","I_Boat_Transport_01_F","I_SDV_01_F"];
		BTC_enemy_diver			= ["I_diver_F","I_diver_exp_F","I_diver_TL_F"];
		BTC_enemy_diver_TL		= "I_diver_TL_F";
		BTC_enemy_outpost		= ["I_medic_F","I_soldier_AR_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F"];
		BTC_friendly_outpost	= ["O_medic_F","O_soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F"];
		BTC_enemy_tent			= "Land_TentA_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_Truck_02_covered_F","B_APC_Tracked_01_AA_F"];
		BTC_enemy_weap_box 		= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_AmmoOrd_F","Box_IND_Grenades_F","Box_IND_Support_F","Box_IND_AmmoVeh_F"];
		BTC_enemy_static		= ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AA_F","I_static_AT_F","I_Mortar_01_F"];
		BTC_friendly_static		= ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_INDP_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["O_UAV_02_F","O_UAV_02_CAS_F","O_UAV_01_F"];
		BTC_UGV					= ["O_UGV_01_F","O_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) 
		then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'RESISTANCE'"];};};
		
		
	}; 
	
	case 6 :
	{
		BTC_friendly_side1		= RESISTANCE;
		BTC_friendly_side2		= RESISTANCE;
		// VS
		BTC_enemy_side1			= EAST;
		BTC_enemy_side2			= EAST;
		BTC_ene_sold_type		= "O_Soldier_base_F";
		
		BTC_enemy_TL			= "O_Soldier_TL_F";
		BTC_enemy_Off			= "O_officer_F"; 
		BTC_enemy_crewmen 		= "O_crew_F";	
		BTC_enemy_pilot	 		= "O_helipilot_F"; // PLANE PILOT "O_Pilot_F", PARA TROPER "O_soldier_PG_F",
		BTC_friendly_pilot	 	= "B_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_01_F";
		BTC_enemy_medic			= "O_medic_F";
		BTC_enemy_units	 		= ["O_Soldier_lite_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AAA_F","O_soldier_UAV_F"];
		///NEW URBAN UNITS
		BTC_enemy_U_TL			= "O_soldierU_TL_F";
		BTC_enemy_U_units	 	= ["O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_F","O_soldierU_AR_F","O_soldierU_AAR_F","O_soldierU_LAT_F","O_soldierU_AT_F","O_soldierU_AAT_F","O_soldierU_AA_F","O_soldierU_AAA_F","O_SoldierU_SL_F","O_soldierU_medic_F","O_soldierU_repair_F","O_soldierU_exp_F","O_engineer_U_F","O_soldierU_M_F","O_soldierU_A_F","O_SoldierU_GL_F"];
		BTC_enemy_recon			= ["O_spotter_F","O_sniper_F","O_recon_TL_F","O_recon_medic_F","O_recon_M_F","O_recon_LAT_F","O_recon_JTAC_F","O_recon_F","O_recon_exp_F"];
		BTC_enemy_veh 			= ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_MRAP_02_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_Truck_02_covered_F","O_Truck_02_transport_F"]; //,"O_Quadbike_01_F"
		BTC_enemy_tracked		= ["O_MBT_02_arty_F","O_APC_Tracked_02_cannon_F","O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F","O_APC_Wheeled_02_rcws_F"];
		BTC_enemy_heli 			= ["O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Attack_02_black_F","O_Heli_Attack_02_F","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F"];
		BTC_enemy_boats 		= ["O_Boat_Armed_01_hmg_F","O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F","O_Boat_Transport_01_F","O_SDV_01_F"];
		BTC_enemy_diver			= ["O_diver_F","O_diver_TL_F","O_diver_exp_F"];
		BTC_enemy_diver_TL		= "O_diver_TL_F";
		BTC_enemy_outpost	    = ["O_medic_F","O_soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F"];
		BTC_friendly_outpost	= ["I_medic_F","I_soldier_AR_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F"];
		BTC_enemy_tent			= "Land_TentA_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["O_APC_Wheeled_02_rcws_F","O_MRAP_02_hmg_F","O_Truck_02_covered_F","O_APC_Tracked_02_AA_F"];
		BTC_enemy_weap_box 		= ["Box_East_WpsSpecial_F","Box_East_WpsLaunch_F","Box_East_Wps_F","Box_East_Support_F","Box_East_Grenades_F","Box_East_AmmoOrd_F","Box_East_Ammo_F"];
		BTC_enemy_static		= ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AA_F","O_static_AT_F","O_Mortar_01_F"];
		BTC_friendly_static		= ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AA_F","I_static_AT_F","I_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_OPFOR_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["I_UAV_02_F","I_UAV_02_CAS_F","I_UAV_01_F"];
		BTC_UGV					= ["I_UGV_01_F","I_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'CSAT'"];};};
		
	};
	
	case 7 :
	{
		BTC_friendly_side1		= RESISTANCE;
		BTC_friendly_side2		= RESISTANCE;
		// VS
		BTC_enemy_side1			= WEST;
		BTC_enemy_side2			= WEST; 
		BTC_ene_sold_type		= "B_Soldier_base_F";
		
		BTC_enemy_TL	 		= "B_Soldier_SL_F";
		BTC_enemy_Off			= "B_officer_F";
		BTC_enemy_crewmen 		= "B_crew_F";	
		BTC_enemy_pilot	 		= "B_Helipilot_F";
		BTC_friendly_pilot	 	= "O_helipilot_F";
		BTC_enemy_heli_wreck	= "Land_Wreck_Heli_Attack_02_F";
		BTC_enemy_medic	 		= "B_medic_F";
		BTC_enemy_units	 		= ["B_Soldier_lite_F","B_Soldier_F","B_Soldier_F","B_Soldier_F","B_Soldier_02_f","B_Soldier_03_f","B_Soldier_GL_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_TL_F","B_soldier_M_F","B_soldier_LAT_F","B_medic_F","B_soldier_repair_F","B_soldier_exp_F","B_spotter_F","B_sniper_F","B_Soldier_A_F","B_soldier_AT_F","B_soldier_AA_F","B_engineer_F","B_crew_F","B_officer_F","B_Competitor_F","B_soldier_AAR_F","B_soldier_AAT_F","B_soldier_AAA_F"];
		BTC_enemy_veh 			= ["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_MRAP_01_F","B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_Truck_01_transport_F","B_Truck_01_covered_F"]; //,"B_Quadbike_01_F"
		BTC_enemy_recon			= ["B_spotter_F","B_sniper_F","B_recon_F","B_recon_LAT_F","B_recon_exp_F","B_recon_medic_F","B_recon_TL_F","B_recon_M_F","B_recon_JTAC_F"];
		BTC_enemy_tracked		= ["B_APC_Tracked_01_AA_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_MBT_01_arty_F","B_APC_Wheeled_01_cannon_F"];
		BTC_enemy_heli 			= ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Light_01_F","B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Light_01_F","B_Heli_Transport_01_F"];
		BTC_enemy_boats 		= ["B_Boat_Armed_01_minigun_F","B_Boat_Armed_01_minigun_F","B_Boat_Transport_01_F","B_Boat_Transport_01_F","B_SDV_01_F"];
		BTC_enemy_diver			= ["B_diver_F","B_diver_TL_F","B_diver_exp_F"];
		BTC_enemy_diver_TL		= "B_diver_TL_F";
		BTC_enemy_outpost	    = ["B_medic_F","B_soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F"];
		BTC_friendly_outpost	= ["I_medic_F","I_soldier_AR_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F"];
		BTC_enemy_tent			= "Land_TentDome_F"; //"Land_TentA_F" "Land_TentDome_F"
		BTC_enemy_conv_cars		= ["B_APC_Wheeled_01_cannon_F","B_MRAP_01_hmg_F","B_Truck_01_covered_F","B_APC_Tracked_01_AA_F"];
		BTC_enemy_weap_box 		= ["Box_NATO_Wps_F","Box_NATO_WpsSpecial_F","Box_NATO_Ammo_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F"];
		BTC_enemy_static		= ["B_HMG_01_high_F","B_GMG_01_high_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F"];
		BTC_friendly_static		= ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AA_F","I_static_AT_F","I_Mortar_01_F"];
		BTC_enemy_camonet_open  = "CamoNet_BLUFOR_open_F"; //"CamoNet_OPFOR_open_F" "CamoNet_INDP_open_F"
		BTC_UAV					= ["I_UAV_02_F","I_UAV_02_CAS_F","I_UAV_01_F"];
		BTC_UGV					= ["I_UGV_01_F","I_UGV_01_rcws_F"];
		
		_info=[] spawn {if (BTC_debug == 1) 
		then {waitUntil {sleep 1;(player == player)}; player sideChat format["'SIDE PATROL' ENEMY SIDE IT'S 'WEST'"];};};
	};
}; // FINE PARENTESI SWITCH
///////////////////////////












