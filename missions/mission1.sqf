///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Clear the area from enemies!

if (isServer) then {
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION MISSION 1","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 1' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 1"]);

// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M1"]);
_position = call BTC_fnc_choselocation;
"areaI" setMarkerPos BTC_position;
 mrk_side_miss = "areaI";
// // // // // // // // // // // // // // // // // // // //

//_pos = markerpos "civilian_38"; //**//**//**// ONLY FOR TEST //**//**//**//**//**
//mrk_side_miss setMarkerPos _pos;
_mrk_dim = (70 + (BTC_difficulty * 15));

if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M1 DONE","plain down",0];}; diag_log (format["MARKER SELECTION M1 DONE"]);

"areaI" setMarkerPos getMarkerPos mrk_side_miss;
"areaI" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// Crea Veicoli nemici
if (BTC_vehicles == 1) then 
{
	"areaV" setMarkerPos getMarkerPos mrk_side_miss; "areaV" setMarkerSize [_mrk_dim *2, _mrk_dim *2];
	_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; sleep 1;
	if (BTC_difficulty > 0) then {_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; }; sleep 1;
	_rndVehicle = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
	if (BTC_difficulty > 3) then {_spawn_veh = ["areaV","areaV",_rndVehicle] spawn BTC_spawn_veh; }; sleep 1;
	_rndVehicle = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
	if (BTC_difficulty > 10) then {_spawn_veh = ["areaV","areaV",_rndVehicle] spawn BTC_spawn_veh; };
};

// Crea nemici fanteria
for "_i" from 0 to (3 + (BTC_difficulty)) do
{_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};

player sidechat format ["BTC_enemy_side: %1", BTC_enemy_side];

if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M1","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER M1"]);


//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
///// MISSION CREATION COMPLETE /////
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_1",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk01",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk01" != "")};
BTC_start_mission_1 = true; sleep 1; publicVariable "BTC_start_mission_1";
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side];
_clr = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)",
"{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo numero di nemici rimanenti
BTCM_side_miss_end1 = false; publicVariableServer "BTCM_side_miss_end1";
_check = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_1)&&(count thislist <= 1)","
BTCM_side_miss_end1 = true; publicVariableServer 'BTCM_side_miss_end1';"] spawn BTC_create_trigger_count_unit;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 1 COMPLETE","plain down",0];};
diag_log (format["SPAWN ENEMIES MISSION 1 COMPLETE"]);

_null = [mrk_side_miss,_mrk_dim] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
if (BTC_stc_city == 1) then {[mrk_side_miss] execVM "scripts\patrol\patrols_STAT.sqf";};

/////////////////////////////////////////////////////// MISSION END ///////////////////////////////////////
_nul = [] spawn 
{
	waitUntil {sleep 3; (BTCM_side_miss_end1)};
	///// MISSION END /////
	if !(skip_var)
	then { //missione conclusa
	"mrk01" setMarkerSize [3,3]; "mrk01" setMarkerColor mrk_color_end; "mrk_miss_1" setMarkerColor mrk_color_end; skip_miss1 = false; publicVariable "skip_miss1";}
	else {	// missione cancellata dall'utente
	"mrk01" setMarkerSize [3,3]; "mrk01" setMarkerColor "ColorGrey"; "mrk_miss_1" setMarkerColor "ColorGrey"; skip_miss1 = true; publicVariable "skip_miss1";};

	"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
	side_chose_init = true; publicVariableServer "side_chose_init"; 
	BTC_end_mission_1 = true; publicVariable "BTC_end_mission_1";
};


diag_log "======================== 'SIDES PATROLS' END 'MISSION 1' by =BTC= MUTTLEY ========================";
};








