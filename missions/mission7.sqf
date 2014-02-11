///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

/// Mission 7 pilot rescue
//chose marker for spawning enemies OK
		
if (isServer) then {
pilot_rescued = false; publicVariable 'pilot_rescued';
BTCM_side_miss_end7 = false; publicVariableServer "BTCM_side_miss_end7";
skip_miss7 = false; publicVariable "skip_miss7";
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
pilot_to_rescue = objNull;
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M7","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 7' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 7"]);

// // // // // // // Marker selection // // // // // // //
_Old_BTC_place_miss = BTC_place_miss;
BTC_place_miss = 0; // Make mission possible anyware
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M7"]);
_position = call BTC_fnc_choselocation;
"areaI" setMarkerPos BTC_position;
 mrk_side_miss = "areaI"; 
 BTC_place_miss =_Old_BTC_place_miss; publicVariableServer "BTC_place_miss";
// // // // // // // // // // // // // // // // // // // //

_dis = (random 50); _dis2 = (random 50); _dir = random 359;
GOOD_POS = [((getMarkerPos mrk_side_miss) select 0)-(_dis)*sin(_dir), ((getMarkerPos mrk_side_miss) select 1)-(_dis2)*cos(_dir), 0];
//GOOD_POS = getMarkerPos mrk_side_miss;

if (BTC_debug == 1) then {player sidechat "MARKER SELECTION M7 DONE"; diag_log (format["MARKER SELECTION M7 DONE"]);};
_mrk_dim = (30 + (BTC_difficulty * 10));
"areaI" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];

