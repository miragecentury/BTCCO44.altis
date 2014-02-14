/////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley				   //
/// Visit us: www.blacktemplars.altervista.org //
/////////////////////////////////////////////////

diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";
diag_log (format["'SIDES PATROLS' MISSION INIT START"]);

_spawn = [] spawn {waitUntil{!isnil "bis_fnc_init"}; diag_log (format["BIS FUNCTION INIT DONE"]);};
if (isServer) then {init_server_done = false; publicVariable "init_server_done";};
0 fadeSound 0;
titletext ["Loading...","BLACK FADED"]; 
enableSaving [false, false];
[] execVM "briefing.sqf";

{_x setmarkeralpha 0;} foreach ["sector_NW","sector_NE","sector_SW","sector_SE"];
{_x setmarkeralpha 0;} foreach ["Altis_area","mrk_rally_point","base","areaS","areaI","areaV","areaC"]; 
{_x setMarkerAlpha 0;} foreach ["BTC_PTR_MRK_SEA","BTC_PTR_MRK_SEA_1","BTC_PTR_MRK_SEA_2","BTC_PTR_MRK_SEA_3","BTC_PTR_MRK_SEA_4","BTC_PTR_MRK_SEA_5","BTC_PTR_MRK_SEA_6","BTC_PTR_MRK_SEA_7","BTC_PTR_MRK_SEA_8","BTC_PTR_MRK_SEA_9","BTC_PTR_MRK_SEA_10","BTC_PTR_MRK_SEA_11","BTC_PTR_MRK_SEA_12","BTC_PTR_MRK_SEA_13","BTC_PTR_MRK_SEA_14","BTC_PTR_MRK_SEA_15","BTC_PTR_MRK_SEA_16","BTC_PTR_MRK_SEA_17","BTC_PTR_MRK_SEA_18","BTC_PTR_MRK_SEA_19","BTC_PTR_MRK_SEA_20","BTC_PTR_MRK_SEA_21","BTC_PTR_MRK_SEA_22","BTC_PTR_MRK_SEA_23","BTC_PTR_MRK_SEA_24","BTC_PTR_MRK_SEA_25","BTC_PTR_MRK_SEA_26","BTC_PTR_MRK_SEA_27","BTC_PTR_MRK_SEA_28","BTC_PTR_MRK_SEA_29","BTC_PTR_MRK_SEA_30","BTC_PTR_MRK_SEA_31"];
{_x setMarkerAlpha 0;} foreach ["civilian","civilian_1","civilian_2","civilian_3","civilian_4","civilian_5","civilian_6","civilian_7","civilian_8","civilian_9","civilian_10","civilian_11","civilian_12","civilian_13","civilian_14","civilian_15","civilian_16","civilian_17","civilian_18","civilian_19","civilian_20","civilian_21","civilian_22","civilian_23","civilian_24","civilian_25","civilian_26","civilian_27","civilian_28","civilian_29","civilian_30","civilian_31","civilian_32","civilian_33","civilian_34","civilian_35","civilian_36","civilian_37","civilian_38","civilian_39","civilian_40","civilian_41","civilian_42","civilian_43","civilian_44","civilian_45","civilian_46","civilian_47","civilian_48","civilian_49","civilian_50","civilian_51","civilian_52","civilian_53","civilian_54","civilian_55","civilian_56","civilian_57","civilian_58","civilian_59","civilian_60","civilian_61","civilian_62","civilian_63"];

//Call definitions
call compile preprocessFile "BTC_definitions.sqf";
call compile preprocessFile "BTC_definitionsAmmo.sqf";

//BTC Logistic & Revive 
///_spwn = [] spawn {sleep 10; call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";diag_log (format["MISSION INIT =BTC=_revive_init.sqf INIT DONE"]);}; 
_spwn = [] spawn {sleep 10; call compile preprocessFile "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";diag_log (format["MISSION INIT BTC_Logistic_Init.sqf INIT DONE"]);}; 

//Init server & client
if (isServer) then { call compile preprocessFile "init_server.sqf"; diag_log (format["MISSION INIT init_server.sqf START"]);}; 
if !(isDedicated) then {call compile preprocessFile "init_client.sqf"; diag_log (format["MISSION INIT init_client.sqf START"]);}; 

//Remove dead [DistanceDelTime,ManDelTime,VehDelTime]
_null = [1000,5,600] execVM "scripts\removedead.sqf";

//////////////////////// Code specific for aerial taxi scripts////////////////////////
_spwn = [] spawn {
WaitUntil {!(isNil "BTC_taxi")};
if (BTC_taxi == 1) then 
{
	////////////////////////////
	// © OCTOBER 2011 - norrin
	// Add the following line for MP games
	if (!isServer) then {while {isNull player} do {Sleep 0.1}};
	// Start heli taxi scripts
	[slick1,escort1] execVM "scripts\heloGoTo\heliTaxi_init.sqf";
	// For extraction action at start-up
	player setVariable ["NORRN_taxiHeli", slick1, true];
	// Set this var to true if you do not want the taxi or escort to respawn
	//NORRN_aerialTaxiRespawnOff = true;
	// Set these vars to true if you do not downed chopper or chopper crew deleted
	NORRN_FR_keepOldCrew = false;
	NORRN_FR_keepOldHeli = false;
	///////////////////////////////////////////////////////////////////////////////////////
} 
else 
{
	if !(isDedicated) then {"taxi_mrk" setmarkeralpha 0;};
	if (isServer) then 
	{
		deletemarker "taxi_mrk"; 
		if (Alive slick1) then
		{
			{deleteVehicle _X} forEach crew slick1; {deleteVehicle _X} forEach crew escort1;
			{deleteVehicle _X} forEach [slick1,escort1];
		};
	};
};
}; /////

_spwn = [] spawn {
WaitUntil {sleep 1; !(isNil "BTC_fast_time")};
if (BTC_fast_time == 1) then {[3,TRUE,false] execFSM "core_time\core_time.fsm";}; // TRUE = abilita il SetDate per le nuvole
if (BTC_fast_time == 2) then {[6,TRUE,false] execFSM "core_time\core_time.fsm";};
if (BTC_fast_time == 3) then {[12,TRUE,false] execFSM "core_time\core_time.fsm";};
if (BTC_fast_time == 4) then {[24,TRUE,false] execFSM "core_time\core_time.fsm";};
};

BTC_fnc_choselocation = compile preprocessFile "missions\fn_choselocation.sqf";
BTC_fnc_choselocation_out = compile preprocessFile "missions\fn_choselocation_out.sqf";

diag_log (format["'SIDES PATROLS' MISSION INIT END"]);
diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";

finishMissionInit;





