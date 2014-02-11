///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

/// Mission 6 assoult enemy port OK
//chose marker for spawning enemies OK

if (isServer) then {
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
BTCM_side_miss_end5 = false; publicVariableServer "BTCM_side_miss_end5";
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';

	 
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 6' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 6"]);

private ["_mrk_side_miss","_xx","_chose_mrk_rnd","_minDist","_maxDist","_Shorepos","_Waterpos","_Landpos"];
_mrk_side_miss = "";
// Scelta casuale citta/area città
_xx = 0;
_chose_mrk_rnd = true;
_minDist = BTC_search_min;
_maxDist = BTC_search_max + 1000;
_Shorepos = [];
_Waterpos = [];
_Landpos = [];

_mrk_side_miss = [BTC_sea_miss_array, position Player] call BIS_fnc_nearestPosition;
if (BTC_debug == 1) then {diag_log text format["Marker for mission -M6-: %1", _mrk_side_miss];};
if (isNil ("_mrk_side_miss")) exitWith {diag_log "::SIDES PATROLS:: _mrk_side_miss isNil";};
_STR_pos = getMarkerPos (_mrk_side_miss);

while {(_chose_mrk_rnd)} do
{
	_Shorepos = [_STR_pos, 0, _maxDist, 1, 0, 50*(pi / 180), 1] call BIS_fnc_findSafePos; //Search Shore
	_Waterpos = [_Shorepos, 600, 600, 5, 2, 40*(pi / 180), 0] call BIS_fnc_findSafePos; //Search water
	_Landpos = [_Shorepos, 50, 50, 2, 0, 35*(pi / 180), 0] call BIS_fnc_findSafePos; //Search Land
	if (BTC_debug == 1) then {"debug_mrk" setMarkerPos _Shorepos;};
	if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos _Waterpos;};
	if (BTC_debug == 1) then {"debug_mrk_2" setMarkerPos _Landpos;};
	if 
	(
		(({(isPlayer _x) && ((_x distance _Shorepos) > _minDist -500)} count allUnits) > 0)&&
		(({(isPlayer _x) && ((_x distance _Shorepos) < _maxDist +500)} count allUnits) > 0)&& 
		((_Shorepos distance (markerPos "base_port")) > 2000) && 
		((_Waterpos distance _Shorepos) < 700)	&& 
		((_Landpos distance _Shorepos) < 60)
	)
	then {_chose_mrk_rnd = false;}
	else {_chose_mrk_rnd = true; _xx = _xx + 1;};
	if (_xx > 50) then {_maxDist = _maxDist + 100; _xx = 0; diag_log (format["::SIDES PATROLS:: M6 MAX DISTANCE INCREASE"]);};
	if (BTC_debug == 1) then
	{
		diag_log text format["::SIDES PATROLS:: -M6- ATTEMPT SHORE POSITION: %1", _xx];
		player sideChat format["::SIDES PATROLS:: M6 SHORE FOUND"];
		diag_log (format["::SIDES PATROLS:: M6 _Shorepos FOUND at: %1", _Shorepos]);
		diag_log (format["::SIDES PATROLS:: M6 _Waterpos FOUND at: %1", _Waterpos]);
		diag_log (format["::SIDES PATROLS:: M6 _Landpos FOUND at: %1", _Landpos]);
	};
	sleep 0.001;
};

// // // // // // // // // // // // // // // // // // // // // // // // // // // //


