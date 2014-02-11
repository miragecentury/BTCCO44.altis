/////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley				   //
/// Visit us: www.blacktemplars.altervista.org //
/////////////////////////////////////////////////

//Destroy the convoy

if (isServer) then 
{
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
side_miss_end = false; publicVariableServer "side_miss_end";
skip_miss11 = false; publicVariable "skip_miss11";
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
BTCM_side_miss_end11 = false; publicVariable "BTCM_side_miss_end11"; 
side_conv_end = false; publicVariable "side_conv_end"; "debug_mrk" setMarkerAlpha 0;

if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M11","plain down",0]; "debug_mrk" setMarkerAlpha 1;};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 11' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 11 START"]);

//trigger per cancellare nemici in caso skip missione debug
_clr = ["conv_str_1",0,"LOGIC","PRESENT","kill_var OR skip_var","
{deleteVehicle _X} forEach crew CONV1; {deleteVehicle _X} forEach crew CONV2; {deleteVehicle _X} forEach crew CONV3;
{deleteVehicle _X} forEach crew CONV4; {deleteVehicle _X} forEach crew CONV5; 
{deleteVehicle _X} forEach [CONV1,CONV2,CONV3,CONV4,CONV5]; 
if (BTC_difficulty >= 10)then {
{deleteVehicle _X} forEach crew CONV6;
{deleteVehicle _X} forEach crew CONV7;
{deleteVehicle _X} forEach crew CONV8;
{deleteVehicle _X} forEach [CONV6,CONV7,CONV8];};
 kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;

 chose_mrk_rnd = true;
while {(chose_mrk_rnd)} do
{
_rndS = round ( Random 3)+1; 
//_rndS = 1; ////////////////***************/////////////////******************
//West Altis
if (_rndS==1) then {mrk_side_conv_str = "conv_str_1"; mrk_side_conv_end = ["conv_end_1","conv_end_2","conv_end_3"] call BIS_fnc_selectRandom;}; 
if (_rndS==2) then {mrk_side_conv_str = "conv_str_2"; mrk_side_conv_end = ["conv_end_1","conv_end_2","conv_end_3"] call BIS_fnc_selectRandom;}; 
//East Altis
if (_rndS==3) then {mrk_side_conv_str = "conv_str_3"; mrk_side_conv_end = ["conv_end_4","conv_end_5"] call BIS_fnc_selectRandom;}; 
if (_rndS==4) then {mrk_side_conv_str = "conv_str_4"; mrk_side_conv_end = ["conv_end_4","conv_end_5"] call BIS_fnc_selectRandom;}; 
_mrk_pos = getMarkerPos mrk_side_conv_str;
if (({((side _x == BTC_friendly_side1) OR (side _x == BTC_friendly_side2)) && ((_x distance _mrk_pos) < 2500)} count allUnits) > 0)
then {chose_mrk_rnd = true;} else {chose_mrk_rnd = false;}; 
};
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M11 DONE","plain down",0]; diag_log (format["MARKER SELECTION MISSION 11 DONE"]);};

if !(Alive dest_obj) exitwith {diag_log (format["Error: Missing marker, !alive 'dest_obj'"]); hint "Error: Missing marker, !alive 'dest_obj'";};
dest_obj setPos getMarkerPos mrk_side_conv_end;
if (BTC_debug == 1) then {_spawn = [0.7,0.7,0,"ICON","Border",mrk_color_start,"Start convoy","mil_start","mrk11s",mrk_side_conv_str] spawn BTC_create_marker;}; 
_spawn = [0.7,0.7,0,"ICON","Border",mrk_color_start,"End convoy","mil_end","mrk11e",mrk_side_conv_end] spawn BTC_create_marker; //Marker per le tasks
//
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M11 DONE","plain down",0];};
diag_log (format["MARKER SELECTION MISSION 11 END"]);

"areaV" setMarkerPos getMarkerPos mrk_side_conv_str; "areaV" setMarkerSize [50, 50]; 
if (BTC_debug == 1) then {Titletext ["CONVOY SPAWN M11","plain down",0];};
diag_log (format["CONVOY SPAWN M11"]);

//////////////////////////////////////////////////////////// CREAZIONE CONVOGLIO ///////////////////////////////////////////////////////////////////////////////

	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 0,"CONV1"] spawn BTC_spawn_veh_conv; // HEAD HEAVY
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 2,"CONV2"] spawn BTC_spawn_veh_conv; // TRUCK
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 2,"CONV3"] spawn BTC_spawn_veh_conv; // TRUCK
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 2,"CONV4"] spawn BTC_spawn_veh_conv; // TRUCK
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 1,"CONV5"] spawn BTC_spawn_veh_conv; // CAR
	waitUntil {(  !(isNil ("CONV1"))&&!(isNil ("CONV2"))&&!(isNil ("CONV3"))&&!(isNil ("CONV4"))&&!(isNil ("CONV5"))  )};
	diag_log (format["CONVOY SPAWN FIRST 5 CAR DONE"]);
