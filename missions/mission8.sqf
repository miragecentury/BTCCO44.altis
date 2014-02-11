///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

/// Mission 8 Mortar site
//chose marker for spawning enemies OK
if (isServer) then {
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
BTCM_side_miss_end8 = false; publicVariableServer "BTCM_side_miss_end8";
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 8' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 8"]);
	
// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M8"]);
_position = call BTC_fnc_choselocation_out;
"areaI" setMarkerPos BTC_position_out;
 mrk_side_miss = "areaI";
// // // // // // // // // // // // // // // // // // // //
	
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION DONE","plain down",0];};
diag_log (format["MARKER SELECTION DONE MISSION 8"]);

_mrk_dim = 800;
_mrk_dim2 = (100 + (BTC_difficulty * 15));
"areaI" setMarkerSize [_mrk_dim2*0.8, _mrk_dim2*0.8];

if (BTC_debug == 1) then {"debug_mrk" setMarkerPos getMarkerPos mrk_side_miss;};

///// Create enemy artillery /////
condition = false;
attempt = 0;
while {!(condition)} do 
{
	FinPos = [getMarkerPos mrk_side_miss, 0, 500, 10, 0, 10 * (pi / 180), 0] call BIS_fnc_findSafePos;
	if (BTC_debug == 1) then {"debug_mrk" setMarkerPos FinPos;};
	//Avoid certain areas
	_roads = FinPos nearRoads 50;
	if (
	(({((side _x == BTC_friendly_side1) OR (side _x == BTC_friendly_side2)) && ((_x distance FinPos) < 1000)} count allUnits) > 0) ||
	((FinPos distance (getmarkerpos mrk_side_miss) > 500) || (FinPos distance (getmarkerpos "base") < 1500)) ||
	((count _roads) > 0))
	then {condition = false; attempt = attempt + 1;} else {condition = true;};
	if ((condition)) exitWith {GOOD_POS = FinPos;};
	if ((attempt == 50)) exitWith {GOOD_POS = getmarkerpos mrk_side_miss; "debug_mrk" setMarkerPos mrk_side_miss;};
	sleep 0.1;
};

// Veicoli obiettivo della missione
"areaV" setMarkerPos GOOD_POS; "areaV" setMarkerSize [100,100];
_tracked = BTC_enemy_tracked select 0;
//Level 1: qty 1
if (BTC_debug == 1) then {player sideChat "CREATE ARTY 1 OBJECTIVE M3";};
_vehi1 = ["areaV","areaV",_tracked,false] spawn BTC_spawn_veh;
//Level 2: qty 2
if (BTC_difficulty > 0) then {_vehi3 = ["areaV","areaV",_tracked,false] spawn BTC_spawn_veh;};
//Level 3: qty 3
if (BTC_difficulty > 3) then {_vehi4 = ["areaV","areaV",_tracked,false] spawn BTC_spawn_veh;};
//Level 4: qty 4
if (BTC_difficulty > 10) then {_vehi4 = ["areaV","areaV",_tracked,false] spawn BTC_spawn_veh;};

if (BTC_debug == 1) then {Titletext ["SPAWN CAMP AREA SELECTION DONE M8","plain down",0];};
diag_log (format["SPAWN CAMP AREA SELECTION DONE M8"]);	
//
"areaI" setMarkerPos GOOD_POS;
_pos = GOOD_POS;
_n = 0;
_deg = 0;
_dis = 7;
for "_i" from 0 to 15 do
{
if (_n == 8) then {_deg = _deg + 22.5; _dis = _dis + 4;};
_object = createVehicle ["Land_HBarrier_3_F", _pos, [], 0, "CAN_COLLIDE"]; _object setDir _deg; _object setVectorUp [0,0,0.01];
_myPos = _object setPos [((position _object) select 0)-(_dis)*sin(_deg), ((position _object) select 1)-(_dis)*cos(_deg), 0];
_n = _n + 1;
_deg = _deg + 45;
};

_object = createVehicle ["Land_TentA_F", _pos, [], 0, "CAN_COLLIDE"]; _object setDir (random 359);
_myPos = _object setPos [((position _object) select 0)-(12)*sin(90), ((position _object) select 1)-(12)*cos(90), 0];
_object = createVehicle ["Land_TentA_F", _pos, [], 0, "CAN_COLLIDE"]; _object setDir (random 359);
_myPos = _object setPos [((position _object) select 0)-(12)*sin(35), ((position _object) select 1)-(12)*cos(35), 0];

// SPAWN MORTAS
_nn = 0;
for "_i" from 0 to 2 do
{
_pos = [(GOOD_POS select 0)-(2)*sin(_nn),(GOOD_POS select 1)-(2)*cos(_nn),0];
_spawn = [_pos,0,(BTC_enemy_static select 4)] spawn BTC_spawn_veh;

//BUNKER AMMO
_rndBox = BTC_enemy_weap_box select (round (random ((count BTC_enemy_weap_box) - 1)));
_pos = [(GOOD_POS select 0)-(3)*sin(_nn +120),(GOOD_POS select 1)-(3)*cos(_nn +120),0];
_box = createVehicle [_rndBox, _pos, [], 0, "CAN_COLLIDE"]; _box setDir _nn;
_nn = _nn + 120; 
};

//AMMO BOX
_pos = [(GOOD_POS select 0)-(0)*sin(_nn),(GOOD_POS select 1)-(0)*cos(_nn),0];
_box = createVehicle ["Box_IND_AmmoVeh_F", _pos, [], 0, "CAN_COLLIDE"];
_object = createVehicle ["Box_IND_AmmoVeh_F", _pos, [], 0, "CAN_COLLIDE"]; _object setDir (random 359);
_myPos = _object setPos [((position _object) select 0)-(12)*sin(110), ((position _object) select 1)-(12)*cos(110), 0];
_object = createVehicle ["Box_IND_AmmoVeh_F", _pos, [], 0, "CAN_COLLIDE"]; _object setDir (random 359);
_myPos = _object setPos [((position _object) select 0)-(12)*sin(115), ((position _object) select 1)-(12)*cos(115), 0];

mrk_side_miss SetMarkerPos GOOD_POS;
/////////////////////////////////////////////////////////////////////////////////////////

if (BTC_debug == 1) then {Titletext ["SPAWN MORTAR CAMP DONE M8","plain down",0];};
diag_log (format["SPAWN MORTAR CAMP DONE M8"]);

// Crea nemici fanteria
for "_i" from 0 to (3 + (BTC_difficulty)) do
{_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};
/////////////////////////////////////////////////////////

if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER MISSION 8"]);
// Controllo numero di nemici rimanenti
//_n2 = [mrk_side_miss,0,"LOGIC","PRESENT","(!alive ammo1) && (!alive ammo2)","BTCM_side_miss_end8 = true;"] spawn BTC_create_trigger_count_unit;
numVehicle8 = 0;
_count_unit = [] spawn 
{
	_Vehicleradius 	= 150;
	_numVehicle8 = 0;
	_Vehicle = [];
	while {!(BTC_end_mission_8)} do
	{	//"Ships"
		_Vehicle = nearestObjects [GetmarkerPos mrk_side_miss, ["LandVehicle","StaticWeapon"], _Vehicleradius];
	   if (count _Vehicle > 0) then
	   {
		  _numVehicle8 = {Alive _x} count _Vehicle; 
		  numVehicle8 = _numVehicle8;
		  if (BTC_debug == 1) then {player sidechat format ["Weapons in camp to destroy: %1",_numVehicle8];};
	   };
	sleep 10;
	};
};
waitUntil{sleep 1; (numVehicle8 > 0)};

///// MISSION CREATION COMPLETE /////		
//*************
// Get a random direction 	// Get a random distance
_pos = [GOOD_POS, 250, 500, 5, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
//*************

///// MISSION CREATION COMPLETE /////
_spawn = [_mrk_dim,_mrk_dim,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_8",_pos] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk08",_pos] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk08" != "")};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_8 = true; publicVariable "BTC_start_mission_8";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 8 COMPLETE","plain down",0];}; diag_log (format["SPAWN ENEMIES MISSION 8 COMPLETE"]);	
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_clr = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo fine missione
BTCM_side_miss_end8 = false; publicVariableServer "BTCM_side_miss_end8";
_check = [mrk_side_miss,_mrk_dim,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_8) && (numVehicle8 == 0)",
"BTCM_side_miss_end8 = true; publicVariableServer 'BTCM_side_miss_end8';"] spawn BTC_create_trigger_count_unit;

