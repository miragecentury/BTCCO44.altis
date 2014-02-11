///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org  //
///////////////////////////////////////////////////
player sideChat "Initialization Server...";
diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";
diag_log (format["'SIDES PATROLS' INIT SERVER START"]);

//Set friendships
BTC_enemy_side1 	setFriend [BTC_friendly_side1 , 0];
BTC_friendly_side1 	setFriend [BTC_enemy_side1 , 	0];
BTC_enemy_side2 	setFriend [BTC_friendly_side1 ,	0];		
BTC_friendly_side1 	setFriend [BTC_enemy_side2 , 	0];	
BTC_friendly_side2 	setFriend [BTC_enemy_side2 , 	0];		
BTC_friendly_side2 	setFriend [BTC_enemy_side1 , 	0];	
BTC_enemy_side1 	setFriend [BTC_enemy_side2 , 	1];	
BTC_enemy_side2 	setFriend [BTC_enemy_side1 , 	1];	
BTC_friendly_side1 	setFriend [BTC_friendly_side2 , 1];	
BTC_friendly_side2 	setFriend [BTC_friendly_side1 , 1];	

call compile preprocessFile "BTC_fnc_server.sqf";
onPlayerDisconnected { [_id, _name, _uid] call compile preprocessfilelinenumbers "scripts\playerDisconnected.sqf" };
onPlayerConnected { [] execVM "scripts\playerConnected.sqf" };
[] spawn {
WaitUntil {!(isNil ("BTC_weather"))};
if (BTC_debug == 0) then 
{
	if (BTC_weather == 100)
	then {call compile preprocessFile "Scripts\DRN\DynamicWeatherEffects\DynamicWeatherEffects.sqf";}
	else {_null = [] execVM "scripts\BTC_weather.sqf";};
};
setDate [2013,BTC_month,BTC_day,BTC_hour,BTC_minutes];
};

// Variablili lato client per le tasks ///////
BTC_start_mission_1 = false; sleep 0.01; publicVariable "BTC_start_mission_1"; BTC_start_mission_2 = false; sleep 0.01; publicVariable "BTC_start_mission_2";BTC_start_mission_3 = false; sleep 0.01; publicVariable "BTC_start_mission_3";BTC_start_mission_4 = false; sleep 0.01; publicVariable "BTC_start_mission_4";BTC_start_mission_5 = false; sleep 0.01; publicVariable "BTC_start_mission_5"; BTC_start_mission_6 = false; sleep 0.01; publicVariable "BTC_start_mission_6"; BTC_start_mission_7 = false; sleep 0.01; publicVariable "BTC_start_mission_7"; BTC_start_mission_8 = false; sleep 0.01; publicVariable "BTC_start_mission_8"; BTC_start_mission_9 = false; sleep 0.01; publicVariable "BTC_start_mission_9";BTC_start_mission_10 = false; sleep 0.01; publicVariable "BTC_start_mission_10";BTC_start_mission_11 = false; sleep 0.01; publicVariable "BTC_start_mission_11";BTC_start_mission_12 = false; sleep 0.01; publicVariable "BTC_start_mission_12";
BTC_end_mission_1 = false; sleep 0.01; publicVariable "BTC_end_mission_1"; BTC_end_mission_2 = false; sleep 0.01; publicVariable "BTC_end_mission_2";BTC_end_mission_3 = false; sleep 0.01; publicVariable "BTC_end_mission_3";BTC_end_mission_4 = false; sleep 0.01; publicVariable "BTC_end_mission_4";BTC_end_mission_5 = false; sleep 0.01; publicVariable "BTC_end_mission_5"; BTC_end_mission_6 = false; sleep 0.01; publicVariable "BTC_end_mission_6"; BTC_end_mission_7 = false; sleep 0.01; publicVariable "BTC_end_mission_7"; BTC_end_mission_8 = false; sleep 0.01; publicVariable "BTC_end_mission_8"; BTC_end_mission_9 = false; sleep 0.01; publicVariable "BTC_end_mission_9"; BTC_end_mission_10 = false; sleep 0.01; publicVariable "BTC_end_mission_10"; BTC_end_mission_11 = false; sleep 0.01; publicVariable "BTC_end_mission_11";BTC_end_mission_12 = false; sleep 0.01; publicVariable "BTC_end_mission_12";
task_end_var = false; sleep 0.01; publicVariable "task_end_var"; all_miss_end = false; sleep 0.01; publicVariable "all_miss_end"; skip_var = false; sleep 0.01; publicVariable "skip_var";
// Variabili lato server per alcuni script ///
/////BTC_place_miss = 0; sleep 0.01; publicVariable "BTC_place_miss";
TRACK_Instances = 0; sleep 0.01; publicVariable "TRACK_Instances"; chose_mrk_rnd = true; sleep 0.01; publicVariable "chose_mrk_rnd"; side_chose_init = true; sleep 0.01; publicVariable "side_chose_init"; 
BTC_All_task_end = false; sleep 0.01; publicVariable "BTC_All_task_end";
COMANDO = objNull;ALPHA_TEAM_LEADER = objNull;BRAVO_TEAM_LEADER = objNull;CHARLIE_TEAM_LEADER = objNull;DELTA_TEAM_LEADER = objNull;ECO_TEAM_LEADER = objNull;FOXTROT_TEAM_LEADER = objNull;CARRISTA_TL = objNull;SOMMOZZATORE_TL = objNull;RICOGNITORE_TL = objNull;JULIET_TEAM_LEADER = objNull;KILO_PILOT_TL = objNull;
BTC_chosemarker_init = false; sleep 0.01; publicVariableServer "BTC_chosemarker_init";
BTC_mission_request = false; sleep 0.01; publicVariable "BTC_mission_request";
BTC_RALLY_DEPLOYED = false; publicVariable "BTC_RALLY_DEPLOYED";

