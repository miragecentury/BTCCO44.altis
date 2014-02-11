///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};
waitUntil {sleep 1;(init_server_done)};
if ((isServer)&&((BTC_patrols_veh == 1))) then 
{
//////////////////// LAND VEHICLES \\\\\\\\\\\\\\\\\\\\
_mark 	  			= _this select 0;
_ptr_veh_ligth		= BTC_enemy_veh select 0;
_ptr_veh_track		= BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
_ptr_veh_track2		= BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
_ptr_veh_track3		= BTC_enemy_tracked select (round (random ((count BTC_enemy_tracked) - 1)));
_BTC_patr_vehi_land	= [];	
switch (BTC_difficulty) do
{
	case 0 : {_BTC_patr_vehi_land	= [_ptr_veh_ligth];};
	case 3 : {_BTC_patr_vehi_land	= [_ptr_veh_ligth, _ptr_veh_track];};
	case 10 : {_BTC_patr_vehi_land	= [_ptr_veh_ligth, _ptr_veh_track, _ptr_veh_track2];};
	case 20 : {_BTC_patr_vehi_land	= [_ptr_veh_ligth, _ptr_veh_track, _ptr_veh_track2, _ptr_veh_track3];};
};
diag_log format ["PATROL_VEH.SQF, RANDOM VEHICLES ARRAY: %1", _BTC_patr_vehi_land];
/////////////////////////////////////////////////////////

	BTC_fnc_patrol_vehicles =
	{
		_marker 		= _this select 0;
		_BTC_type_veh 	= _this select 1;
		
		if (BTC_debug == 1) then {_marker setMarkerAlpha 1; };
		_getsize = getMarkerSize _marker;
		_size_area = _getsize select 0;
		while {(BTC_patrols_veh == 1)} do 
		{
			_area = [GetMarkerPos _marker, 0, _size_area, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
			while { (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && ((_x distance _area) < 3000)} count allUnits) > 0) && (_area distance (markerpos "base_flag") < 3000) }
			do {_area = [GetMarkerPos _marker, 0, _size_area, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos; sleep 0.001;};

			waitUntil {sleep 3; ( 
			  (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _area) < 1000)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _area) < 1500)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _area) < 3000)} count allUnits) > 0) 
					 ) 			};

			_lnd_veh = [_area, 0,_BTC_type_veh,BTC_enemy_side1] call bis_fnc_spawnvehicle; 
			sleep 1;
			//if (BTC_debug == 1) then {diag_log text format ["PATROL_VEH.SQF, SPAWN: %1", _BTC_type_veh];};
			_lnd_veh_grp = group leader (_lnd_veh select 2);	
			//_patrol = [leader (_lnd_veh select 2),_marker,random 30, 0, 1000] execVM "scripts\BTC_UPS.sqf";
			_nul = [GROUP (leader (_lnd_veh select 2)), getPos (_lnd_veh select 0), 2000] call bis_fnc_taskpatrol; 
			sleep 1; // Necessario per i marker di Debug
			if (BTC_track) then {_track = [leader _lnd_veh_grp] execVM "scripts\BTC_track_unit.sqf";};
			if (BTC_AI_skill < 10) then {_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _lnd_veh_grp; _skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _lnd_veh_grp; _skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _lnd_veh_grp;};
			//if (BTC_debug == 1) then {player sideChat format["PATROL VEHICLE PATROLLING"];};
			
			waitUntil {sleep 5; ((!Alive vehicle (_lnd_veh select 0))||(!CanMove vehicle (_lnd_veh select 0)))};
			{deleteVehicle _x;} forEach crew (_lnd_veh select 0); 
			sleep BTC_resp_enemy_time; // Time before respawn again
			
			//if (BTC_debug == 1) then {player sideChat format["PATROL VEHICLE RESPAWN"];};
		}; // Fine parentesi while do
	};

	{[_mark, _x] spawn BTC_fnc_patrol_vehicles;} forEach _BTC_patr_vehi_land;
}; // Fine parentesi isServer







