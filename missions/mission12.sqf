///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

/// Mission 12 Kidnap the kidnap_officer
//chose marker for spawning enemies OK
	
if (isServer) then {
BTCM_side_miss_end12 = false; publicVariableServer "BTCM_side_miss_end12";
kidnap_officer_jail = false; publicVariable "kidnap_officer_jail";
skip_miss12 = false; publicVariable "skip_miss12";
trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
kill_var = false; publicVariable "kill_var"; skip_var = false; publicVariable "skip_var";
off_surrender = false; publicVariable "off_surrender";
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M12","plain down",0];};
diag_log "======================== 'SIDES PATROLS' START 'MISSION 12' by =BTC= MUTTLEY ========================";
diag_log (format["MARKER SELECTION MISSION 12 START"]);

// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M12"]);
_position = call BTC_fnc_choselocation;
"areaI" setMarkerPos BTC_position;
 mrk_side_miss = "areaI"; 
// // // // // // // // // // // // // // // // // // // //
	
if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M12 DONE","plain down",0];};
diag_log (format["MARKER SELECTION M12 DONE"]);

_mrk_dim = (60 + (BTC_difficulty * 15));
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side];
_clr = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)",
"{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var'; BTCM_side_miss_end12 = true; publicVariableServer 'BTCM_side_miss_end12';"] spawn BTC_create_trigger_count_unit;
if (BTC_debug == 1) then {Titletext ["TRIGGER DELETE ENEMY M12 DONE","plain down",0];};
diag_log (format["TRIGGER DELETE ENEMY M12 DONE"]);

//////////////////////////////// kidnap_officer ////////////////////////
private["_spawn_area","_veh_name","_group","_unit_type","_kidnap_officer","_unit_type2","_group","_pos_off"];
_spawn_area  = mrk_side_miss;
_veh_name 	 = "kidnap_officer";
_group 		 = createGroup BTC_enemy_side1;
_unit_type 	 = BTC_enemy_Off;
_spw_coord	 = getMarkerPos mrk_side_miss;
_pos_off = [_spw_coord, 5, _mrk_dim /2, 2, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
_kidnap_officer = _group createUnit [_unit_type, _pos_off, [], 0, "NONE"];
removeHeadgear _kidnap_officer;  _kidnap_officer addHeadgear "H_Beret_red";
removeAllWeapons _kidnap_officer;
{_kidnap_officer addMagazine _x} forEach ["30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag"];
_kidnap_officer addweapon "SMG_02_F";
if (BTC_debug == 1) then {_kidnap_officer AllowDamage false;};
_kidnap_officer setSkill ["courage", 0.7]; 
_kidnap_officer setSkill ["aimingShake", 0.5]; 
_kidnap_officer setSkill ["aimingAccuracy", 0.5]; 
_kidnap_officer SetVehicleVarName _veh_name; _kidnap_officer Call Compile Format ["%1=_This ; PublicVariable ""%1""",_veh_name];
waitUntil {(vehicleVarName _kidnap_officer == _veh_name)};
if (BTC_debug == 1) then {Titletext ["kidnap_officer SPAWN OK M12 DONE","plain down",0];};
diag_log (format["kidnap_officer SPAWN OK M12 DONE"]);

_house = nearestbuilding _kidnap_officer;		// Controlla le case vicino
_dist = _mrk_dim;
if ((_house distance _kidnap_officer) < _dist) then // Se la casa è vicina 
{
		// Mette dentro
		_pos_H = 0;
		while { format ["%1", _house buildingPos _pos_H] != "[0,0,0]" } do {_pos_H = _pos_H + 1};
		_pos_H = _pos_H -1;
		_kidnap_officer setpos (_house buildingpos (round (random _pos_H)));
};

// Enemies guard
_guards = createGroup BTC_enemy_side1;
for "_i" from 0 to (1 + (round(BTC_difficulty /2))) do
{
_unit_type2 = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
_guards createUnit [_unit_type2, getPos kidnap_officer, [], 10, "NONE"];
};
_skill = {_x setSkill ["aimingAccuracy", BTC_AI_skill /2];} foreach units _guards;
[_guards] joinSilent kidnap_officer;
/////////////////////////////

if (BTC_debug == 1) then {Titletext ["kidnap_officer GUARD OK M12 DONE","plain down",0];};
diag_log (format["kidnap_officer GUARD OK M12 DONE"]);

"areaI" setMarkerPos getMarkerPos mrk_side_miss; "areaI" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];	
// Crea nemici fanteria // 
for "_i" from 0 to (3 + (BTC_difficulty)) do {_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;};
/////////////////////////////////////////////////////////

_nul2 = [] spawn {if (BTC_debug == 1) then {while {!(BTCM_side_miss_end12)} do {sleep 1; "debug_mrk" setMarkerPos getPos kidnap_officer;};};};
////////////////////////////////////////////////



if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M12","plain down",0];};
diag_log (format["CREATE CONTROL TRIGGER M12"]);