_null = [mrk_side_miss,_mrk_dim] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
if (BTC_stc_city == 1) then {[mrk_side_miss] execVM "scripts\patrol\patrols_STAT.sqf";};

///// MISSION END /////
_nul = [] spawn { waitUntil {sleep 4; (BTCM_side_miss_end8)||(skip_var)};
	if !(skip_var)
	then { //missione conclusa
	"mrk08" setMarkerSize [3,3]; "mrk08" setMarkerColor mrk_color_end; "mrk_miss_8" setMarkerColor mrk_color_end; skip_miss8 = false; publicVariable "skip_miss8";}
	else {	// missione cancellata dall'utente
	"mrk08" setMarkerSize [3,3]; "mrk08" setMarkerColor "ColorGrey"; "mrk_miss_8" setMarkerColor "ColorGrey"; skip_miss8 = true; publicVariable "skip_miss8";};

side_chose_init = true; publicVariableServer "side_chose_init";
"mrk_miss_8" setMarkerSize [150,150];  
"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";"debug_mrk" setMarkerPos getMarkerPos "out_map";
BTC_end_mission_8 = true; publicVariable "BTC_end_mission_8";
if (true) exitWith {};
};


diag_log "======================== 'SIDES PATROLS' END 'MISSION 8' by =BTC= MUTTLEY ========================";

};










