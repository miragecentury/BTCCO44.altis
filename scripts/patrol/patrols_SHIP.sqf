///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};
waitUntil {sleep 5;(init_server_done)};

if ((isServer)&&((BTC_patrols_ship == 1))) then 
{
	//if (BTC_debug == 1) then {diag_log text format ["PATROL_SHIP.SQF, SCRIPT START"];};
	_marker = _this select 0;
		
	BTC_fnc_patrol_ships =
	{
		_marker 		= _this select 0;
		_BTC_type_ship  = BTC_enemy_boats select 0;
		_area 			= GetMarkerPos _marker;
		while {(BTC_patrols_ship == 1)} do 
		{
			//if (BTC_debug == 1) then {diag_log text format ["PATROL_SHIP.SQF, Marker: %1 selected, wait for spawn.",_marker];};
			
			waitUntil{sleep 5; ( 
			  (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _area) < 1500)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _area) < 2500)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Ship") && ((_x distance _area) < 3000)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _area) < 4000) && ((getPosATL _x) select 2 > 20)} count allUnits) > 0) 
					 ) 			};
					 
			//if (BTC_debug == 1) then {diag_log text format ["PATROL_SHIP.SQF, SPAWN."];};
			_ship = [_area, 0,_BTC_type_ship,BTC_enemy_side1] call bis_fnc_spawnvehicle; _ship_grp = group leader (_ship select 2);	//if (BTC_debug == 1) then {diag_log text format ["PATROL_SHIP.SQF, SHIP SPAWN."];};
			_patrol = [leader (_ship select 2),_marker,random 30, 0] execVM "scripts\BTC_UPS.sqf";if (BTC_track) then {_track = [leader _ship_grp] execVM "scripts\BTC_track_unit.sqf";};
			if (BTC_AI_skill < 10) then {	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _ship_grp; _skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _ship_grp; _skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _ship_grp;};
			//if (BTC_debug == 1) then {player sideChat format["PATROL SEA PATROLLING"];};
			
			waitUntil 
			{sleep 5; (
			(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _area) < 1500)} count allUnits) < 1)&&
			(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _area) < 2500)} count allUnits) < 1)&&
			(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Ship") && ((_x distance _area) < 3000)} count allUnits) < 1)&&
			(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _area) < 4000) && ((getPosATL _x) select 2 > 20)} count allUnits) < 1)
			)};
			if (Alive vehicle (_ship select 0)) then {{deleteVehicle _x;} forEach crew (_ship select 0); deleteVehicle (_ship select 0); sleep 3;}
			else {sleep BTC_resp_enemy_time;};  // Time before respawn again after be destroyed;
			
			//if (BTC_debug == 1) then {player sideChat format["PATROL SEA RESPAWN"];};
		}; // Fine parentesi while do
	};

	[_marker] spawn BTC_fnc_patrol_ships;

//if (BTC_debug == 1) then {diag_log text format ["PATROL_SHIP.SQF, SCRIPT END"];};



};