// Markers control
if (BTC_markers > 0) then 
{
	_nul = [] spawn 
	{
		while {(true)} do 
		{ sleep 1;
			"mrk_rally_point" setMarkerPos getPos RALLY_POINT;
			if !(isNil ("COMANDO_BTC")) then {if (Alive leader COMANDO_BTC) then {"comando_mrk" setMarkerPos getPos leader COMANDO_BTC;} else {"comando_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("ALPHA")) then {if (Alive leader ALPHA) then {"alpha_mrk" setMarkerPos getPos leader ALPHA;} else {"alpha_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("BRAVO")) then {if (Alive leader BRAVO) then {"bravo_mrk" setMarkerPos getPos leader BRAVO;} else {"bravo_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("CHARLIE")) then {if (Alive leader CHARLIE) then {"charlie_mrk" setMarkerPos getPos leader CHARLIE;} else {"charlie_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("DELTA")) then {if (Alive leader DELTA) then {"delta_mrk" setMarkerPos getPos leader DELTA;} else {"delta_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("ECO")) then {if (Alive leader ECO) then {"eco_mrk" setMarkerPos getPos leader ECO;} else {"eco_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("FOXTROT")) then {if (Alive leader FOXTROT) then {"foxtrot_mrk" setMarkerPos getPos leader FOXTROT;} else {"foxtrot_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("GOLF")) then {if (Alive leader GOLF) then {"golf_mrk" setMarkerPos getPos leader GOLF; } else {"golf_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("HOTEL")) then {if (Alive leader HOTEL) then {"hotel_mrk" setMarkerPos getPos leader HOTEL;} else {"hotel_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("INDIA")) then {if (Alive leader INDIA) then {"india_mrk" setMarkerPos getPos leader INDIA;} else {"india_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("JULIET")) then {if (Alive leader JULIET) then {"juliet_mrk" setMarkerPos getPos leader JULIET;} else {"juliet_mrk" setMarkerPos [-80000,-40000,0];};};
			if !(isNil ("KILO")) then {if (Alive leader KILO) then {"kilo_mrk" setMarkerPos getPos leader KILO;} else {"kilo_mrk" setMarkerPos [-80000,-40000,0];};};
		};
	}; 
};
// AI skill by Giallustio
If (BTC_AI_skill > 10) then { _AI = [] spawn BTC_AI_loop;};

// TPWCAS
if (isClass(configFile >> "cfgPatches" >> "CBA_main")) then 
{
	If (TPWCAS == 1) then 
	{
		null = [3] execvm "tpwcas\tpwcas_script_init.sqf";
		If (BTC_debug >= 1)	then {tpwcas_debug = 1;};
	};
};

// Patrols vehicles/infantry on island
if (isServer) then {[] execVM "scripts\patrol\patrols_init.sqf";};

// Compositons
_nul = [] execVM "scripts\BTC_compositions.sqf";

_SideHQ_e = createCenter east;
_SideHQ_w = createCenter west;

// Debug
If (BTC_debug == 0) then {deleteVehicle kill_trg; deleteVehicle camera_trg;};
if (BTC_debug >= 1) then {BTC_track = true; publicVariableServer "BTC_track";} else {BTC_track = false; publicVariableServer "BTC_track";}; // <<<<<<<<<<<<<<<<<<<

//All missions over
_end_task = [] spawn 
{	
	waitUntil 
	{
		sleep 4; 
		((BTC_end_mission_1) && (BTC_end_mission_2) && (BTC_end_mission_3) && 
		 (BTC_end_mission_4) && (BTC_end_mission_5) && (BTC_end_mission_6) && 
		 (BTC_end_mission_7) && (BTC_end_mission_8) && (BTC_end_mission_9) &&
		 (BTC_end_mission_10)&& (BTC_end_mission_11) && (BTC_end_mission_12))
	}; 
	chose_mission = false; publicVariableServer "chose_mission"; BTC_All_task_end = true; sleep 0.5; publicVariable "BTC_All_task_end"; 
};

//Start scelta missioni
If (BTC_debug >= 1) 
then {_nul = [] execVM "missions\chosemission.sqf";}
else {_nul = [] spawn {sleep 30; _nul = [] execVM "missions\chosemission.sqf";};};


init_server_done = true;  sleep 0.5; publicVariable "init_server_done";
diag_log (format["'SIDES PATROLS' INIT SERVER END"]);
diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";
player sideChat "Initialization Server Complete";



