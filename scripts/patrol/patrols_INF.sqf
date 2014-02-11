///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};
waitUntil{sleep 1; !isnil "BTC_side_enemy"};
waitUntil {sleep 1;(init_server_done)};
if ((isServer)&&((BTC_patrols_inf == 1))) then 
{

	/////////////////////// INFANTRY \\\\\\\\\\\\\\\\\\\\\\\\
	_BTC_type_man = [];
	_mark 	  = _this select 0;
	switch (BTC_side_enemy) do
	{
		
		// CASE WEST vs
		case 0 :{_soldier = ["O_Soldier_AA_F","O_Soldier_AT_F","O_Soldier_AR_F","O_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F","O_sniper_F"];}; //"O_spotter_F"
		case 1 :{_soldier = ["O_Soldier_AA_F","O_Soldier_AT_F","O_Soldier_AR_F","O_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"O_G_Soldier_AR_F","O_G_Soldier_SL_F","O_G_Soldier_SL_F","O_G_Soldier_SL_F","O_G_Soldier_SL_F","O_sniper_F"];};//,"O_spotter_F"
		case 2 :{_soldier = ["I_Soldier_AA_F","I_Soldier_AT_F","I_Soldier_AR_F","I_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"I_Soldier_AT_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F","I_sniper_F"];};//"I_spotter_F"
		// CASE EAST vs
		case 3 :{_soldier = ["B_Soldier_AA_F","B_Soldier_AT_F","B_Soldier_AR_F","B_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"B_Soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F","B_sniper_F"];};//,"B_spotter_F"
		case 4 :{_soldier = ["B_Soldier_AA_F","B_Soldier_AT_F","B_Soldier_AR_F","B_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"B_G_SB_ldier_AR_F","B_G_SB_ldier_SL_F","B_G_SB_ldier_SL_F","B_G_SB_ldier_SL_F","B_G_SB_ldier_SL_F","B_sniper_F"];};//,"B_spotter_F"
		case 5 :{_soldier = ["I_Soldier_AA_F","I_Soldier_AT_F","I_Soldier_AR_F","I_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F","I_Soldier_SL_F","I_sniper_F"];};//"I_spotter_F"
		// CASE AAF vs
		case 6 :{_soldier = ["O_Soldier_AA_F","O_Soldier_AT_F","O_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F","O_Soldier_SL_F","O_sniper_F"];}; //"O_spotter_F"
		case 7 :{_soldier = ["B_Soldier_AA_F","B_Soldier_AT_F","B_Soldier_AR_F"] call BIS_fnc_selectRandom;_BTC_type_man = [_soldier,"B_Soldier_AR_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F","B_Soldier_SL_F","B_sniper_F"];};//,"B_spotter_F"
	};
	if (BTC_debug == 1) then {diag_log text format ["PATROL_INF.SQF, _BTC_type_man: n.%1 %2",count _BTC_type_man, _BTC_type_man];};
	/////////////////////////////////////////////////////////
	BTC_fnc_patrol_infantry =
	{
		_marker 	= _this select 0;
		_sold1		= _this select 1;
		_sold2		= BTC_enemy_medic;
		_sold3		= BTC_enemy_TL;
		_rad_ptrl 	= (getMarkerSize _marker) select 0;
		_area 		= GetMarkerPos _marker;

		while {(BTC_patrols_inf == 1)} do
		{
			_pos = [_area, 0, _rad_ptrl, 1, 0, 70*(pi / 180), 0] call BIS_fnc_findSafePos;
			while 
			{
				(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && ((_x distance _pos) < 1500)} count allUnits) > 0) 
				&& (_pos distance (markerpos "base_flag") < 3000) && (_pos distance (markerpos _marker) > _rad_ptrl) 
			} 
			do {_pos = [_area, 0, _rad_ptrl, 1, 0, 70*(pi / 180), 0] call BIS_fnc_findSafePos;sleep 0.001;};

			waitUntil {sleep 3; (
			  (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _pos) < 1000)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _pos) < 1500)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _pos) < 2000)} count allUnits) > 0) 
			) 			};

			private["_group","_Sold_lead","_Sold_med","_Sold_sl"];
			_group 		= createGroup BTC_enemy_side1;
			_Sold_lead 	= _group createUnit [_sold1, _pos, [], 0, "this setRank 'COLONEL';"];
			_Sold_med 	= _group createUnit [_sold2, _pos, [], 5, "FORM"];
			for "_i" from 0 to (BTC_val_diff)-1 do 
			{_Sold_sl 	= _group createUnit [_sold3, _pos, [], 5, "FORM"];};
			
			_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
			_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
			_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;
			_patrol = [leader _group,_marker,random 30, 0] execVM "scripts\BTC_UPS.sqf";
			if (BTC_track) then {_track = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
			//if (BTC_debug == 1) then {player sideChat format["PATROL_INF.SQF, PATROL SPAWNED"];};

			waitUntil {sleep 3; 
			( (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _pos) < 1000)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _pos) < 1500)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _pos) < 2000)} count allUnits) < 1) 
			) };
			
			if ((Alive _Sold_lead)OR(Alive _Sold_med)) then {{deleteVehicle _x} forEach units _group;};
			//if (BTC_debug == 1) then {player sideChat format["PATROL_INF.SQF, PATROL RESPAWN"];};
			sleep BTC_resp_enemy_time; //Time before respawn again
		}; // Fine parentesi while do
	};
	
	{[_mark, _x] spawn BTC_fnc_patrol_infantry;} forEach _BTC_type_man;
	if (BTC_val_diff > 1) then {{[_mark, _x] spawn BTC_fnc_patrol_infantry;} forEach _BTC_type_man;};



};









