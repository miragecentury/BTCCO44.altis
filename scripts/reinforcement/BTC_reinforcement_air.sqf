///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////
// scripts\BTC_reinforcement.sqf
	

// Start ad inizio missione
//Random rinforzo a seconda livello difficoltà: 2 x paradrop, 1 camion con truppe, 1 Gunship con paradrop, 1 tank leggero con truppe + jeep armata
//Lv 1: (1 x paradrop 8 soldati) || (1 camion con truppe 8 soldati)
//Lv 2: (2 x paradrop 8 soldati) || (1 camion con truppe 16 soldati) || (1 elicottero leggero ORCA con paradrop)
//Lv 3: (2 x paradrop 8 soldati) || (1 camion con truppe 16 soldati) || (1 elicottero Gunship con paradrop) || (1 tank leggero con truppe + jeep armata)
//Lv 4: come Lv 3 x 2

	
if ((isServer)&&(BTC_reinforcements > 0)) then
{
	_posSpawn = _this select 0;
	_posCity  = _this select 1;
	_vehType  = _this select 2;
	if (isNil ("_vehType"))	then {_vehType = BTC_enemy_heli select ((count BTC_enemy_heli) - 1);} else {_vehType = _this select 2;};
	//Lv 1: (1 x paradrop 8 soldati) || (1 camion con truppe 8 soldati)
		//_name = TRACK_Instances; TRACK_Instances = TRACK_Instances + 1; 	_veh_name 	= "BTC_REINF_HELI_" + str _name;
		
		waitUntil {sleep 1; ( 
		  (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _posSpawn) < 1000)} count allUnits) < 1)
		||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _posSpawn) < 1500)} count allUnits) < 1)
		||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1)
				 ) 			};
		_group = createGroup BTC_enemy_side1;
		_veh = createVehicle [_vehType, _posSpawn, [], 0, "FLY"]; _veh flyInHeight 60;
		BTC_enemy_pilot createUnit [_posSpawn, _group, "this moveinDriver _veh"];
		private["_gunner","_cargo","_vehicle_type","_skill"];
		_gunner = _veh emptyPositions "gunner";
		if (_gunner > 0) then {BTC_enemy_pilot createUnit [_posSpawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];};
		_skill = {_x setSkill ["aimingAccuracy", BTC_AI_skill /2];} foreach units _group;	
		_skill = {_x setSkill ["aimingShake", BTC_AI_skill /2];} foreach units _group; 
		_skill = {_x setSkill ["spotDistance", BTC_AI_skill /2];} foreach units _group;
		if (BTC_debug == 1) then {player sideChat "PATROL AIR REINFORCEMENT SPAWNED";};
		_cargo = (_veh emptyPositions "cargo") - 1;
		_drv = driver _veh;
		if (BTC_track) then {_track = [leader _drv] execVM "scripts\BTC_track_unit.sqf";};
		_rndPos = [_posCity, 0, 300, 0, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_spw = [_drv,_rndPos,200] spawn BTC_give_waypoint;
		//while {(Alive _drv)&&(canMove Vehicle _drv)}

			waitUntil //heli reach area
			{sleep 1; (getPos _drv distance _rndPos < 300)&&(Alive _drv)&&(canMove Vehicle _drv)};
			
			//Send Chopper away or patrol city
			if (_vehType == BTC_enemy_heli select ((count BTC_enemy_heli) - 1))
			then {_spw = [_drv,[0,0,0],500] spawn BTC_give_waypoint;}
			else {_nul = [GROUP (Driver _veh), getPos _veh, 300] call bis_fnc_taskpatrol;};
			sleep 2;
			/////////////////////
			// Spawn para trooper
			if (BTC_debug == 1) then {Titletext ["**** PATROL AIR EJECT CARGO ****","plain down",0];};
			if (BTC_debug == 1) then {diag_log text format ["**** PATROL AIR EJECT CARGO ****"];};
			private ["_group_crg","_para","_pos","_dir","_parapos","_chutepos","_chute"];
			
			_group_crg = createGroup BTC_enemy_side1;
			if (_cargo > 8) then {_cargo = 8; };
			for "_i" from 0 to (_cargo) do
			{
				_para = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
				_pos = getPosATL _veh;
				_dir = getDir _veh;
				_dist = 10;
				_parapos  = [(_pos select 0)-(_dist)*sin(_dir),(_pos select 1)-(_dist)*cos(_dir),(_pos select 2)-5];
				_chutepos = [(_pos select 0)-(_dist)*sin(_dir),(_pos select 1)-(_dist)*cos(_dir),(_pos select 2)-5];
				_chute = "Steerable_Parachute_F" createVehicle [0,0,0]; 
				_chute setPos _chutepos; 
				_unit = _para createUnit [_parapos, _group_crg, "removeBackPack this; this moveIndriver _chute;"];
				sleep 0.5 + random 0.5;
			};
			_skill = {_x setSkill ["aimingAccuracy", BTC_AI_skill /2];} foreach units _group_crg;	
			_skill = {_x setSkill ["aimingShake", BTC_AI_skill /2];} foreach units _group_crg; 
			_skill = {_x setSkill ["spotDistance", BTC_AI_skill /2];} foreach units _group_crg;
			_skill = {_x setSkill ["courage", 1];} foreach units _group_crg;
			_skill = {_x setSkill ["endurance", 1];} foreach units _group_crg;
			{if (BTC_track) then {_track = [_x] execVM "scripts\BTC_track_unit.sqf";};} foreach units _group_crg;
			_leader = leader _group_crg;
			
			///Get nearest vehicle player and send para squad to them
			_array = [];
			_list = (position _leader) nearEntities ["Man", 1000];
			{if (side _x == BTC_friendly_side1) then {_array = _array + [_x];};} foreach _list;
			_count = count _array;
			if (BTC_debug == 1) then {diag_log text format ["** PATROL AIR ** %1",_list];};

			{_x domove getPos (_array select (floor(random _count)));} foreach units _group_crg;
			if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos getPos (vehicle (_array select 0));};
			if ((BTC_debug == 1)&&(_vehType == BTC_enemy_heli select ((count BTC_enemy_heli) - 1))) then {Titletext ["** PARATROOPER MOVE TO PLAYER POS **","plain down",0]; PLAYER sideChat "** PARATROOPER MOVE TO PLAYER POS **";};
		
			while {(Alive _leader)}
			do 
			{
				_list = (position _leader) nearEntities ["Man", 1000];
				{if (side _x == BTC_friendly_side1) then {_array = _array + [_x];};} foreach _list;
				
				_count = (count _array) - 1;
				{_x domove getPos (_array select (floor(random _count)));} foreach units _group_crg;
				if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos getPos (vehicle player);};
				sleep 120;
				if ((BTC_debug == 1)&&(_vehType == BTC_enemy_heli select ((count BTC_enemy_heli) - 1))) then {Titletext ["** PARATROOPER MOVE TO PLAYER POS **","plain down",0]; PLAYER sideChat "** PARATROOPER MOVE TO PLAYER POS **";};
		
				if (({((_x == vehicle player) || (isPlayer _x)) && ((_x distance getPos _leader) < 2000)} count allUnits) < 1)
				exitWith { {deleteVehicle _x} foreach units _group_crg; if (BTC_debug == 1) then {diag_log text format ["PARATROOPER GROUP WAS DELETED","plain down",0];};};
				
				if ((getpos _drv distance [0,0,0] < 1000)||(getpos _drv distance _posCity > 3000)||
				((({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1)
				&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1)
				&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1) )
				 ) then {{deleteVehicle _x;} forEach crew _veh; deleteVehicle _veh;};
			};

			waituntil 
			{sleep 3; 
			((getpos _drv distance [0,0,0] < 1000)||(getpos _drv distance _posCity > 3000)||
			((({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1) )
			 )
			}; 
			if (Alive _veh) then {{deleteVehicle _x;} forEach crew _veh; deleteVehicle _veh;};
};	
	
	
	
	
	
	