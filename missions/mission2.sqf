///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

/// Mission 2 enemy camp OK
//chose marker for spawning enemies OK
if (isServer) then {
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M2","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 2' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 2"]);

// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M2"]);
_position = call BTC_fnc_choselocation_out;
"areaI" setMarkerPos BTC_position_out;
 mrk_side_miss = "areaI";
// // // // // // // // // // // // // // // // // // // //

if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M2 DONE","plain down",0];};
diag_log (format["MARKER SELECTION M2 DONE"]);

_mrk_dim = (70 + (BTC_difficulty * 15));
"areaI" setMarkerSize [_mrk_dim*0.6, _mrk_dim*0.6];
"areaV" setMarkerSize [_mrk_dim *2, _mrk_dim *2];

/////////////////////////////////// Create enemy camp /////////////////////////////////////////
"areaV" setMarkerPos getMarkerPos mrk_side_miss;
_pos = getMarkerPos mrk_side_miss;
_n = 0;
_deg = 0;
_dis = 7;
_barrier = "Land_BagFence_Long_F";
for "_i" from 0 to 15 do
{
	//BARRIER
	if (_n == 8) then {_deg = _deg + 22.5; _dis = _dis + 3; _barrier = "Land_HBarrier_3_F";};
	_object = createVehicle [_barrier, _pos, [], 0, "CAN_COLLIDE"]; _object setDir _deg; _object setVectorUp [0,0,0.01];
	_myPos = _object setPos [((position _object) select 0)-(_dis+2)*sin(_deg), ((position _object) select 1)-(_dis+2)*cos(_deg), 0];
	if (_n < 8) then {
	//TENTS
	_object = createVehicle [BTC_enemy_tent, _pos, [], 0, "CAN_COLLIDE"]; 
	_myPos = _object setPos [((position _object) select 0)-(_dis)*sin(_deg), ((position _object) select 1)-(_dis)*cos(_deg), 0]; };
	if (_n < 8) then {
	//WEAP/AMMO BOX
	_box = BTC_enemy_weap_box select (round (random ((count BTC_enemy_weap_box) - 1)));
	_object = createVehicle [_box, _pos, [], 0, "CAN_COLLIDE"]; 
	_myPos = _object setPos [((position _object) select 0)-(_dis)*sin(_deg +20), ((position _object) select 1)-(_dis)*cos(_deg +20), 0]; };
_n = _n + 1;
_deg = _deg + 45;
};

_nn = 180;
// Bunkers with soldiers
for "_i" from 0 to 2 do
{	_dis = 16;
	//BUNKERS
	_bunker = createVehicle ["Land_BagBunker_Small_F", _pos, [], 0, "CAN_COLLIDE"]; _bunker setDir _nn; _bunker SetVectorUp [0,0,0.01];
	_movBunk = _bunker setPos [((position _bunker) select 0)-(_dis)*sin(_nn), ((position _bunker) select 1)-(_dis)*cos(_nn), 0];
	//BUNKER UNIT
	_group = createGroup BTC_enemy_side1; 
	_sentinel = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
	_sold = _group createUnit [_sentinel, getPos _bunker, [], 0, "none"]; _sold setDir _nn;
	//BUNKER AMMO
	_rndBox = BTC_enemy_weap_box select (round (random ((count BTC_enemy_weap_box) - 1)));
	_box = createVehicle [_rndBox, getPos _bunker, [], 0, "CAN_COLLIDE"];_box setDir _nn;
	_movBox = _box setPos [((position _box) select 0)+(3)*sin(_nn), ((position _box) select 1)+(3)*cos(_nn), 0];
	
	//STATIC
	_static = BTC_enemy_static select (round (random ((count BTC_enemy_static) - 2)));
	_spw_sta = createVehicle [_static, _pos, [], 0, "CAN_COLLIDE"]; 
	_spw_sta setPos [((_pos) select 0)-(_dis)*sin(_nn +18), ((_pos) select 1)-(_dis)*cos(_nn +18), 0];
	_spw_sta setDir _nn+180;
	_group = createGroup BTC_enemy_side1; 
	_sentinel = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
	_sold = _group createUnit [_sentinel, getPos _spw_sta, [], 0, "none"];
	_sold moveinGunner _spw_sta; _sold assignAsGunner _spw_sta;
	_bagfence = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"]; _bagfence setDir _nn; _bagfence SetVectorUp [0,0,0.01];
	_movBunk = _bagfence setPos [((_pos) select 0)-(_dis +2)*sin(_nn +18), ((_pos) select 1)-(_dis +2)*cos(_nn +18), 0];
	_bagfence = createVehicle ["Land_BagFence_Long_F", _pos, [], 0, "CAN_COLLIDE"]; _bagfence setDir _nn+90; _bagfence SetVectorUp [0,0,0.01];
	_movBunk = _bagfence setPos [((_pos) select 0)-(_dis +1.3)*sin(_nn +23), ((_pos) select 1)-(_dis +1.3)*cos(_nn +23), 0];
		
	//CAMO NET
	_object = createVehicle [BTC_enemy_camonet_open, getPos _box, [], 0, "CAN_COLLIDE"]; _object setDir _nn; _object SetVectorUp [0,0,0.01];
	_movBox = _object setPos [((position _object) select 0), ((position _object) select 1), 0.6];
	_nn = _nn + 120; 
};

_nn = 240;
for "_i" from 0 to 1 do
{//STAT VEHICLES
_dis = 20;
_rndVehicle = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
_object = createVehicle [_rndVehicle, _pos, [], 30, "CAN_COLLIDE"]; _object setVehicleLock "LOCKED"; 
_object setPos [((_pos) select 0)-(_dis)*sin(_nn), ((_pos) select 1)-(_dis)*cos(_nn), 0]; _object setDir _nn+180;
_nn = _nn + 120;
};

for "_i" from 0 to 1 do
{// Mortars
	_static = BTC_enemy_static select 4;
	_spw_sta = createVehicle [_static, _pos, [], 2, "CAN_COLLIDE"]; _spw_sta setDir _nn;
	_group = createGroup BTC_enemy_side1;
	_sentinel = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
	_sold = _group createUnit [_sentinel, getPos _spw_sta, [], 0, "none"];
	_sold assignAsGunner _spw_sta; _sold moveinGunner _spw_sta;
	_null=["Sh_82mm_AMOS",[],3,200,_sold,3,20] execVM "scripts\BTC_arty.sqf";
};
_Strxx = 0;
for "_i" from 0 to 20 do 
{
	_rnd_obj = 
	[
	"Land_Pallets_F","Land_Garbage_line_F","Land_Garbage_square3_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_JunkPile_F",
	"Land_Wreck_Truck_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Car_F","Land_Wreck_Car2_F","Land_Wreck_Car3_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Skodovka_F"
	] call BIS_fnc_selectRandom; 
	_objPos = [_pos, 40, 40 + (_Strxx *2), 3, 1, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
	if (_objPos distance _pos < 150) then {_object = createVehicle [_rnd_obj, _objPos, [], 0, "NONE"]; _object setDir (random 359);};
	_Strxx = _Strxx + 1;
}; 
//////////////////////////////// Create composition END \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

if (BTC_debug == 1) then {"debug_mrk" setMarkerPos getMarkerPos mrk_side_miss;};
if (BTC_debug == 1) then {Titletext ["CREATING ENEMIES","plain down",0];};
diag_log (format["CREATING ENEMIES M2"]);
	
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
/////////////////////////////////////////////////////////
// Crea nemici fanteria
for "_i" from 0 to (3 + (BTC_difficulty)) do
{_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};
/////////////////////////////////////////////////////////

if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M2","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER M2"]);
sleep 2;
numVehicle2 = 0;
_count_unit = [] spawn 
{
	_Vehiclepos 	= GetmarkerPos mrk_side_miss;
	_Vehicleradius 	= 40;
	_numVehicle2 = 0;
	_Vehicle = [];
		while {!(BTC_end_mission_2)} do
		{	//"LandVehicle"
			_Vehicle = nearestObjects [_Vehiclepos, ["LandVehicle","StaticWeapon","ReammoBox_F"], _Vehicleradius];
		   if (count _Vehicle > 0) then
		   {
			  _numVehicle2 = {Alive _x} count _Vehicle; 
			  numVehicle2 = _numVehicle2;
			   if (BTC_debug == 1) then {player sidechat format ["Vehicle in camp to destroy: %1",_numVehicle2];};
		   };
		 sleep 10;
		};
};

waitUntil {sleep 0.1; (numVehicle2 > 0)};



///// MISSION CREATION COMPLETE /////
_mrk_dim2 = (600 + (BTC_difficulty * 20)); //620,660,800,1000
//*************
// Get a random direction 	// Get a random distance
_pos = [getMarkerpos mrk_side_miss, 300, _mrk_dim2 -100, 5, 0, 50, 0] call BIS_fnc_findSafePos;
//*************
_spawn = [_mrk_dim2,_mrk_dim2,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_2",_pos] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk02",_pos] spawn BTC_create_marker; //Marker per le tasks

waitUntil {(getMarkerColor "mrk02" != "")};
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 2 COMPLETE","plain down",0];};
diag_log (format["SPAWN ENEMIES MISSION 2 COMPLETE"]);

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_2 = true; publicVariable "BTC_start_mission_2";
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side];
_clr = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)",
"{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo numero di nemici rimanenti
BTCM_side_miss_end2 = false; publicVariableServer "BTCM_side_miss_end2";
sleep 3; 
_check = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_2)&&(count thislist <=1)&&(numVehicle2 == 0)","
BTCM_side_miss_end2 = true; publicVariableServer 'BTCM_side_miss_end2';"] spawn BTC_create_trigger_count_unit;

