///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Distruggi l'antenna nemica

if (isServer) then {
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
BTCM_side_miss_end5 = false; publicVariableServer "BTCM_side_miss_end5";
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del"; 
BTC_var_tower = false; publicVariableServer "BTC_var_tower";
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M5","plain down",0];};	
diag_log "======================== 'SIDES PATROLS' START 'MISSION 5' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 5"]);

// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M5"]);
_position = call BTC_fnc_choselocation_out;
"areaI" setMarkerPos BTC_position_out;
 mrk_side_miss = "areaI";
// // // // // // // // // // // // // // // // // // // //

if (BTC_debug == 1) then {Titletext ["MARKER SELECTION DONE M5","plain down",0];};
diag_log (format["MARKER SELECTION DONE M5"]);

_mrk_side_miss = mrk_side_miss;
_mrk_dim = (50 + (BTC_difficulty * 10));
GOOD_POS = getMarkerPos _mrk_side_miss;
"areaI" setMarkerSize [_mrk_dim*0.6, _mrk_dim*0.6];

/// Crea obiettivo antenne
_object = createVehicle ["Land_TTowerBig_2_F", GOOD_POS, [], 0, "CAN_COLLIDE"];_object setDir 0; _object setVectorUp [0,0,0.01];
_pos1 = [(GOOD_POS select 0)+12,(GOOD_POS select 1)];
_pos2 = [(GOOD_POS select 0),(GOOD_POS select 1)-12];
_pos3 = [(GOOD_POS select 0)+12,(GOOD_POS select 1)-12];
_object = createVehicle ["Land_spp_Transformer_F", _pos1, [], 0, "CAN_COLLIDE"]; _object setDir 0; //_object setVectorUp [0,0,0.01];
if (BTC_difficulty > 3) then {_object = createVehicle ["Land_TTowerBig_2_F", _pos2, [], 0, "CAN_COLLIDE"]; _object setDir 90;};
if (BTC_difficulty > 10)then {_object = createVehicle ["Land_spp_Transformer_F", _pos3, [], 0, "CAN_COLLIDE"]; _object setDir 0;};
GOOD_POS = getPos _object;


if (BTC_debug == 1) then {Titletext ["CREATE OBJECTIVE DONE M5","plain down",0];};
diag_log (format["CREATE OBJECTIVE DONE M5"]);

////////////////////////////////////////////////////////////
numVehicle5 = 0;
_count_unit = [] spawn 
{
	_Vehicleradius 	= 40;
	_numVehicle5 = 0;
	_Vehicle = [];
	while {!(BTC_end_mission_5)} do
	{  _Vehicle = nearestObjects [GOOD_POS, ["Land_TTowerBig_1_F","Land_TTowerBig_2_F","Land_spp_Transformer_F"], _Vehicleradius];
	   if (count _Vehicle >= 0) then
	   {
			_numVehicle5 = {Alive _x} count _Vehicle;
			numVehicle5 = _numVehicle5;
			if (BTC_debug == 1) then {player sideChat format ["Radio to destroy: %1",_numVehicle5];};
	   };
	 sleep 10;
	};
};
//////////////////////////////////////////////////////////////
if (BTC_debug == 1) then {Titletext ["CREATE CONTROL SCRIPT M5","plain down",0];};
diag_log (format["CREATE CONTROL SCRIPT M5"]);

waitUntil{sleep 1; (numVehicle5 > 0)};



// Crea Veicoli nemici
if (BTC_vehicles == 1) then 
{
	"areaV" setMarkerPos getMarkerPos _mrk_side_miss; "areaV" setMarkerSize [_mrk_dim *2, _mrk_dim *2];
	_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; sleep 1;
	if (BTC_difficulty > 0) then {_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; }; sleep 1;
	_rndVehicle = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
	if (BTC_difficulty > 3) then {_spawn_veh = ["areaV","areaV",_rndVehicle] spawn BTC_spawn_veh; }; sleep 1;
	_rndVehicle = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
	if (BTC_difficulty > 10) then {_spawn_veh = ["areaV","areaV",_rndVehicle] spawn BTC_spawn_veh; };
};

// Crea nemici fanteria
for "_i" from 0 to (3 + (BTC_difficulty)) do {_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};
/////////////////////////////////////////////////////////

if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M5","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER M5"]);

///// MISSION CREATION COMPLETE /////
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_5",_mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk05",_mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk05" != "")};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_5 = true; publicVariable "BTC_start_mission_5";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 5 COMPLETE","plain down",0];}; diag_log (format["SPAWN ENEMIES MISSION 5 COMPLETE"]);
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_clr = [_mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo fine missione
BTCM_side_miss_end5 = false; publicVariableServer "BTCM_side_miss_end5";
_check = [_mrk_side_miss,_mrk_dim,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_5) && (numVehicle5 == 0)",
"BTCM_side_miss_end5 = true; publicVariableServer 'BTCM_side_miss_end5';"] spawn BTC_create_trigger_count_unit;

_null = [_mrk_side_miss,_mrk_dim *2] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
if (BTC_stc_city == 1) then {["areaI"] execVM "scripts\patrol\patrols_STAT.sqf";};

///// MISSION END /////
_nul = [] spawn 
{
	waitUntil {sleep 3; (BTCM_side_miss_end5)||(skip_var)};
	if !(skip_var)
	then { //missione conclusa
	"mrk05" setMarkerSize [3,3]; "mrk05" setMarkerColor mrk_color_end; "mrk_miss_5" setMarkerColor mrk_color_end; skip_miss5 = false; publicVariable "skip_miss5";}
	else {	// missione cancellata dall'utente
	"mrk05" setMarkerSize [3,3]; "mrk05" setMarkerColor "ColorGrey"; "mrk_miss_5" setMarkerColor "ColorGrey"; skip_miss5 = true; publicVariable "skip_miss5";};

	"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";			 					
	BTC_end_mission_5 = true; publicVariable "BTC_end_mission_5";
	side_chose_init = true; publicVariableServer "side_chose_init";	
};
diag_log "======================== 'SIDES PATROLS' END 'MISSION 5' by =BTC= MUTTLEY ========================";
};