numVehicle12 = 0;
_count_unit = [] spawn 
{	
	_numVehicle12 = 0;
	_Vehicle = [];
	while {!(BTC_end_mission_12)} do
	{	//"LandVehicle"
		_Vehicle = nearestObjects [getPos kidnap_officer, ["Man"], 100];
	   if (count _Vehicle > 0) then
		{	
			_Vehicle = nearestObjects [getPos kidnap_officer, ["Man"], 100];
			_numVehicle12 = {(alive _x) && (side _x == BTC_enemy_side1)} count _Vehicle; 
			numVehicle12 = _numVehicle12;
			_skill = _numVehicle12 /10;
			//Skill & Courage depend on enemy number arround kidnap_officer
			if (_skill > 0.7) then {_skill = 0.7};
			kidnap_officer setSkill ["courage", _skill]; 
			kidnap_officer setSkill ["aimingShake", _skill]; 
			kidnap_officer setSkill ["courage", _skill];
			kidnap_officer setSkill ["endurance", _skill];
			kidnap_officer setSkill ["aimingAccuracy", _skill];
			if (_skill <= 0.2) then {kidnap_officer allowFleeing (random 1);};
		   if (BTC_debug == 1) then {player sideChat format ["kidnap_officer soldier left: %1", _numVehicle12];};
		};
	if !(someAmmo kidnap_officer) then {player sideChat format ["kidnap_officer finish ammo!"];};
	 sleep 10;
	};
};

if (BTC_debug == 1) then {Titletext ["WAIT UNTILL 'numVehicle12 > 0' M12","plain down",0];};
diag_log (format["WAIT UNTILL 'numVehicle12 > 0' M12"]);
waitUntil {sleep 0.1;(numVehicle12 > 2)};
kidnap_officer setCaptive true;



///// MISSION CREATION COMPLETE /////
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_12",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk12",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {sleep 1;(getMarkerColor "mrk12" != "")};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_12 = true; sleep 1; publicVariable "BTC_start_mission_12";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 12 COMPLETE","plain down",0];}; diag_log (format["SPAWN ENEMIES MISSION 12 COMPLETE"]);

// kidnap_officer arreso
_TRG0 = [mrk_side_miss,0,"ANY","PRESENT","(numVehicle12 < 2) || (!(someAmmo kidnap_officer) && (numVehicle12 < 4))",
"off_surrender = true; publicVariable 'off_surrender'; _surr = [] execVM 'missions\surrender.sqf';"] spawn BTC_create_trigger_count_unit;
// kidnap_officer arrestato
_TRG1 = ["jail_mrk",5,"ANY","PRESENT","(kidnap_officer in thislist)",
"kidnap_officer_jail = true; publicVariable 'kidnap_officer_jail'; BTCM_side_miss_end12 = true; publicVariableServer 'BTCM_side_miss_end12';"] spawn BTC_create_trigger_count_unit;
// kidnap_officer ucciso
_TRG2 = ["jail_mrk",0,"ANY","PRESENT","!(alive kidnap_officer)",
"kidnap_officer_jail = false; publicVariable 'kidnap_officer_jail'; BTCM_side_miss_end12 = true; publicVariableServer 'BTCM_side_miss_end12';"] spawn BTC_create_trigger_count_unit;
if (BTC_debug == 1) then {Titletext ["MISSION 12 COMPLETE","plain down",0];}; diag_log (format["MISSION 12 COMPLETE"]);

_null = [mrk_side_miss,_mrk_dim] execVM "scripts\reinforcement\BTC_reinforcement.sqf";
if (BTC_stc_city == 1) then {[mrk_side_miss] execVM "scripts\patrol\patrols_STAT.sqf";};

///////////////////////////////////////////////////////////////// MISSION END /////////////////////////////////////////////////////////////////
_nul = [] spawn 
{ 
	waitUntil {sleep 3; (BTCM_side_miss_end12)};
	
	if ((kidnap_officer_jail) && !(skip_var)) //missione conclusa
	then { "mrk12" setMarkerSize [3,3]; "mrk12" setMarkerColor mrk_color_end; "mrk_miss_12" setMarkerColor mrk_color_end;  skip_miss12 = false; publicVariable "skip_miss12"; };
	
		if (!(kidnap_officer_jail) && !(skip_var)) //missione fallita
		then { "mrk12" setMarkerSize [3,3]; "mrk12" setMarkerColor "ColorRed"; "mrk_miss_12" setMarkerColor "ColorRed"; skip_miss12 = false; publicVariable "skip_miss12";}; 
	
			if (!(kidnap_officer_jail) && (skip_var)) //missione cancellata dall'utente
			then { "mrk12" setMarkerSize [3,3]; "mrk12" setMarkerColor "ColorGrey"; "mrk_miss_12" setMarkerColor "ColorGrey"; skip_miss12 = true; publicVariable "skip_miss12"; kill_var_M12 = true; publicVariableServer "kill_var_M12"; };

"areaS" setMarkerPos getMarkerPos "out_map"; "areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
side_chose_init = true; publicVariableServer "side_chose_init";
BTC_end_mission_12 = true; publicVariable "BTC_end_mission_12";
};
diag_log "======================== 'SIDES PATROLS' END 'MISSION 12' by =BTC= MUTTLEY ========================";
};