_null = [mrk_side_miss,_mrk_dim] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
if (BTC_stc_city == 1) then {[mrk_side_miss] execVM "scripts\patrol\patrols_STAT.sqf";};

////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////// MISSION END ////////////////////////////////////////////////////////////
_nul = [] spawn 
{ 
	waitUntil {sleep 3; (BTCM_side_miss_end2)||(skip_var)};
	if !(skip_var)
	then { //missione conclusa
	"mrk02" setMarkerSize [3,3]; "mrk02" setMarkerColor mrk_color_end; "mrk_miss_2" setMarkerColor mrk_color_end; skip_miss2 = false; publicVariable "skip_miss2";}
	else {	// missione cancellata dall'utente
	"mrk02" setMarkerSize [3,3]; "mrk02" setMarkerColor "ColorGrey"; "mrk_miss_2" setMarkerColor "ColorGrey"; skip_miss2 = true; publicVariable "skip_miss2";};
	
	"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
	side_chose_init = true; publicVariableServer "side_chose_init"; 
	BTC_end_mission_2 = true; publicVariable "BTC_end_mission_2";
	"mrk_miss_2" setMarkerSize [150,150]; 
	"mrk_miss_2" setMarkerBrush "Border"; 
	if (true) exitWith {};
};


diag_log "======================== 'SIDES PATROLS' END 'MISSION 2' by =BTC= MUTTLEY ========================";
};










