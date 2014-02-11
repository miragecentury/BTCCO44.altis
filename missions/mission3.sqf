///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Destroy vehicles
//chose marker for spawning  OK
if (isServer) then 
{
	trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
	kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
	if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M3","plain down",0];};
	diag_log "======================== 'SIDES PATROLS' START 'MISSION 3' by =BTC= MUTTLEY ========================";
	diag_log (format["MARKER SELECTION MISSION 3"]);
	
// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M3"]);
_position = call BTC_fnc_choselocation;
"areaI" setMarkerPos BTC_position;
 mrk_side_miss = "areaI"; 
// // // // // // // // // // // // // // // // // // // //

if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M3 DONE","plain down",0];};
diag_log (format["MARKER SELECTION M3 DONE"]);
if (BTC_debug == 1) then {"debug_mrk" setMarkerPos getMarkerPos mrk_side_miss;};
_mrk_dim = (150 + (BTC_difficulty * 15));
"areaV" setMarkerPos getMarkerPos mrk_side_miss; "areaV" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8]; 
"areaI" setMarkerPos getMarkerPos mrk_side_miss; "areaI" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];	


if (BTC_debug == 1) then {player sideChat "CREATE CARS OBJECTIVE M3";};
diag_log (format["CREATE CARS OBJECTIVE M3"]);

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// Veicoli obiettivo della missione
//Level 1: qty 2
if (BTC_debug == 1) then {player sideChat "CREATE CAR 1 OBJECTIVE M3";};
_vehi1 = ["areaV","areaV",(BTC_enemy_veh select 0)] spawn BTC_spawn_veh;
if (BTC_debug == 1) then {player sideChat "CREATE CAR 2 OBJECTIVE M3";};
_vehi2 = ["areaV","areaV",(BTC_enemy_veh select 1)] spawn BTC_spawn_veh; 
//Level 2: qty 3
if (BTC_difficulty > 0) then 
{
	_vehi3 = ["areaV","areaV",""] spawn BTC_spawn_veh; 
};
//Level 3: qty 4
if (BTC_difficulty > 3) then 
{
	_tracked = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
	_vehi4 = ["areaV","areaV",_tracked] spawn BTC_spawn_veh;		
};
//Level 4: qty 5
if (BTC_difficulty > 10) then 
{
	_tracked = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
	_vehi4 = ["areaV","areaV",_tracked] spawn BTC_spawn_veh;
};

////////////////////////
// Crea nemici fanteria
for "_i" from 0 to (3 + (BTC_difficulty)) do
{_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};
/////////////////////////////////////////////////////////

// Controllo numero di nemici rimanenti
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
/////////////////////////////////////////////////////////
mrk_dim = _mrk_dim;
numVehicle3 = 0;
_count_unit = [] spawn 
{
	_Vehiclepos 	= GetmarkerPos mrk_side_miss;
	_Vehicleradius 	= mrk_dim *2;
	_numVehicle3 = 0;
	_Vehicle = [];
	while {!(BTC_end_mission_3)} do
	{	//"LandVehicle"
		_Vehicle = nearestObjects [_Vehiclepos, ["LandVehicle"], _Vehicleradius];
	   if (count _Vehicle > 0) then
	   {
		  _numVehicle3 = {Alive _x && side _x == BTC_enemy_side1} count _Vehicle;
		  numVehicle3 = _numVehicle3;
		   if (BTC_debug == 1) then {player sidechat format ["Vehicle to destroy: %1",_numVehicle3];};
	   };
	 sleep 5;
	};
};
waitUntil {sleep 0.1; (numVehicle3 > 1)};

if (BTC_debug == 1) then {Titletext ["CREATE OBJECTIVES M3 ***DONE***","plain down",0];};
diag_log (format["CREATE OBJECTIVES M3 ***DONE***"]);


if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M3","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER M3"]);



///// MISSION CREATION COMPLETE /////	
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_3",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk03",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk03" != "")};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_3 = true; publicVariable "BTC_start_mission_3";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 3 COMPLETE","plain down",0];}; diag_log (format["SPAWN ENEMIES MISSION 3 COMPLETE"]);
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side];
_clr = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)",
"{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo numero di nemici rimanenti
BTCM_side_miss_end3 = false; publicVariableServer "BTCM_side_miss_end3";
_check = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_3)&&(count thislist <= (round(1+ ((BTC_difficulty) /3))))&&(numVehicle3 == 0)","
BTCM_side_miss_end3 = true; publicVariableServer 'BTCM_side_miss_end3';"] spawn BTC_create_trigger_count_unit;

_null = [mrk_side_miss,_mrk_dim] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////// MISSION END ////////////////////////////////////////////////////////////
_nul = [] spawn 
{ 
	waitUntil {sleep 5; (BTCM_side_miss_end3)};
	if !(skip_var)
	then { //missione conclusa
	"mrk03" setMarkerSize [3,3]; "mrk03" setMarkerColor mrk_color_end; "mrk_miss_3" setMarkerColor mrk_color_end; skip_miss3 = false; publicVariable "skip_miss3";}
	else {	// missione cancellata dall'utente
	"mrk03" setMarkerSize [3,3]; "mrk03" setMarkerColor "ColorGrey"; "mrk_miss_3" setMarkerColor "ColorGrey"; skip_miss3 = true; publicVariable "skip_miss3";};

	"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
	side_chose_init = true; publicVariableServer "side_chose_init";
	BTC_end_mission_3 = true; publicVariable "BTC_end_mission_3";
};


diag_log "======================== 'SIDES PATROLS' END 'MISSION 3' by =BTC= MUTTLEY ========================";
};				












