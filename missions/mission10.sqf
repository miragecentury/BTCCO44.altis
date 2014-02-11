///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//One shot one kill
//Kill the informer

if (isServer) then {
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
BTCM_side_miss_end10 = false; publicVariableServer "BTCM_side_miss_end10";
skip_miss10 = false; publicVariable "skip_miss10";
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M10","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 10' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 10"]);

// // // // // // // Marker selection // // // // // // //
_Old_BTC_place_miss = BTC_place_miss;
BTC_place_miss = 0; // Make mission possible anyware
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M10"]);
_position = call BTC_fnc_choselocation;
"areaI" setMarkerPos BTC_position;
_mrk_side_miss = "areaI";
BTC_place_miss =_Old_BTC_place_miss; publicVariableServer "BTC_place_miss";
// // // // // // // // // // // // // // // // // // // //


if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M10 DONE","plain down",0];diag_log (format["MARKER SELECTION M10 DONE"]);};

_mrk_dim = 250 + (BTC_difficulty * 25); //250,325,500,750
"areaI" setMarkerPos getMarkerPos _mrk_side_miss; "areaI" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];
"areaV" setMarkerPos getMarkerPos _mrk_side_miss; "areaV" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];

////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////// STATICS ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
_nn = 0;
_qq = 0;
_nn2 = random 359;
_xx = 0;
_yy = 0;
if (BTC_difficulty > 6) then {_qq = 1;}else{_qq = 0;};
for "_i" from 0 to _qq do
{
	for "_i" from 0 to 3 do
	{
		_pos = [[(getMarkerPos _mrk_side_miss select 0)+(_mrk_dim*0.6)*sin(_nn2),(getMarkerPos _mrk_side_miss select 1)+(_mrk_dim*0.6)*cos(_nn2), 0], 0, 50, 3, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
		if (_pos distance (getMarkerPos "areaI") < _mrk_dim) then 
		{
			_static = BTC_enemy_static select 0;
			_spw_sta = createVehicle [_static, _pos, [], 0, ""];
			_spw_sta setFormDir _nn2;
			_group = createGroup BTC_enemy_side1;
			_sentinel = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
			_sold = _group createUnit [_sentinel, getPos _spw_sta, [], 0, "none"];
			_sold moveinGunner _spw_sta; _sold assignAsGunner _spw_sta;
			_gunn = gunner _spw_sta;
			_gunn setFormDir _nn2;
		
			for "_i" from 0 to 3 do
			{
				_bagfence = createVehicle ["Land_BagFence_Long_F", [((_pos) select 0)+(2)*sin(_nn), ((_pos) select 1)+(2)*cos(_nn), 0], [], 0, "CAN_COLLIDE"]; 
				_bagfence setDir _nn;
				_nn = _nn + 90; 
				sleep 0.1;
			};
			if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
		};
		_nn2 = _nn2 + 90;
		sleep 0.1;
	};
	_nn2 = _nn2 + 45;
};
	
////////////////////////////////////////////////////////////////////////////////////////
// Crea Veicoli nemici
if (BTC_vehicles == 1)
then 
{
	"areaV" setMarkerPos getMarkerPos _mrk_side_miss; "areaV" setMarkerSize [_mrk_dim, _mrk_dim];
	_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; 
	if (BTC_difficulty > 3) then {_spawn_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; };
};
//VEICOLI FANTERIA MISSIONE
_spawn_veh = ["areaV","areaV",(BTC_enemy_veh select 0)] spawn BTC_spawn_veh;
_spawn_veh = ["areaV","areaV",(BTC_enemy_veh select 1)] spawn BTC_spawn_veh;

if (BTC_difficulty > 6) then 
{
	if (BTC_difficulty < 10) then {_rnd_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; };
	if (BTC_difficulty < 10) then {_rnd_veh = ["areaV","areaV",""] spawn BTC_spawn_veh; };
	if (BTC_difficulty >= 10) then {_rnd_Tank = BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1))); _spawn_veh = ["areaV","areaV",_rnd_Tank] spawn BTC_spawn_veh; }; 
};
		
// Crea nemici fanteria: max: 44, 48, 64, 84
for "_i" from 0 to (10 + round((BTC_difficulty)/2)) do {_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};

if (BTC_debug == 1) then {Titletext ["CREA Obiettivo missione M10","plain down",0];};
diag_log (format["CREA Obiettivo missione 10"]);

