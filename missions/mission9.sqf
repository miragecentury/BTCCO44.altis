///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

// Mission 9 KILL THE OFFICER
//chose marker for spawning enemies OK
if (isServer) then {
//trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del"; escape_officer = false; publicVariable "escape_officer";
BTCM_side_miss_end9 = false; publicVariableServer "BTCM_side_miss_end9";
kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';
kill_var_M9 = false; publicVariableServer "kill_var_M9";
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION MISSION 9","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 9' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 9"]);


// // // // // // // Marker selection // // // // // // //
_xx = 0;
_chose_mrk_rnd = true;
_minDist = 500;
_maxDist = 1000;

_mrk_side_miss = [BTC_sea_miss_array, position Player] call BIS_fnc_nearestPosition;
if (BTC_debug == 1) then {player sideChat format["Marker for mission 9: %1", _mrk_side_miss];};

_chose_mrk_rnd = true;
while {(_chose_mrk_rnd)} do
{
	_pos = [getMarkerPos _mrk_side_miss, 500, _maxDist, 3, 0, 50*(pi / 180), 1] call BIS_fnc_findSafePos; //Search Shore
	"debug_mrk" setMarkerPos _pos;
	if ((({(isPlayer _x) && ((_x distance _pos) > _minDist)} count allUnits) > 0)&&
	(({(isPlayer _x) && ((_x distance _pos) < _maxDist)} count allUnits) > 0)&& 
	((_pos distance (markerPos "base_port")) > 1000)	)
	then {_chose_mrk_rnd = false; mrk_side_miss = _pos;}
	else {_chose_mrk_rnd = true; _xx = _xx + 1;}; 
	if (_xx > 1) then {_maxDist = _maxDist + 500; _xx = 0; 
	diag_log (format["::SIDES PATROLS:: M9 MAX DISTANCE INCREASE"]);};
	sleep 0.01;
};
if (BTC_debug == 1) then {player sideChat format["::SIDES PATROLS:: M9 SHORE FOUND"]; diag_log (format["::SIDES PATROLS:: M9 SHORE FOUND"]);};
// // // // // // // // // // // // // // // // // // // // // // // // // // // //

_posWreck 	 = [mrk_side_miss, 70, 100, 3, 2, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
_Good_wrecks = [_posWreck, 0, 30, 3, 2, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
_wreck = createVehicle ["Land_Wreck_Traw2_F", [(_Good_wrecks select 0),(_Good_wrecks select 1),-1], [], 0, "CAN_COLLIDE"]; 
_wreck setDir 90;
_pos_wreck = getPos _wreck;
player sideChat format ["Wreck deepness: %1",(getPosASL _wreck) select 2];
diag_log format ["Wreck deepness: %1",(getPosASL _wreck) select 2];

////////////////////////////// Find a good pos for wreck //////////////////////////////////////////
_minDist = 50; _maxDist = 100; _attempt = 0; _minDeep = -15 + (random -15);
while {(((getPosASL _wreck) select 2 > _minDeep)||((getPosASL _wreck) select 2 < (_minDeep -15)))}
do
{
	_posWreck = [_pos_wreck, _minDist, _maxDist, 3, 2, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
	_wreck setPosATL [(_posWreck select 0),(_posWreck select 1),0];
	"debug_mrk" setMarkerPos getPos _wreck;
	_attempt = _attempt + 1;
	if (_attempt == 10) then {_attempt = 0; _minDist = _minDist + 100; _maxDist = _maxDist + 100;};
	sleep 0.001;
};

_pos_wreck = getPos _wreck;
_wreck = createVehicle ["Land_Wreck_Traw_F", [(_pos_wreck select 0)+40,(_pos_wreck select 1),-1], [], 0, "CAN_COLLIDE"]; 
_wreck setDir 60;
if (BTC_debug == 1) then {player sideChat format ["Wreck final deepness: %1",(getPosASL _wreck) select 2];diag_log format ["Wreck final deepness: %1",(getPosASL _wreck) select 2];};
////////////////////////////////////////////////////////////////////////////////////

if (BTC_debug == 1) then {"debug_mrk" setMarkerPos getPos _wreck; Titletext ["WRECK SPAWN DONE","plain down",0];};
diag_log (format["WRECK SPAWN DONE"]);

// Decorations
for "_i" from 0 to 39 do 
{
	_rnd_obj = ["land_bw_SetBig_Brains_F","land_bw_SetBig_corals_F","land_bw_SetBig_corals_F","land_bw_SetBig_corals_F","land_bw_SetBig_corals_F","land_bw_SetBig_TubeG_F","land_bw_SetBig_TubeY_F","land_bw_SetSmall_Brains_F","land_bw_SetSmall_TubeG_F","land_bw_SetSmall_TubeY_F"] call BIS_fnc_selectRandom; 
	_position = [((_pos_wreck) select 0)-((random 15)+5)*sin(random 359), ((_pos_wreck) select 1)-((random 15)+5)*cos(random 359),-0.07];
	_object = createVehicle [_rnd_obj, _position, [], 0, "NONE"]; _object setDir (random 359);
}; 

_mrk_dim = (50 + (BTC_difficulty * 2));
"areaS" setMarkerPos _pos_wreck;
"areaS" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];
"areaV" setMarkerPos _pos_wreck;
"areaV" setMarkerSize [_mrk_dim, _mrk_dim];
_rnd_ship = BTC_enemy_boats select 0;
_BOAT = ["areaV","areaV",_rnd_ship] spawn BTC_spawn_veh;
if (BTC_debug == 1) then {Titletext ["CREA OFFICER","plain down",0];};
diag_log (format["CREA OFFICER MISSION 9"]);

// Crea obiettivo officer
_spawn = ["areaS",0] spawn BTC_spawn_diver_officer;

if (BTC_debug == 1) then {Titletext ["CREA SUB OFFICER","plain down",0];};
diag_log (format["CREA SUB OFFICER MISSION 9"]);

waitUntil {!(isNil ("diver_officer"))};
_nul2 = [] spawn {if (BTC_debug == 1) then {while {!(BTCM_side_miss_end9)} do {sleep 1; "debug_mrk" setMarkerPos getPos diver_officer;};};};

if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER MISSION 9"]);

///////// Trigger blufor scoperti /////////
_BTC_friendly_side1 = format ["%1",BTC_friendly_side1];
_BTC_enemy_side1 	= format ["%1",BTC_enemy_side1];
_string				= " D";
_side_discovered	= format ["%1%2",BTC_enemy_side1,_string];
if (BTC_debug == 1) then {player sidechat format ["SIDE to DICOVER: %1",_side_discovered];};
_n4 = [_pos_wreck,_mrk_dim,_BTC_friendly_side1,_side_discovered,
"this && (diver_officer in thislist)", 
"diver_officer switchMove 'aidlpercmstpsraswrfldnon_idlesteady01n';
_grp = group diver_officer;
_wp = _grp addWaypoint [getMarkerPos 'center_map', 1];
_wp setWaypointBehaviour 'CARELESS';
_wp setWaypointSpeed 'FULL';
_wp setWaypointType 'MOVE';
_wp setWaypointCombatMode 'BLUE';
[_grp, 1] setWaypointPosition [getMarkerPos 'center_map', 1];"] spawn BTC_create_trigger_count_unit;


//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_9 = true; publicVariable "BTC_start_mission_9";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 9 COMPLETE","plain down",0];};
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_clr = [_pos_wreck,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var OR kill_var_M9)","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;

// Controllo condizioni fine
BTCM_side_miss_end9 = false; publicVariableServer "BTCM_side_miss_end9";
_n2 = [_pos_wreck,0,"LOGIC","PRESENT","(!alive diver_officer)&&!(BTCM_side_miss_end9)",
"BTCM_side_miss_end9 = true; publicVariableServer 'BTCM_side_miss_end9';"] spawn BTC_create_trigger_count_unit;
_n3 = [_pos_wreck,_mrk_dim *2,"ANY","NOT PRESENT",
"(Alive diver_officer)&&!(diver_officer in thislist)&&!(BTCM_side_miss_end9)",
"BTCM_side_miss_end9 = true; publicVariableServer 'BTCM_side_miss_end9';"] spawn BTC_create_trigger_count_unit;

///// MISSION CREATION COMPLETE /////
diag_log (format["SPAWN ENEMIES MISSION 9 COMPLETE"]);
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_9",_pos_wreck] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk09",_pos_wreck] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk09" != "")};

//////////////////////////// MISSION END ////////////////////////////////////////
_n = [] spawn 
{
		waitUntil {sleep 4; (BTCM_side_miss_end9)};

		//missione conclusa officer ucciso
		if (!(alive diver_officer) && !(skip_var))
		then 
		{
		"mrk09" setMarkerSize [3,3]; "mrk09" setMarkerColor mrk_color_end; "mrk_miss_9" setMarkerColor mrk_color_end; skip_miss9 = false; publicVariable "skip_miss9"; 
		_nul = [] spawn {waitUntil{(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getMarkerPos "mrk_miss_9")) < 500)} count allUnits) < 1)};kill_var_M9 = true; publicVariableServer "kill_var_M9"; }; 
		};

			//missione conclusa officer scappato
			if ((alive diver_officer) && !(skip_var))
			then 
			{
				"mrk09" setMarkerSize [3,3]; "mrk09" setMarkerColor "ColorRed"; "mrk_miss_9" setMarkerColor "ColorRed"; skip_miss9 = false; publicVariable "skip_miss9";
				_nul = [] spawn {
				waitUntil{(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getMarkerPos "mrk_miss_9")) < 500)} count allUnits) < 1)};
				kill_var_M9 = true; publicVariableServer "kill_var_M9"; 
				waitUntil{(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getPos diver_officer)) < 700)} count allUnits) < 1)};
				if (Alive diver_officer) then {deleteVehicle diver_officer;};};
			};
			
		// missione cancellata dall'utente
		if (skip_var)
		then {"mrk09" setMarkerSize [3,3]; "mrk09" setMarkerColor "ColorGrey"; "mrk_miss_9" setMarkerColor "ColorGrey"; skip_miss9 = true; publicVariable "skip_miss9";}; 
		
		"areaS" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";"debug_mrk" setMarkerPos getMarkerPos "out_map";
		side_chose_init = true; publicVariableServer "side_chose_init";
		BTC_end_mission_9 = true; publicVariable "BTC_end_mission_9";
};

diag_log "======================== 'SIDES PATROLS' END 'MISSION 9' by =BTC= MUTTLEY ========================";
};								











