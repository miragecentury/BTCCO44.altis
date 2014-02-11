///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Clear the area from recons patrol!
//chose marker for spawning
	if (isServer) then {
	trg_civ_del = true; sleep 0.5; publicVariable "trg_civ_del";
	side_miss_end_4 = false; publicVariableServer "side_miss_end_4";
	kill_var = false; publicVariable 'kill_var'; skip_var = false; publicVariable 'skip_var';	
	if (BTC_debug == 1) then {Titletext ["MARKER SELECTION M4","plain down",0];};
	diag_log "======================== 'SIDES PATROLS' START 'MISSION 4' by =BTC= MUTTLEY ========================";
	diag_log (format["MARKER SELECTION MISSION 4"]);
	
// // // // // // // Marker selection // // // // // // //
diag_log (format["::'SIDES PATROLS':: START FIND LOCATION M4"]);
_position = call BTC_fnc_choselocation_out;
"areaI" setMarkerPos BTC_position_out;
 mrk_side_miss = "areaI";
// // // // // // // // // // // // // // // // // // // //


if (BTC_debug == 1) then {Titletext ["MARKER SELECTION DONE M4","plain down",0];};
diag_log (format["MARKER SELECTION DONE M4"]);

_mrk_dim = (70 + (BTC_difficulty * 15));
"areaI" setMarkerSize [_mrk_dim*0.8, _mrk_dim*0.8];
 
// Crea nemici fanteria
for "_i" from 0 to (3 + (BTC_difficulty)) do
{
//_BTC_grp = ["areaI"] spawn BTC_spawn_inf_recon_patrol;
	private ["_spwn_mrk","_spawn_area","_size","_rad_ptrl","_min_patrl","_n_enemy","_pos","_group","_skill"];	
	_spwn_mrk   = "areaI";
	_spawn_area = getMarkerPos _spwn_mrk;
	_size		= getMarkerSize _spwn_mrk;
	_rad_ptrl	= _size select 0;
	_min_patrl	= _rad_ptrl / 2;
	_n_enemy    = 1 + (round(random 1));
	_pos = [_spawn_area, _min_patrl, _rad_ptrl, 1, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_group = createGroup BTC_enemy_side1;
	_group createUnit [ BTC_enemy_TL, _pos, [], 0, "NONE"];
	for "_i" from 0 to (_n_enemy - 1) do
	{
		_unit_type = BTC_enemy_recon select (round (random ((count BTC_enemy_recon) - 1)));
		_group createUnit [_unit_type, _spawn_area, [], 10, "NONE"];
	};
	if (BTC_AI_skill < 10)then{	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	//Independent have NO 'Recon' units
	{
	if ((_x isKindOf "I_Soldier_SL_F")OR(_x isKindOf "I_medic_F")) then {_x addItem "muzzle_snds_B";  _x assignItem "muzzle_snds_B"; };
	}foreach units _group;
	
	{
	if (_x isKindOf "I_Soldier_sniper_base_F") then {_x addItem "muzzle_snds_B";  _x assignItem "muzzle_snds_B"; };
	}foreach units _group;
	_patrol = [leader _group,_spwn_mrk,random 30, 0] execVM "scripts\BTC_UPS.sqf";
	if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};
/////////////////////////////////////////////////////////

_trg_dim = (100 + (BTC_difficulty * 15));
if (BTC_debug == 1) then {Titletext ["CREATE CONTROL TRIGGER M4","plain down",0];}; diag_log (format["CREATE CONTROL TRIGGER M4"]);
///// MISSION CREATION COMPLETE /////
_spawn = [0,0,0,"ELLIPSE","Border",mrk_color_start,"","","mrk_miss_4",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
_spawn = [4,4,0,"ICON","Border",mrk_color_start,"","loc_Tree","mrk04",mrk_side_miss] spawn BTC_create_marker; //Marker per le tasks
waitUntil {(getMarkerColor "mrk04" != "")};

//////////////////////////////////////// MISSION START \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_start_mission_4 = true; publicVariable "BTC_start_mission_4";
if (BTC_debug == 1) then {Titletext ["SPAWN ENEMIES MISSION 4 COMPLETE","plain down",0];}; diag_log (format["SPAWN ENEMIES MISSION 4 COMPLETE"]);
//trigger per cancellare nemici in caso skip missione debug
_BTC_enemy_side = format ["%1",BTC_enemy_side1];
_clr = [mrk_side_miss,_mrk_dim*2,_BTC_enemy_side,"PRESENT","(kill_var OR skip_var)","{(vehicle _x) setDamage 1; _x setDamage 1} forEach thislist; kill_var = false; publicVariable 'kill_var';"] spawn BTC_create_trigger_count_unit;
// Controllo numero di nemici rimanenti
BTCM_side_miss_end4 = false; publicVariableServer "BTCM_side_miss_end4";
_check = [mrk_side_miss,_trg_dim*2,_BTC_enemy_side,"PRESENT","!(BTC_end_mission_4) &&(count thislist <= 1)",
"BTCM_side_miss_end4 = true; publicVariableServer 'BTCM_side_miss_end4';"] spawn BTC_create_trigger_count_unit;

_null = ["areaI",_mrk_dim *2] execVM "scripts\reinforcement\BTC_reinforcement.sqf";

///// MISSION END /////
_nul = [] spawn { waitUntil {sleep 3; (BTCM_side_miss_end4) };
	if !(skip_var)
	then { //missione conclusa
	"mrk04" setMarkerSize [3,3]; "mrk04" setMarkerColor mrk_color_end; "mrk_miss_4" setMarkerColor mrk_color_end; skip_miss4 = false; publicVariable "skip_miss4";}
	else {	// missione cancellata dall'utente
	"mrk04" setMarkerSize [3,3]; "mrk04" setMarkerColor "ColorGrey"; "mrk_miss_4" setMarkerColor "ColorGrey"; skip_miss4 = true; publicVariable "skip_miss4";};

"areaI" setMarkerPos getMarkerPos "out_map"; "areaV" setMarkerPos getMarkerPos "out_map";
BTC_end_mission_4 = true; publicVariable "BTC_end_mission_4";
side_chose_init = true; publicVariableServer "side_chose_init"; 

};


diag_log "======================== 'SIDES PATROLS' END 'MISSION 4' by =BTC= MUTTLEY ========================";
};
	











