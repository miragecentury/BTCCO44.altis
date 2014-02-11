///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////
// scripts\BTC_para_drop.sqf
	
private ["_driver","_cargo","_Number1","_Number2"];
_driver  = _this select 0;
_vehicle = _this select 1;
_cargo   = _this select 2;
if (BTC_debug == 1) then {diag_log text format ["::BTC_PARADROP:: CARGO SEAT: %1", _cargo];};
/// PARA DROP
	If (_vehicle isKindOf "Air") then
	{
		if !(isServer) exitWith {};
		_BTCM_Para_condition = false; 
		waitUntil {sleep 2; ( (({((_x == vehicle player) || (isPlayer _x)) && ((_x distance GetPos _driver) < 400)} count allUnits) > 0) OR (!Alive Driver _driver) OR (((Damage _driver)> 0.5)&&((Damage _driver)< 0.9)) OR (!CanMove _driver) )};
		while {(Alive _driver)&&(canMove _vehicle)&&(! _BTCM_Para_condition)} do 
		{
			_Number1 = Driver _vehicle knowsAbout (vehicle player);
			_Number2 = Gunner _vehicle knowsAbout (vehicle player);
			waitUntil {sleep 1;  (({((_x == vehicle player) || (isPlayer _x)) && ((_x distance GetPos _vehicle) < 999)} count allUnits) > 0)};
			if (((_Number1 > 1.5)||(_Number2 > 1.5))&&(getPosATL _vehicle select 2 > 60)) then {_BTCM_Para_condition = true;} else {_BTCM_Para_condition = false;publicVariableServer "_BTCM_Para_condition";};
			if ((_Number1 > 1.5)||(_Number2 > 1.5)) then {if (BTC_debug == 1) then {Titletext ["* PATROL AIR KNOW ABOUT PLAYER *","plain down",0];};};
			sleep 1;
			if (_BTCM_Para_condition) exitWith {};
		};
		waitUntil {sleep 1; 
		(_BTCM_Para_condition)&&
		(({( !(vehicle _x iskindOf "Air") && (isPlayer _x) ) && (side _x == BTC_friendly_side1) && ((_x distance GetPos _vehicle) < 500)} count allUnits) > 0)&&
		(getPosATL _vehicle select 2 > 60)&&(getPosASL _vehicle select 2 > 60)};

		/////////////////////
		// Spawn para trooper
		if (BTC_debug == 1) then {Titletext ["::BTC_PARADROP:: **** PATROL AIR EJECT CARGO ****","plain down",0];};
		if (BTC_debug == 1) then {diag_log text format ["::BTC_PARADROP:: **** PATROL AIR EJECT CARGO ****"];};
		private ["_group_crg","_para","_pos","_dir","_dist","_parapos","_chutepos","_chute"];
		
		_group_crg = createGroup BTC_enemy_side1;
		if (_cargo > 8) then {_cargo = 8; };
		for "_i" from 0 to (_cargo) do
		{
			_para = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
			_pos = getPosATL _vehicle;
			_dir = getDir _vehicle;
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
		
		private ["_array","_list","_count","_nearest","_nearestdist","_dist"];
		///Get nearest vehicle player and send para squad to them
			_array = [];
			_list = (position leader _group_crg) nearEntities ["Man", 600];
			{if (side _x == BTC_friendly_side1) then {_array = _array + [_x];};} foreach _list;
			_count = count _array;
			if (BTC_debug == 1) then {diag_log text format ["::BTC_PARADROP:: ** PATROL AIR ** %1",_list];};
			{_x domove getPos (_array select (floor(random _count)));} foreach units _group_crg;
			if (BTC_debug == 1) then {"::BTC_PARADROP:: debug_mrk_1" setMarkerPos getPos (vehicle (_array select 0));};
			if (BTC_debug == 1) then {Titletext ["::BTC_PARADROP:: ** PARATROOPER MOVE TO PLAYER POS **","plain down",0]; 
			PLAYER sideChat "::BTC_PARADROP:: ** PARATROOPER MOVE TO PLAYER POS **";};

			while {(Alive leader _group_crg)}
			do 
			{
				_list = (position leader _group_crg) nearEntities ["Man", 600];
				{if (side _x == BTC_friendly_side1) then {_array = _array + [_x];};} foreach _list;
				_count = (count _array) - 1;
				if (_count > 0)then{{_x domove getPos (_array select (floor(random _count)));} foreach units _group_crg;};
				if (BTC_debug == 1) then {"debug_mrk_1" setMarkerPos getPos (vehicle player);};
				sleep 120;
				if (BTC_debug == 1) then {Titletext ["** PARATROOPER MOVE TO PLAYER POS **","plain down",0]; PLAYER sideChat "** PARATROOPER MOVE TO PLAYER POS **";};
				
				if (({((_x == vehicle player) || (isPlayer _x)) && ((_x distance getPos leader _group_crg) < 1500)} count allUnits) < 1)
				exitWith { {deleteVehicle _x} foreach units _group_crg; if (BTC_debug == 1) then {diag_log text format ["PARATROOPER GROUP WAS DELETED","plain down",0];};};
				
			};
			
	};
	
	
	
	
	
	
	
	
	