//Check if building near position
_house = nearestbuilding GOOD_POS;
if (_house distance GOOD_POS > 100) then
{
	//////////////////////////////////////// Find a good position \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	_condition = false;
	_attempt = 0;
	while {!(_condition)} do 
	{
		FinPos = [];
		FinPos = [GOOD_POS, 0, 100, 10, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
		if (BTC_debug == 1) then {"debug_mrk" setMarkerPos FinPos;};
		_house = nearestbuilding FinPos;
		if (_house distance FinPos < 100) exitWith {GOOD_POS = FinPos;};

		//Avoid roads
		_roads = FinPos nearRoads 40;
		//Avoid coast
		_nearcoast = false; _Array = [];
		for [{_i = 0},{_i < 100},{_i = _i + 1}] do 
		{
			_position = [GOOD_POS, 0, 50, 1, 1, 20*(pi / 180), 0] call BIS_fnc_findSafePos; 
			_Array = _Array + [_position];
		};
		_nearcoast = {surfaceIsWater _x} foreach _Array;
		
		if (
			(_nearcoast) || ((count _roads) > 0) ||
			(({((side _x == BTC_friendly_side1) OR (side _x == BTC_friendly_side2)) && ((_x distance FinPos) < 1000)} count allUnits) > 0) ||
			((FinPos distance (getmarkerpos mrk_side_miss) > 200) || (FinPos distance (getmarkerpos "base") < 1500))
			)  
		then {_condition = false; _attempt = _attempt + 1;} 
		else {_condition = true;};
		if ((_condition)) exitWith {GOOD_POS = FinPos;};
		if ((_attempt == 50)) exitWith {GOOD_POS = getmarkerpos mrk_side_miss;};
		sleep 0.1;
	};

if (BTC_debug == 1) then {player sidechat "SPAWN AREA SELECTION DONE M7"; diag_log (format["SPAWN AREA SELECTION DONE M7"]);	};
	
	_house = nearestbuilding FinPos;
	if (_house distance FinPos > 100) then
	{
		//////////////////////////////// Create composition \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		_rnd = round (random 2)+1;
		if (_rnd==1) then {_object = createVehicle ["Land_Slum_House01_F", GOOD_POS, [], 0, ""]; _object setDir 0;}; 
		if (_rnd==2) then {_object = createVehicle ["Land_Slum_House02_F", GOOD_POS, [], 0, "CAN_COLLIDE"]; _object setDir 0;}; 
		if (_rnd==3) then {_object = createVehicle ["Land_Slum_House03_F", GOOD_POS, [], 0, "CAN_COLLIDE"]; _object setDir 0;};
			_nul = [] spawn 
			{
				for "_i" from 0 to 11 do 
				{
					_rnd_obj = 
					[
					"Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F",
					"Land_Pallets_F","Land_Garbage_line_F","Land_Garbage_square3_F","Land_GarbageBags_F","Land_GarbagePallet_F","Land_JunkPile_F",
					"Land_Wreck_Truck_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Car_F","Land_Wreck_Car2_F","Land_Wreck_Car3_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_Skodovka_F"
					] call BIS_fnc_selectRandom; 
					_objPos = [GOOD_POS, 8, 25, 5, 0, 20*(pi / 180), 0] call BIS_fnc_findSafePos;
					if (_objPos distance GOOD_POS < 50) then {_object = createVehicle [_rnd_obj, _objPos, [], 0, "NONE"]; _object setDir (random 359);};
				}; 
			};
	};
};

///// Crea Pilota /////
private["_side","_zone","_veh_name","_rnd_rad","_dis","_dir","_group","_pilot","_rnd_numb","_pos","_spw_coord"];
_veh_name 	 = "pilot_to_rescue";
_group 		 = createGroup BTC_friendly_side1;
_spw_coord	 = getMarkerPos mrk_side_miss;
_pos = [_spw_coord, 0, 30, 2, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
waitUntil {!(isNil ("_pos"))};
_pilot = _group createUnit [BTC_friendly_pilot, GOOD_POS, [], 0, "NONE"];
_pilot SetVehicleVarName _veh_name;
_pilot Call Compile Format ["%1=_This; PublicVariable ""%1""",_veh_name];
waitUntil {(vehicleVarName _pilot == _veh_name)};
_pilot setFormDir (random 359);
removeAllweapons _pilot;
_pilot playMove "AmovPercMstpSnonWnonDnon_Ease";
_pilot disableAI "MOVE";
_pilot disableAI "ANIM";
_pilot setCaptive true;
if (BTC_debug == 1) then {player sidechat "*** CREATING PILOT M7 ***"; diag_log (format["*** CREATING PILOT M7 ***"]);};
//////////////////////

_house = nearestbuilding _pilot;			// Controlla le case vicino al pilota
if ((_house distance _pilot) < 100) then 	// Se la casa è vicina 
{
	// Mette il pilota dentro
	_pos_H = 0;
	while { format ["%1", _house buildingPos _pos_H] != "[0,0,0]" } do {_pos_H = _pos_H + 1};
	_pos_H = _pos_H - 1;
	if (_pos_H > 1) 
	then {_pilot setpos (_house buildingpos (round (_pos_H /2)));}
	else {_pilot setpos (_house buildingpos _pos_H);};


	////////////////////////////////////////// Enemies guards
	_guardsN = 0; _num_qty = 3; __attempt = 0;
	while {_guardsN < _num_qty} do
	{		
		_group = createGroup BTC_enemy_side1;
		_pos = getPos pilot_to_rescue;
		_GOOD_POS = [_pos, 3, 10, 1, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
		_guard = _group createUnit [(BTC_enemy_units select 0), _GOOD_POS, [], 10, "NONE"]; //// <<<<<<<<<<<<---------------
		[_guard] joinSilent grpNull;
		_guardsN = _guardsN +1;
		_house = nearestbuilding pilot_to_rescue;
		_GOOD_POS_H = 0;
		while { format ["%1", _house buildingPos _GOOD_POS_H] != "[0,0,0]" } do {_GOOD_POS_H = _GOOD_POS_H + 1};
		_GOOD_POS_H = _GOOD_POS_H - 1;
		if (_GOOD_POS_H > 3) 
		then {_guard setpos (_house buildingpos _guardsN); _guard lookAt pilot_to_rescue;} else {_guard lookAt pilot_to_rescue;};
		_grd = [_guard,"SAFE",20] execVM "scripts\patrol\patrols_House.sqf";
		__attempt = __attempt + 1;
		if (__attempt == 4) exitWith {};
	};
};

if ((_house distance _pilot) > 100) then
{
	GOOD_POS = getPos pilot_to_rescue; 
	for "_i" from 0 to 2 do 
		{
			_group = createGroup BTC_enemy_side1;
			_guard = _group createUnit [(BTC_enemy_units select 0), GOOD_POS, [], 6, "NONE"]; 
			_guard setFormDir (random 359);
		};
};

///////////////////////////////////////////////////////////
if (BTC_debug == 1) then {player sidechat "PILOT CREATION M7 DONE";diag_log (format["PILOT CREATION M7 DONE"]);};
///////////////////////////////////////////////////////////

///// heli_wreck /////
private ["_dir","_spw_coord","_pos","_dis"];
_spw_coord = getPos pilot_to_rescue; 
_area = (30 + (BTC_difficulty * 10));
_pos = [_spw_coord, _area *0.9, _area, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
while {(_pos distance (getPos pilot_to_rescue) > _area)||(isNil ("_pos"))}
do {_pos = [_spw_coord, _area *0.9, _area, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos; sleep 0.1;};
_heli = createVehicle [BTC_enemy_heli_wreck, _pos, [], 100, "CAN_COLLIDE"]; _heli setFormDir (random 359);
if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos getPos _heli;};

/////////////////////

////// Crea nemici /////////////////////////
"areaI" setMarkerPos getPos pilot_to_rescue; 
_xx = 0;
for "_i" from 0 to (3 + (BTC_difficulty)) do
{
if (_xx == 0) then {_BTC_grp = ["areaI",20] spawn BTC_spawn_inf_group_patrol;};
if (_xx == 1) then {_BTC_grp = ["areaI",40] spawn BTC_spawn_inf_group_patrol;};
if (_xx > 1) then {_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};
_xx = _xx + 1;
};
// Crea Veicoli nemici
"areaV" setMarkerPos getPos pilot_to_rescue; 
"areaV" setMarkerSize [_mrk_dim*2, _mrk_dim*2];
if (BTC_vehicles == 1)
then {_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; 
if (BTC_difficulty > 3) then {_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; }; };
//////////////////////////////////////////////////////////

if (BTC_debug == 1) then {player sidechat "CREATE CONTROL TRIGGER";
diag_log (format["CREATE CONTROL TRIGGER M7"]);};

//*************
// Get a random direction && random distance for final marker
_pos = [getPos pilot_to_rescue, 20, _mrk_dim, 0, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
if (_pos distance (getPos pilot_to_rescue) > _mrk_dim) then {_pos = getPos pilot_to_rescue;};
//*************

///// MISSION CREATION COMPLETE /////
_nul2 = [] spawn {if (BTC_debug == 1) then {while {!(BTCM_side_miss_end7)&&!(skip_var)} do {sleep 5; "debug_mrk" setMarkerPos getPos pilot_to_rescue;};};};
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_7",_pos] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk07",_pos] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk07" != "")};
if !(isNull _heli) then {{_x setMarkerPos position _heli}foreach ["mrk_miss_7","mrk07"];};
//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_7 = true; publicVariable "BTC_start_mission_7";
if (BTC_debug == 1) then {player sidechat "SPAWN ENEMIES MISSION 7 COMPLETE"; diag_log (format["SPAWN ENEMIES MISSION 7 COMPLETE"]);};
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_clr = [getPos pilot_to_rescue,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;

BTCM_side_miss_end7 = false; publicVariableServer "BTCM_side_miss_end7";
// Pilota salvato
_TRG1 = ["jail_mrk",10,"ANY","PRESENT","!(BTC_end_mission_7) && (pilot_to_rescue in thislist)",
"BTCM_side_miss_end7 = true; publicVariable 'BTCM_side_miss_end7'; pilot_rescued = true; publicVariable 'pilot_rescued';"] spawn BTC_create_trigger_count_unit;
// Pilota ucciso
_TRG2 = ["jail_mrk",0,"ANY","PRESENT","!(BTC_end_mission_7) && !(alive pilot_to_rescue)",
"BTCM_side_miss_end7 = true; publicVariable 'BTCM_side_miss_end7'; pilot_rescued = false; publicVariable 'pilot_rescued';"] spawn BTC_create_trigger_count_unit;

_null = [mrk_side_miss,_mrk_dim] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
if (BTC_stc_city == 1) then {[mrk_side_miss] execVM "scripts\patrol\patrols_STAT.sqf";};

///// MISSION END /////
_nul = [] spawn 
{
	waitUntil {sleep 3; (BTCM_side_miss_end7)||(skip_var)};
	
	if ((pilot_rescued) && !(skip_var)) //missione conclusa
	then { "mrk07" setMarkerSize [3,3]; "mrk07" setMarkerColor mrk_color_end; "mrk_miss_7" setMarkerColor mrk_color_end; skip_miss7 = false; publicVariable "skip_miss7"; };
	
		if (!(pilot_rescued) && !(skip_var)) //missione fallita
		then { "mrk07" setMarkerSize [3,3]; "mrk07" setMarkerColor "ColorRed"; "mrk_miss_7" setMarkerColor "ColorRed"; skip_miss7 = false; publicVariable "skip_miss7"; }; 
	
			if (!(pilot_rescued) && (skip_var)) // missione cancellata dall'utente
			then { "mrk07" setMarkerSize [3,3]; "mrk07" setMarkerColor "ColorGrey"; "mrk_miss_7" setMarkerColor "ColorGrey"; skip_miss7 = true; publicVariable "skip_miss7"; };
	
	"areaS" setMarkerPos getMarkerPos "out_map"; "areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
	side_chose_init = true; publicVariableServer "side_chose_init"; 
	BTC_end_mission_7 = true; publicVariable "BTC_end_mission_7";
};

diag_log "======================== 'SIDES PATROLS' END 'MISSION 7' by =BTC= MUTTLEY ========================";
};