//trigger per cancellare nemici in caso skip missione debug
kill_var_M6 = false;
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_n1 = [_Shorepos,400,_BTC_enemy_side,"PRESENT","kill_var_M6 OR kill_var OR skip_var","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; 
kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;

if (BTC_debug == 1) then {Titletext ["MARKER SELECTION DONE","plain down",0];};
diag_log (format["MARKER SELECTION DONE MISSION 6"]);
"areaV" setMarkerPos _Waterpos;
"areaV" setMarkerSize [222, 222];
_spawn2 = ["areaV","areaV",(BTC_enemy_boats select 0)] spawn BTC_spawn_veh;

//////////////////////////// SET MARKERS ////////////////////////////////////
_mrk_dim = 100;
"areaI" setMarkerPos _Shorepos;
"areaI" setMarkerSize [150, 150];
"areaS" setMarkerPos _Shorepos;
"areaS" setMarkerSize [150, 150];
_mrk_side_miss = "areaI";

//////////////////////////// COMPOSITONS & STATIC ////////////////////////////////////
//////////////////////////////////// WALL ////////////////////////////////////////////
//Create perimeter
_degr = 3; _nn = 0; _dist = 60; _numb = 360 / _degr;
for "_i" from 0 to (_numb -1) do
{
	_pos = Markerpos _mrk_side_miss;
	_isWater = surfaceIsWater [((_pos) select 0)-(_dist)*sin(_nn), ((_pos) select 1)-(_dist)*cos(_nn), 0];
	if !(_isWater) then 
	{
		if ((_nn == 30)||(_nn == 60)||(_nn == 90)||(_nn == 120)||(_nn == 150)||(_nn == 180)||(_nn == 210)||(_nn == 240)||(_nn == 270)||(_nn == 300)||(_nn == 330))
		then {_barrier = createVehicle ["Land_BagBunker_Small_F", [((_pos) select 0)-(_dist +5)*sin(_nn), ((_pos) select 1)-(_dist +5)*cos(_nn), 0], [], 0, "CAN_COLLIDE"]; _barrier setDir _nn; _barrier SetVectorUp [0,0,0.01];} 
		else {_barrier = createVehicle ["Land_Ancient_Wall_4m_F", [((_pos) select 0)-(_dist)*sin(_nn), ((_pos) select 1)-(_dist)*cos(_nn), 0], [], 0, "CAN_COLLIDE"]; _barrier setDir _nn; _barrier SetVectorUp [0,0,0.01];};
		//"Land_HBarrier_5_F" "Land_BarGate_F" "Land_Ancient_Wall_4m_F" "Land_Mil_WiredFence_F" "Land_Mil_WallBig_Gate_F" //"Land_Net_Fence_Gate_F" "Land_New_WiredFence_5m_F" 
	};
	_nn = _nn + _degr;
};

	// Bunkers with soldiers, *** creando bunker con statiche per i porti ****
	_nn = 0;
	for "_i" from 0 to (BTC_val_diff)-1 do
	{
		_pos = getMarkerPos _mrk_side_miss;
		//BUNKERS
		_Bunkpos = [_pos, 30, 100, 5, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
		_xx = 0;
		while {(_Bunkpos distance _pos) > 100}
		do {_Bunkpos = [_pos, 0, 100, 5, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos; _xx = _xx + 1; if (_xx > 10)exitWith{_Bunkpos = _pos;}};
		//_bunker = createVehicle ["Land_BagBunker_Small_F", _Bunkpos, [], 0, "NONE"]; _bunker setDir _nn; 
		_nnB = 0;
		for "_i" from 0 to 3 do
		{
			_bagfence = createVehicle ["Land_BagFence_Long_F", [((_Bunkpos) select 0)+(2)*sin(_nnB), ((_Bunkpos) select 1)+(2)*cos(_nnB), 0], [], 0, "CAN_COLLIDE"]; 
			_bagfence setDir _nnB; _nnB = _nnB + 90; sleep 0.1;
		};
		//Ammo
		_rnd_box = BTC_enemy_weap_box select (round (random ((count BTC_enemy_weap_box) - 2)));
		_object = createVehicle [_rnd_box, _Bunkpos, [], 4, "CAN_COLLIDE"]; _object setDir _nn;
		//STATIC
		_type = BTC_enemy_static select 0;
		_type_str = format ["%1",BTC_enemy_side1];
		_static = [_Bunkpos,_nn,_type,BTC_enemy_side1] call bis_fnc_spawnVehicle;
		(_static select 2) setFormDir _nn +180;
		//CAMO NET
		_object = createVehicle [BTC_enemy_camonet_open, _Bunkpos, [], 0, "CAN_COLLIDE"]; _object setDir _nn; _object SetVectorUp [0,0,0.01];
		_object AllowDamage false;
		_nn = _nn + 180; 
	};	
	
	/// Objectives Ships
	_rnd_ship1 = BTC_enemy_boats select 4; 
	_rnd_ship2 = BTC_enemy_boats select 0;
	_rnd_ship3 = BTC_enemy_boats select 0;
	_rnd_ship4 = BTC_enemy_boats select (round (random ((count BTC_enemy_boats) - 1))); 
	_rnd_ship5 = BTC_enemy_boats select (round (random ((count BTC_enemy_boats) - 1))); 
	_rnd_ship6 = BTC_enemy_boats select (round (random ((count BTC_enemy_boats) - 1))); 
	{
		_nn = 10;
		_rad = 0;
		_isWater = false;
		//_Waterpos = [_Shorepos, _nn, _nn +(5), 2, 2, 40*(pi / 180), 0] call BIS_fnc_findSafePos; 
		_Waterpos = [(_Shorepos select 0)+(_nn - (random (_nn *2))),(_Shorepos select 1)+(_nn - (random (_nn *2))), 0];
		_isWater = surfaceIsWater _Waterpos;
		//Search water
		while {!(_isWater)&&(_Waterpos distance _Shorepos)> 50}	
		do 
		{
			_Waterpos = [(_Shorepos select 0)+(_nn - (random (_nn *2))),(_Shorepos select 1)+(_nn - (random (_nn *2))), 0];
			_nn = _nn + 1; if (_nn > 100)exitWith{_Waterpos = _Shorepos; _rad = 30;};
		};
		_object = createVehicle [_x, _Waterpos, [], _rad, "NONE"];
		if (BTC_track) then {_spawn = [_object] execVM "scripts\BTC_track_unit.sqf";};
	} 
	forEach [_rnd_ship1,_rnd_ship2,_rnd_ship3,_rnd_ship4,_rnd_ship5,_rnd_ship6];

	//{[_mrk_side_miss,500,_x,5,5,BTC_enemy_side1] spawn BTC_LandMine;} foreach ["ATMine","SLAMDirectionalMine","APERSMine","APERSBoundingMine","APERSTripMine"];
	_dist_m = [200,250,300,350,400] call BIS_fnc_selectRandom;
	{[_mrk_side_miss,_dist_m,_x,3,10,BTC_enemy_side1] spawn BTC_LandMine;} foreach ["APERSTripMine","ATMine","SLAMDirectionalMine"];
	_null = [_mrk_side_miss,300,3,-1.50,10,BTC_enemy_side1] spawn BTC_underwaterMine;
	
	//Decorations///////////
	for "_i" from 0 to 19 do 
	{
		_rnd_obj = 
		[
		"Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F",
		"Land_Pallets_F","Land_Garbage_line_F","Land_Garbage_square3_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_JunkPile_F",
		"Land_Wreck_Truck_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Car_F","Land_Wreck_Car2_F","Land_Wreck_Car3_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Skodovka_F",
		"Land_Wreck_Truck_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Car_F","Land_Wreck_Car2_F","Land_Wreck_Car3_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Skodovka_F"
		] call BIS_fnc_selectRandom; 
		_objPos = [markerPos _mrk_side_miss, 50, 150, 5, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
		if (_objPos distance (markerPos _mrk_side_miss) < 150) then {_object = createVehicle [_rnd_obj, _objPos, [], 0, "NONE"]; _object setDir (random 359);};
	}; 
	
	//////TENTS CAMP //////
	_pos = markerPos _mrk_side_miss; _deg = 0;	_dis = 4;	_barrier = "Land_BagFence_Long_F";
	_Bunkpos = [_pos, 50, 150, 5, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
	_object = createVehicle ["Land_Campfire_F", _Bunkpos, [], 0, "CAN_COLLIDE"]; _object setDir _deg; _object setVectorUp [0,0,0.01]; _xx = 0;
	while {(_Bunkpos distance _pos) > 50}
	do {_Bunkpos = [_pos, 0, 50, 5, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos; _xx = _xx + 1; if (_xx > 10)exitWith{_Bunkpos = _pos;}};
	for "_i" from 0 to (5) do
	{
		//BARRIER
		_object = createVehicle [_barrier, _Bunkpos, [], 0, "CAN_COLLIDE"]; _object setDir _deg; _object setVectorUp [0,0,0.01];
		_myPos = _object setPos [((position _object) select 0)-(_dis+2)*sin(_deg), ((position _object) select 1)-(_dis+2)*cos(_deg), 0];
		//TENTS
		_object = createVehicle [BTC_enemy_tent, _Bunkpos, [], 0, "CAN_COLLIDE"]; 
		_myPos = _object setPos [((position _object) select 0)-(_dis)*sin(_deg), ((position _object) select 1)-(_dis)*cos(_deg), 0];
		_deg = _deg + 60;_object setDir _deg;
	};
	
	//Enemy HQ
	_BunkposHQ= [_pos, 50, 100, 10, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
	_BunkHQ = createVehicle ["Land_Cargo_HQ_V2_F", _BunkposHQ, [], 0, "CAN_COLLIDE"]; _object setDir _deg;
	_BunkposTower = [_pos, 50, 100, 10, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
	_BunkTower = createVehicle ["Land_Cargo_Patrol_V2_F", _BunkposTower, [], 0, "CAN_COLLIDE"]; _object setDir _deg;
	//Create Tower sentry
	_Towers = nearestObjects [_pos, ["Cargo_HQ_base_F","Cargo_Patrol_base_F","Cargo_Tower_base_F"], 100];
	//if (BTC_debug == 1) then {diag_log text (format["PATROL_FOB.SQF, Towers: %1", _Towers]);};	
	{
		//Sentry
		_pos_H = 0;
		while { format ["%1", _x buildingPos _pos_H] != "[0,0,0]" } do {_pos_H = _pos_H + 1};
		_pos_H = _pos_H - 1;
		if (_pos_H > 0)
		then 
		{
			_group = createGroup BTC_enemy_side1;
			_sentry = _group createUnit [BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1))), _pos, [], 0, "this setFormDir (random 359)"];
			_sentry2 = _group createUnit [BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1))), _pos, [], 0, "this setFormDir (random 359)"];
			if (BTC_track) then { {[_x] execVM "scripts\BTC_track_unit.sqf";}forEach [_sentry, _sentry2];};
			_sentry setpos (_x buildingpos (_pos_H));
			_sentry2 setpos (_x buildingpos (_pos_H - 1));
		};
	} forEach _Towers;
	
	for "_i" from 0 to (2) do
	{
		_Wreckspos = [_Shorepos, 20, 30, 3, 0, 50*(pi / 180), 1] call BIS_fnc_findSafePos; //Search Shore
		_Wreck = createVehicle ["Land_UWreck_FishingBoat_F", _Wreckspos, [], 0, "CAN_COLLIDE"]; _Wreck setFormDir (random 359);
	};
	
	//Infantry 
	for "_i" from 0 to (round (((BTC_difficulty) /2) + 5)) do {_spawn = ["areaS",50,150] spawn BTC_spawn_diver;};
	for "_i" from 0 to 4 do { _BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};

	
	////////////////////////////////////////////////////////////////	
	_count_unit = [] spawn 
	{
		_Vehicleradius 	= 50;
		_numVehicle6 = 0;
		_Vehicle = [];
		while {!(BTC_end_mission_6)} do
		{	//"Ships"
			_Vehicle = nearestObjects [markerPos "areaS", ["Ship","Ship_F"], _Vehicleradius];
		   if (count _Vehicle > 0) then
		   {
			  _numVehicle6 = {Alive _x} count _Vehicle;
			  numVehicle6 = _numVehicle6;
			   if (BTC_debug == 1) then {player SideChat format ["Ships to destroy: %1",_numVehicle6];};
		   };
		 sleep 10;
		};
	};


///// MISSION CREATION COMPLETE /////
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_6",_mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk06",_mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk06" != "")};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_6 = true; publicVariable "BTC_start_mission_6";
if (BTC_debug == 1) then {hint "SPAWN ENEMIES MISSION 6 COMPLETE";};
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1", BTC_enemy_side1];
_clr = [_mrk_side_miss,_mrk_dim*3,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo fine missione
BTCM_side_miss_end6 = false; publicVariableServer "BTCM_side_miss_end6";
_check = [_mrk_side_miss,_mrk_dim,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_6) && (numVehicle6 == 0)",
"BTCM_side_miss_end6 = true; publicVariableServer 'BTCM_side_miss_end6';"] spawn BTC_create_trigger_count_unit;


///// MISSION END /////
_nul = [] spawn 
{
	waitUntil {sleep 3; (BTCM_side_miss_end6)||(skip_var)};
	if !(skip_var)
	then { //missione conclusa
	"mrk06" setMarkerSize [3,3]; "mrk06" setMarkerColor mrk_color_end; "mrk_miss_6" setMarkerColor mrk_color_end; skip_miss6 = false; publicVariable "skip_miss6";}
	else {	// missione cancellata dall'utente
	"mrk06" setMarkerSize [3,3]; "mrk06" setMarkerColor "ColorGrey"; "mrk_miss_6" setMarkerColor "ColorGrey"; skip_miss6 = true; publicVariable "skip_miss6";};
	
	_nul = [] spawn {
	waitUntil{(({((side _x == BTC_friendly_side1) OR (side _x == BTC_friendly_side2)) && ((_x distance (getMarkerPos "mrk_miss_6")) < 1000)} count allUnits) < 1)};
	//waitUntil{((getPos Player) distance (getMarkerPos "mrk_miss_6") > 1500)};
	kill_var_M6 = true; publicVariableServer "kill_var_M6"; };
	
	BTC_end_mission_6 = true; publicVariable "BTC_end_mission_6";
	side_chose_init = true; publicVariableServer "side_chose_init";
	"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map"; "areaS" setMarkerPos getMarkerPos "out_map";
};

diag_log "======================== 'SIDES PATROLS' END 'MISSION 6' by =BTC= MUTTLEY ========================";
};












