///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                  ///	
/// Visit us: www.blacktemplars.altervista.org  ///
/// scripts\reinforcement\BTC_reinforcement.sqf	///
///////////////////////////////////////////////////	

// Start ad inizio missione
if ((isServer)&&(BTC_reinforcements > 0)) then
{
	private ["_area","_size","_pos","_Manpos","_Manradius","_numEnemy","_Man","_xx"];

	sleep 1;
	_area = _this select 0;
	_size = _this select 1;
	_pos = [];
	switch (typeName _area) do
	{
		case "ARRAY" :{_pos = _area; 				};
		case "STRING":{_pos = getMarkerPos _area; 	};
		case "OBJECT":{_pos = position _area; 		};
	};

	_Manpos 	= _pos;
	_Manradius 	= _size;
	_numEnemy = 0; _numEnemyStart = 0;
	_Man = []; _xx = 0;
	BTC_send_reinfor = false;
	while {!(BTC_send_reinfor)} do
	{
		_Man = nearestObjects [_Manpos, ["Man"], _Manradius];
		if (count _Man > 0) then
		{
		  _numEnemy = {Alive _x && (side _x == BTC_enemy_side1)} count _Man; 
		  if (_xx == 0) then {_numEnemyStart = _numEnemy;};
		  if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: Quantity enemy mission start: %1",_numEnemy];};
		};
		sleep 10; // Aumentare dopo
		if (_numEnemy < (_numEnemyStart / 2)) then {BTC_send_reinfor = true;};
		_xx = _xx + 1;
	};

	waitUntil {sleep 1; (BTC_send_reinfor)};
	if (skip_var) exitWith {if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: Mission Skipped"];};};
	if (BTC_debug == 1) then {player sidechat format ["::BTC_reinforcement:: CALL REINFORCEMENT"]; diag_log format ["::BTC_reinforcement:: CALL REINFORCEMENT"];};
	
	//Crea rinforzo a 3 Km dai player e dalla zona
	_attempt = 0;
	_posLand = [_pos, 2000, 2100, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
	while 
	{
		(_posLand distance _pos > 2100)||(_posLand distance _pos < 1900)||(_posLand distance (getMarkerPos "base_flag") < 1900 )||
		((({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _posLand) < 1900)} count allUnits) > 0)||
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _posLand) < 1900)} count allUnits) > 0)||
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _posLand) < 1900)} count allUnits) > 0))
	}
	do {
		_posLand = [_pos, 2000, 2100, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos; sleep 0.1; 
		_attempt = _attempt + 1;
		if (_attempt > 100) exitWith {};
		};
	_xx = 300; _posRoad = _posLand nearRoads _xx;
	while {(count _posRoad < 1)}
	do {_xx = _xx + 100; _posRoad = _posLand nearRoads _xx;};
	if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: _posLand: %1",_posLand];};
	
	_attempt = 0;
	_posAir = [_pos, 3000, 3100, 5, 1, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
	while 
	{
		(_posAir distance _pos > 3100)&&(_posAir distance _pos < 2900)||(_posAir distance (getMarkerPos "base_flag") < 3000 )||
		((({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _posLand) < 3000)} count allUnits) > 0)||
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _posLand) < 3000)} count allUnits) > 0)||
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _posLand) < 3000)} count allUnits) > 0))
	}
	do {
		_posAir = [_pos, 3000, 3100, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos; sleep 0.1;
		_attempt = _attempt + 1;
		if (_attempt > 100) exitWith {};
		};
	if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: _posAir: %1",_posAir];};
	
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // 
	// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // 
	//Random rinforzo a seconda livello difficoltà: 2 x paradrop, 1 camion con truppe, 1 Gunship con paradrop, 1 tank leggero con truppe + jeep armata

	switch (BTC_difficulty) do
	{
		case 0 :{
					if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: Lv 1"];};
					//Lv 1: (1 x paradrop 8 soldati) || (1 camion con truppe 8 soldati
					_selectHeliTrans = (count BTC_enemy_heli) - 1; //heli transport
					_vehTypeHeliTrans = BTC_enemy_heli select _selectHeliTrans;
					_rnd = random 2;
					if (_rnd > 1) then {_nul = [_posRoad select 0, _pos,""] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";}
					else {_nul = [_posAir, _pos,_vehTypeHeliTrans] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf";};
				};
		
		//Lv 2: (2 x paradrop 8 soldati) || (1 camion con truppe 16 soldati) || (1 elicottero leggero ORCA con paradrop) || (1 tank leggero con truppe)
		case 3 :{
					if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: Lv 2"];};	
					_selectHeliTrans = (count BTC_enemy_heli) - 1; //heli transport
					_vehTypeHeliTrans = BTC_enemy_heli select _selectHeliTrans;
					_selectHeliTransArm = (count BTC_enemy_heli) - 2;	//heli transport armed
					_vehTypeHeliTransArm = BTC_enemy_heli select _selectHeliTransArm;
					_selectAPC = (count BTC_enemy_tracked) - 1; //APC
					_vehTypeAPC = BTC_enemy_tracked select _selectAPC;
					_rnd = round (random 3);
					switch (_rnd) do
					{
					case 0 :{ for "_i" from 0 to 1 do {_nul = [_posAir, _pos,_vehTypeHeliTrans] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf"; sleep 10;};};
					case 1 :{_nul = [_posRoad select 0, _pos,""] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};
					case 2 :{_nul = [_posAir, _pos, _vehTypeHeliTransArm] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf";};
					case 3 :{_nul = [_posRoad select 0, _pos, _vehTypeAPC] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};
					};
				};
		//Lv 3
		case 10:{
					if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: Lv 3"];};
					_rnd = round (random 4);
					_selectHeliTrans = (count BTC_enemy_heli) - 1; //heli transport
					_vehTypeHeliTrans = BTC_enemy_heli select _selectHeliTrans;
					_selectHeliTransArm = (count BTC_enemy_heli) - 2;	//heli transport armed
					_vehTypeHeliTransArm = BTC_enemy_heli select _selectHeliTransArm;
					_selectAPC = (count BTC_enemy_tracked) - 1; //APC
					_vehTypeAPC = BTC_enemy_tracked select _selectAPC;
					_vehTypeTank = BTC_enemy_tracked select 2; //tank
					_vehTypeJeep = BTC_enemy_veh select 0;	 //light armed vehicle
					switch (_rnd) do
					{
						//(3 x paradrop 8 soldati)
						case 0 :{for "_i" from 0 to 2 do {_nul = [_posAir, _pos,_vehTypeHeliTrans] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf"; sleep 5;};};
						//(2 camion con truppe 16 soldati)
						case 1 :{for "_i" from 0 to 1 do {_nul = [_posRoad select 0, _pos,""] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";sleep 5;};};
						//(elicottero Gunship con paradrop + jeep armata)
						case 2 :{_nul = [_posAir, _pos, _vehTypeHeliGunship] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf";
								 _nul = [_posRoad select 0, _pos, _vehTypeJeep] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};
						//(tank leggero con truppe + jeep armata)
						case 3 :{_nul = [_posRoad select 0, _pos, _vehTypeAPC] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";
								 _nul = [_posRoad select 0, _pos, _vehTypeJeep] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};
						//(tank con truppe + jeep armata)
						case 4 :{_nul = [_posRoad select 0, _pos, _vehTypeTank] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf"; sleep 10;
								 _nul = [_posRoad select 0, _pos, _vehTypeJeep] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";
								};
					};
				};
		
		//Lv 4: come Lv 3 x 2
		case 20:{	
					if (BTC_debug == 1) then {diag_log format ["::BTC_reinforcement:: Lv 4"];};
					
						_rnd = round (random 4);
						_vehTypeHeliTrans = BTC_enemy_heli select ((count BTC_enemy_heli) - 1); //heli transport
						_vehTypeHeliGunship = BTC_enemy_heli select ((count BTC_enemy_heli) - 3); //heli Gunship
						_vehTypeAPC = BTC_enemy_tracked select ((count BTC_enemy_tracked) - 1); //APC
						_vehTypeTank = BTC_enemy_tracked select 2; //tank
						_vehTypeJeep = BTC_enemy_veh select 0;	 //light armed vehicle
						switch (_rnd) do
						{
							//(3 x paradrop 8 soldati)
							case 0 :{for "_i" from 0 to 5 do {_nul = [_posAir, _pos,_vehTypeHeliTrans] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf"; sleep 5;};};
							//(3 camion con truppe 16 soldati)
							case 1 :{for "_i" from 0 to 2 do {_nul = [_posRoad select 0, _pos,""] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";sleep 5;};};
							//(2 elicottero Gunship con paradrop + jeep armata)
							case 2 :{for "_i" from 0 to 1 do {_nul = [_posAir, _pos, _vehTypeHeliGunship] execVM "scripts\reinforcement\BTC_reinforcement_air.sqf";sleep 5;
									 _nul = [_posRoad select 0, _pos, _vehTypeJeep] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};};
							//(2 tank leggero con truppe + jeep armata)
							case 3 :{for "_i" from 0 to 1 do {_nul = [_posRoad select 0, _pos, _vehTypeAPC] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";sleep 5;
									 _nul = [_posRoad select 0, _pos, _vehTypeJeep] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};};
							//(2 tank con truppe + jeep armata)
							case 4 :{for "_i" from 0 to 1 do {_nul = [_posRoad select 0, _pos, _vehTypeTank] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf"; sleep 5;
									 _nul = [_posRoad select 0, _pos, _vehTypeJeep] execVM "scripts\reinforcement\BTC_reinforcement_land.sqf";};};
						};
					
				};
		
	};






};	
	
	
	
	
	
	