if (BTC_difficulty >= 10)
then 
{
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 2,"CONV6"] spawn BTC_spawn_veh_conv; // TRUCK
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 2,"CONV7"] spawn BTC_spawn_veh_conv; // TRUCK
	_spawn_veh = ["areaV",BTC_enemy_conv_cars select 3,"CONV8"] spawn BTC_spawn_veh_conv; // HEAVY BACK
	waitUntil {(  !(isNil ("CONV6"))&&!(isNil ("CONV7"))&&!(isNil ("CONV8"))  )};
	diag_log (format["CONVOY SPAWN ALL CARS DONE"]);
};
//////////////////////////////////////////////////////////// CONVOGLIO ///////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
if (BTC_debug == 1) then {Titletext ["CONVOY SPAWN M11 *DONE*","plain down",0];};
diag_log (format["CONVOY SPAWN M11 *DONE*"]);

if (BTC_debug == 1) then {Titletext ["CREATE END MISSION TRIGGER M11","plain down",0];};
diag_log (format["CREATE END MISSION TRIGGER M11"]);

if (BTC_difficulty < 6)  
then {_n1 = [mrk_side_conv_str,0,"LOGIC","PRESENT","!Alive CONV2 && !Alive CONV3 && !Alive CONV4",
"BTCM_side_miss_end11 = true; publicVariableServer 'BTCM_side_miss_end11'; "] spawn BTC_create_trigger_count_unit;}
else {_n1 = [mrk_side_conv_str,0,"LOGIC","PRESENT","!Alive CONV2 && !Alive CONV3 && !Alive CONV4 && !Alive CONV6 && !Alive CONV7",
"BTCM_side_miss_end11 = true; publicVariableServer 'BTCM_side_miss_end11';"] spawn BTC_create_trigger_count_unit;};

//==============================================================================================================================================
///////////////////////////////////////// Controllo punto arrivo convoglio \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
if (BTC_debug == 1) then {Titletext ["CREATE END MISSION CONDITIONS M11","plain down",0];};
diag_log (format["CREATE END MISSION CONDITIONS M11"]);

_end_cond = [] spawn 
{
	WHILE {!(side_conv_end)}
	DO {
			sleep 5;
			IF (Alive CONV2) then {IF ((CONV2 distance dest_obj) < 100) THEN {side_conv_end = true; publicVariable "side_conv_end";};};
			IF (Alive CONV3) then {IF ((CONV3 distance dest_obj) < 100) THEN {side_conv_end = true; publicVariable "side_conv_end";};};
			IF (Alive CONV4) then {IF ((CONV4 distance dest_obj) < 100) THEN {side_conv_end = true; publicVariable "side_conv_end";};};
			if (BTC_difficulty > 6)	then
			{IF (Alive CONV6) then {IF ((CONV6 distance dest_obj) < 100) THEN {side_conv_end = true; publicVariable "side_conv_end";};};
			 IF (Alive CONV7) then {IF ((CONV7 distance dest_obj) < 100) THEN {side_conv_end = true; publicVariable "side_conv_end";};};};
			IF (side_conv_end) exitwith {};
		};
};

