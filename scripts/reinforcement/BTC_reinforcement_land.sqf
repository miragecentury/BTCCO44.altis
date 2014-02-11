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
	
	//Lv 1: (1 x paradrop 8 soldati) || (1 camion con truppe 8 soldati)
	//_name = TRACK_Instances; TRACK_Instances = TRACK_Instances + 1; 	_veh_name 	= "BTC_REINF_HELI_" + str _name;
	
	waitUntil {sleep 1; ( 
	  (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _posSpawn) < 1000)} count allUnits) < 1)
	||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _posSpawn) < 1500)} count allUnits) < 1)
	||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _posSpawn) < 3000)} count allUnits) < 1)
			 ) 			};
	_group = createGroup BTC_enemy_side1;
	if (_vehType == "")	then {_vehType = BTC_enemy_veh select ((count BTC_enemy_veh) - 1);} else {_vehType = _this select 2;};
	
	_veh = createVehicle [_vehType, _posSpawn, [], 0, "NONE"];
	_veh AllowDamage false;
	private["_gunner","_commander","_veh","_cargo"];
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	if (BTC_debug == 1) then {diag_log text format ["::BTC_reinforcement:: ** PATROL LAND Type: %1 Cargo: %2** ",_vehType,_cargo];};
	If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_posSpawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Truck") then {BTC_enemy_TL createUnit [_posSpawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_posSpawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_posSpawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_posSpawn, _group, "this moveinDriver _veh"];};
	if (BTC_debug == 1) then {diag_log text format ["::BTC_reinforcement:: ** PATROL LAND HAVE DRIVER ** "];};
	if (_gunner > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_posSpawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_posSpawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_posSpawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_posSpawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];};
		if (BTC_debug == 1) then {diag_log text format ["::BTC_reinforcement:: ** PATROL LAND HAVE GUNNER ** "];};
	};
	if (_commander > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_posSpawn, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_posSpawn, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_posSpawn, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_posSpawn, _group, "this moveinCommander _veh"];};
		if (BTC_debug == 1) then {diag_log text format ["::BTC_reinforcement:: ** PATROL LAND HAVE COMMANDER ** "];};
	};
	_skill = {_x setSkill ["aimingAccuracy", BTC_AI_skill /2];} foreach units _group;	
	_skill = {_x setSkill ["aimingShake", BTC_AI_skill /2];} foreach units _group; 
	_skill = {_x setSkill ["spotDistance", BTC_AI_skill /2];} foreach units _group;
	if (BTC_debug == 1) then {player sideChat "PATROL LAND REINFORCEMENT SPAWNED";};
	
	_drv = driver _veh;
	if (BTC_track) then {_track = [leader _drv] execVM "scripts\BTC_track_unit.sqf";};
	
	_spw = [_drv,_posCity, 200 +(random 150)] spawn BTC_give_waypoint;
	
	private ["_group_crg","_veh_type","_leader","_skill"];
	_group_crg = createGroup BTC_enemy_side1;
	if (BTC_difficulty < 1) then {_cargo = 8; };
	if (_cargo > 0) then
	{
		for "_i" from 0 to (_cargo - 1) do
		{
			_veh_type = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
			_veh_type createUnit [_posSpawn, _group_crg, "this assignAsCargo _veh; this moveinCargo _veh;"];	
		};
		_skill = {_x setSkill ["aimingAccuracy", BTC_AI_skill /2];} foreach units _group_crg;	
		_skill = {_x setSkill ["aimingShake", BTC_AI_skill /2];} foreach units _group_crg; 
		_skill = {_x setSkill ["spotDistance", BTC_AI_skill /2];} foreach units _group_crg;
		_skill = {_x setSkill ["courage", 1];} foreach units _group_crg;
		_skill = {_x setSkill ["endurance", 1];} foreach units _group_crg;
	};

	_leader = leader _group_crg;
	waitUntil 
	{sleep 1;
	((getPos _drv distance _posCity < 1000)&&(Alive _drv)&&(canMove Vehicle _drv)||
	(({((isPlayer _x)||(side _x == BTC_friendly_side1))&&((_x distance getPos _veh)<1000)} count allUnits)> 0))
	};
	_veh AllowDamage true;
	
	waitUntil {sleep 1;(getPos _drv distance _posCity < 400)&&(Alive _drv)&&(canMove Vehicle _drv)};
	
	waitUntil {sleep 2; (speed _veh == 0)||(!Alive _drv)};
	if (BTC_debug == 1) then {Titletext ["**** PATROL LAND EJECT CARGO ****","plain down",0];diag_log text format ["**** PATROL LAND EJECT CARGO ****"];};
	// Eject troop
	{if (BTC_track) then {_track = [_x] execVM "scripts\BTC_track_unit.sqf";};} foreach units _group_crg;
	{unassignvehicle _x} foreach units _group_crg; 
	{doGetOut _x} forEach units _group_crg;
	
	// Let vehicle patrol _patrol = [leader _group,_spwn_mrk,random 20, 0] execVM "scripts\BTC_UPS.sqf";
	if (_vehType == BTC_enemy_veh select ((count BTC_enemy_veh) - 1))
	then {_spw = [_drv,_posSpawn,100] spawn BTC_give_waypoint;}
	else {_patrol = [leader _group_crg, BTC_position_mrk, 0, 0] execVM "scripts\BTC_UPS.sqf";};

	///Get nearest vehicle player and send para squad to them
	_array = [];
	_list = (position _leader) nearEntities ["Man", 500];
	{if (side _x == BTC_friendly_side1) then {_array = _array + [_x];};} foreach _list;

	if (BTC_debug == 1) then {diag_log text format ["** PATROL AIR ** %1",_list];};
	
	{_x domove getPos (_array select 0);} foreach units _group_crg;
	if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos getPos (vehicle (_array select 0));};
	if (BTC_debug == 1) then {Titletext ["** INFANTRY MOVE TO PLAYER POS **","plain down",0]; PLAYER sideChat "** INFANTRY MOVE TO PLAYER POS **";};
	while {(Alive _leader)}
	do 
	{
		{_x domove getPos (_array select 0);} foreach units _group_crg;
		if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos getPos (vehicle player);};
		sleep 120;
		if (BTC_debug == 1) then {Titletext ["** INFANTRY MOVE TO PLAYER POS **","plain down",0]; PLAYER sideChat "** INFANTRY MOVE TO PLAYER POS **";};
		
		if (({((_x == vehicle player) || (isPlayer _x)) && ((_x distance getPos _leader) < 2000)} count allUnits) < 1)
		exitWith { {deleteVehicle _x} foreach units _group_crg; if (BTC_debug == 1) then {diag_log text format ["INFANTRY GROUP WAS DELETED","plain down",0];};};
		
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
	
	
	
	
	
	