/////////////////////////////////////////////////////////
// Obiettivo missione
// CREA OBIETTIVO
private ["_side","_spawn_zones","_group","_skill","_units","_varname","_inf","_unit_type","_varnameV"];
"areaS" setMarkerPos getMarkerPos _mrk_side_miss; "areaS" setMarkerSize [_mrk_dim /3, _mrk_dim /3];
_spawn_zones = "areaS";
_side        = civilian;
_varname	 = "the_informer";
_inf = createGroup _side;
_spw_coord   = getMarkerPos _spawn_zones;
_size		 = getMarkerSize _spawn_zones;
_pos = [];
_unit_type = BTC_civ_vip select (round (random ((count BTC_civ_vip) - 1)));
_pos = [_spw_coord, _mrk_dim /4, _mrk_dim /3, 3, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
_inf = _inf createUnit [_unit_type, _pos, [], 0, "NONE"];
_skill = {_x setSkill ["aimingAccuracy", 1];} foreach units _inf;
_inf SetVehicleVarName _varname; _inf Call Compile Format ["%1=_This ; PublicVariable ""%1""",_varname];
waitUntil {(vehicleVarName leader _inf == _varname)};

// Scorta informer
_grp_inf = createGroup BTC_enemy_side1;
_grp_inf createUnit [(BTC_enemy_units select 0), getMarkerPos _spawn_zones, [], 5, "FORM"];
for "_i" from 0 to 2 do
{
	_grp_inf createUnit [(BTC_enemy_units select 0), getMarkerPos _spawn_zones, [], 5, "NONE"];
	_skill = {_x setSkill ["aimingAccuracy", BTC_AI_skill];} foreach units _grp_inf;
};
[_inf] joinsilent _grp_inf;
_patrol = [leader _grp_inf,_spawn_zones, 5, 0] execVM "scripts\BTC_UPS.sqf";

//Veicolo "escape_cars";
for "_i" from 0 to 2 do
{
	_veh_type = BTC_civ_veh select (round (random ((count BTC_civ_veh) - 1)));
	_pos = [_spw_coord,  _mrk_dim /4, _mrk_dim /3, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
	_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"]; 
	if (BTC_track) then {_spawn = [_veh] execVM "scripts\BTC_track_unit.sqf";};
};
//Veicolo "escape_ship";
_veh_type = BTC_civ_ship select (round (random ((count BTC_civ_ship) - 1)));
_pos = [_spw_coord,  _mrk_dim /4, _mrk_dim /3, 3, 2, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
if (_pos distance _spw_coord < _mrk_dim) then 
{
	_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"]; 
	_attemp = 0;
	while {(((getPosATL _veh) select 2 > 3)||((getPosATL _veh) select 2 < 1))}
	do {
	_pos = [_spw_coord,  _mrk_dim /4, _mrk_dim /3, 3, 2, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
	_attemp = _attemp + 1;
	if (_attemp > 50) exitWith {};
	};
	_veh setpos _pos;
	if (BTC_track) then {_spawn = [_veh] execVM "scripts\BTC_track_unit.sqf";};
};

if (BTC_debug == 1) then {Titletext ["CREATE Trigger blufor scoperti M10","plain down",0];};
diag_log (format["CREATE Trigger blufor scoperti M10"]);

_BTC_friendly_side1 = format ["%1",BTC_friendly_side1];
_BTC_enemy_side1 	= format ["%1",BTC_enemy_side1];
_string				= " D";
_side_discovered	= format ["%1%2",BTC_enemy_side1,_string];

//if (BTC_debug == 1) then {player sidechat format ["SIDE to DISCOVER: %1",_side_discovered];};
// Trigger blufor scoperti
_n2 = [_spawn_zones,_mrk_dim,_BTC_friendly_side1,_side_discovered,"this", 
"player sideChat 'The informer its escaping'; diag_log 'The informer its escaping'; [the_informer] execVM 'missions\escape.sqf'"] spawn BTC_create_trigger_count_unit;
//the_informer addEventHandler ["FiredNear", {[_this select 0] execVM "missions\escape.sqf";}];
{_x addEventHandler ["FiredNear", {[_this select 0] execVM "missions\escape.sqf";}];} forEach units _grp_inf;

_nul2 = [] spawn {if (BTC_debug == 1) then {while {!(BTCM_side_miss_end10)} do {sleep 1; "debug_mrk" setMarkerPos getPos the_informer;};};};

////////////////////////////////////////////////////////
if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M10","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER M10"]);

///// MISSION CREATION COMPLETE /////
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_10",_mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk10",_mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk10" != "")};

_Vehiclepos 	= GetmarkerPos _mrk_side_miss;
_Vehicleradius 	= _mrk_dim *2;
_numVehicle3 = 0;
_Vehicle = [];
_Vehicle = nearestObjects [_Vehiclepos, ["Man"], _Vehicleradius];
if (count _Vehicle > 0) then
{
  _numVehicle = {Alive _x} count _Vehicle; 
   if (BTC_debug == 1) then {player sidechat format ["Units quantity: %1",_numVehicle];};
   diag_log format ["'SIDES PATROLS' units enemy quantity M10: %1",_numVehicle]
};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_10 = true; publicVariable "BTC_start_mission_10";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 10 COMPLETE","plain down",0];}; diag_log (format["SPAWN ENEMIES MISSION 10 COMPLETE"]);
//trigger per cancellare nemici in caso skip missione debug
kill_var_M10 = false;
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_n1 = [_mrk_side_miss,800,_BTC_enemy_side,"PRESENT","kill_var_M10 OR kill_var OR skip_var","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo numero di nemici rimanenti
BTCM_side_miss_end10 = false; publicVariableServer "BTCM_side_miss_end10";
dest_obj SetPos GetMarkerPos _mrk_side_miss;
//dest_end SetPos GetMarkerPos "escape_M10";
waitUntil {sleep 1; (alive the_informer) };
_n5 = [_mrk_side_miss,0,"LOGIC","PRESENT","(!Alive the_informer)&&!(BTCM_side_miss_end10)",
"BTCM_side_miss_end10 = true; publicVariableServer 'BTCM_side_miss_end10';"] spawn BTC_create_trigger_count_unit;

_n6 = [_mrk_side_miss,0,"LOGIC","PRESENT","((the_informer distance dest_obj) > 1500)&&!(BTCM_side_miss_end10)",
"BTCM_side_miss_end10 = true; publicVariableServer 'BTCM_side_miss_end10';"] spawn BTC_create_trigger_count_unit;

_n7 = [_mrk_side_miss,0,"LOGIC","PRESENT","((the_informer distance (GetMarkerPos 'escape_M10')) < 100)&&!(BTCM_side_miss_end10)",
"BTCM_side_miss_end10 = true; publicVariableServer 'BTCM_side_miss_end10';"] spawn BTC_create_trigger_count_unit;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

///// MISSION END /////
_nul = [] spawn 
{ 
	waitUntil {sleep 3; (BTCM_side_miss_end10)};

	if (!(Alive the_informer) && !(skip_var)) //missione conclusa
	then 
	{	
		"mrk10" setMarkerSize [3,3]; "mrk10" setMarkerColor mrk_color_end; "mrk_miss_10" setMarkerColor mrk_color_end;  skip_miss10 = false; publicVariable "skip_miss10"; 
		_nul = [] spawn {waitUntil{sleep 3; (( { ((side _x == BTC_friendly_side1) OR (side _x == BTC_friendly_side2)) && ((_x distance (getMarkerPos "mrk_miss_10")) < 1500)} count allUnits) < 1)};		kill_var_M10 = true; publicVariableServer "kill_var_M10"; }; 
	};
 
		if ((Alive the_informer) && !(skip_var)) //missione fallita
		then 
		{	
			"mrk10" setMarkerSize [3,3]; "mrk10" setMarkerColor "ColorRed"; "mrk_miss_10" setMarkerColor "ColorRed"; skip_miss10 = false; publicVariable "skip_miss10";
			_nul = [] spawn {waitUntil{sleep 3; (( { ((side _x == BTC_friendly_side1) OR (isPlayer _x)) && ((_x distance (getMarkerPos "mrk_miss_10")) < 1500)} count allUnits) < 1)};			kill_var_M10 = true; publicVariableServer "kill_var_M10"; 
			waitUntil{sleep 3; (( { (isPlayer _x) && ((_x distance (getPos the_informer)) < 1000)} count allUnits) < 1)}; _veh_infame = vehicle the_informer; deleteVehicle _veh_infame; deleteVehicle the_informer; };
		}; 

			if (skip_var) //missione cancellata dall'utente
			then 
			{	
			"mrk10" setMarkerSize [3,3]; "mrk10" setMarkerColor "ColorGrey"; "mrk_miss_10" setMarkerColor "ColorGrey"; skip_miss10 = true; publicVariable "skip_miss10"; kill_var_M10 = true; publicVariableServer "kill_var_M10"; 
			}; 


"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
side_chose_init = true; publicVariableServer "side_chose_init"; 
BTC_end_mission_10 = true; publicVariable "BTC_end_mission_10";
_nul = [] spawn {sleep 10; deleteVehicle the_informer;};

};
diag_log "======================== 'SIDES PATROLS' END 'MISSION 10' by =BTC= MUTTLEY ========================";
};