///// MISSION CREATION COMPLETE /////
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 11 COMPLETE","plain down",0];};
diag_log (format["SPAWN ENEMIES MISSION 11 COMPLETE"]);

//==============================================================================================================================================
////////////////////////////////////////////// PARTENZA CONVOGLIO \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


if (BTC_difficulty > 5) 
then {_spw = [[CONV1,CONV2,CONV3,CONV4,CONV5,CONV6,CONV7,CONV8],7,50] execVM "missions\convoy.sqf"; {if(Alive _x) then {_x AllowDamage false;};} foreach [CONV1,CONV2,CONV3,CONV4,CONV5,CONV6,CONV7,CONV8];}
else {_spw = [[CONV1,CONV2,CONV3,CONV4,CONV5],7,50] execVM "missions\convoy.sqf"; {if(Alive _x) then {_x AllowDamage false;};} foreach [CONV1,CONV2,CONV3,CONV4,CONV5];};

////////////////////////////////////////////// PARTENZA CONVOGLIO \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//==============================================================================================================================================


BTC_start_mission_11 = true; sleep 1; publicVariable "BTC_start_mission_11";
////////////////////////////////////////////////////////////// MISSION END ///////////////////////////////////////////////////////////////////
//==============================================================================================================================================

_end_cond = [] spawn 
{ waitUntil {sleep 3; ((BTCM_side_miss_end11) OR (side_conv_end)) };

		// Convoglio distrutto
		if ((BTCM_side_miss_end11) && !(side_conv_end) && !(skip_var))
		then { skip_miss11 = false; publicVariable "skip_miss11"; };

		// Convoglio a destinazione
		if ((side_conv_end) && !(BTCM_side_miss_end11) && !(skip_var)) 
		then 
		{ skip_miss11 = false; publicVariable "skip_miss11";
			_del_veh = [] spawn 
			{
				_skyp_cond = [] spawn 
				{
				waitUntil{ sleep 5; ((getPos Player) distance (getMarkerPos mrk_side_conv_end) > 1500)};
				{deleteVehicle _x} forEach crew CONV1; {deleteVehicle _x} forEach crew CONV2; {deleteVehicle _x} forEach crew CONV3;
				{deleteVehicle _x} forEach crew CONV4; {deleteVehicle _x} forEach crew CONV5; 
				{deleteVehicle _x} forEach [CONV1,CONV2,CONV3,CONV4,CONV5]; 
				if (BTC_difficulty >= 10)then {
				{deleteVehicle _x} forEach crew CONV6;	{deleteVehicle _x} forEach crew CONV7; 
				{deleteVehicle _x} forEach crew CONV8; 	{deleteVehicle _x} forEach [CONV6,CONV7,CONV8];}; 
				};
			};
		}; 

		//Skip missione
		if (skip_var)
		then 
		{ skip_miss11 = true; publicVariable "skip_miss11";
			_skyp_cond = [] spawn 
			{
				waitUntil{ sleep 5; ((getPos Player) distance (getMarkerPos mrk_side_conv_str) > 1500)};
				{deleteVehicle _x} forEach crew CONV1; {deleteVehicle _x} forEach crew CONV2; {deleteVehicle _x} forEach crew CONV3;
				{deleteVehicle _x} forEach crew CONV4; {deleteVehicle _x} forEach crew CONV5; 
				{deleteVehicle _x} forEach [CONV1,CONV2,CONV3,CONV4,CONV5]; 
				if (BTC_difficulty >= 10)then {
				{deleteVehicle _x} forEach crew CONV6;	{deleteVehicle _x} forEach crew CONV7; 
				{deleteVehicle _x} forEach crew CONV8; 	{deleteVehicle _x} forEach [CONV6,CONV7,CONV8];}; 
			};
		};

"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
side_chose_init = true; publicVariableServer "side_chose_init";
BTC_end_mission_11 = true; publicVariable "BTC_end_mission_11";
if (true) exitWith {};

}; /// MISSION END ///


diag_log "======================== 'SIDES PATROLS' END 'MISSION 11' by =BTC= MUTTLEY ========================";

};






