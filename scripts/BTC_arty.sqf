///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil {!isnil "bis_fnc_init"};
waitUntil {sleep 1;(init_server_done)};
if (BTC_arty > 0) then {
// null=[ammo,position,height,velocity,rounds,spread] execVM "scripts\BTC_arty.sqf";
//"Sh_82mm_AMOS","Sh_155mm_AMOS","Sh_120mm_HE","Smoke_120mm_AMOS_White","Smoke_82mm_AMOS_White","R_60mm_HE","R_80mm_HE","R_230mm_HE"

// null=["Sh_82mm_AMOS",[],2,200,gunner,5,60] execVM "scripts\BTC_arty.sqf";

_ammo    = _this select 0;// ammunition
_target  = _this select 1;// target position Array
_nBomb   = _this select 2;// number of bombs
_spread  = _this select 3;// radius of bombing
_gunner	 = _this select 4;// mortar operator
_maxRof  = _this select 5;// rate of fire beetwen salvo
_sleep   = _this select 6;// sleeping time beetwen gunner fire again
_spottedArray = [];
_target = [];
_targetA = [];
_maxDist = 3000;
_rof = 3 + _maxRof;
if !(isNil ("_sleep")) then { if (_sleep < 30) then {_sleep = 30;} else {_sleep = _this select 6;}; };
if (count _this < 6) exitWith {diag_log "::BTC_ARTY:: ERROR count imput field."; };
if (_nBomb == 0) exitWith {diag_log "::BTC_ARTY:: ERROR bomb number must best more than 0.";};
if !(_gunner iskindOf "Man") exitWith {diag_log "::BTC_ARTY:: ERROR gunner imput missing.";};

_grp = Group _gunner;
_grp setCombatMode "BLUE";
_mortar = vehicle _gunner;
_fired  = false;

if ( (count _target > 2) )
then 
{
	_grp setCombatMode "RED";
	if (((_target) distance (position _gunner) < _maxDist)
	&& ((_target) distance (position _gunner) > 100))
	then
	{
		//Colpi coordinate conosciute
		_xx = _target select 0;
		_yy = _target select 1;
		_zz = _target select 2;
		for [{_i = 0},{_i < _nBomb},{_i = _i + 1}] do
		{
			sleep (random _rof);
			_grp commandArtilleryFire [[_xx + (_spread - (random (_spread *2))) , _yy + (_spread - (random (_spread *2))), _zz], _ammo, 1];
			diag_log text format ["BTC_ARTY.SQF, ARTILLERY DO FIRE"];
			Player sideChat format ["BTC_ARTY.SQF, ARTILLERY DO FIRE"];
			_mortar setVehicleAmmo 1;
		};
		if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, Fire on coordinate execute!"];
		player sideChat format ["BTC_ARTY.SQF, Fire on coordinate execute!"];};
		_grp setCombatMode "BLUE";
	};
} 
else
{
	while {(Alive _gunner)&&(Alive vehicle _gunner)} do
	{
		//**************//**************//**************
		//**************//**************//**************
		//Search for targets
		_Elist = nearestObjects [_gunner,["CAManBase"], 100];
		if !(isNil ("_Elist"))then 
		{
			_myNearestEnemy = [];
			{_myNearestEnemy = _myNearestEnemy + [_x nearTargets _maxDist];} foreach _Elist;
			
			if (BTC_debug == 1) then 
			{
				diag_log text format ["BTC_ARTY.SQF, ARRAY _Elist: %1" , _Elist];
				diag_log text format ["BTC_ARTY.SQF, ARRAY _myNearestEnemy: %1" , _myNearestEnemy];
			};
		
					_spotted = objNull;
					_spottedPos = [];
					_spottedArray = [];
					_spottedPosA = [];
					{
						if (
						(((_x select 0) select 2) == BTC_friendly_side1)&& 
						!(_fired)) 
						then 
						{
						  _spotted = _x select 4;
						  _spottedPos = _x select 0;
						  _spottedArray = _spottedArray + [_spotted];
						  _spottedPosA = _spottedPosA + [_spottedPos];
						};
					} forEach _myNearestEnemy;

					if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, FINAL ARRAY _spottedArray: %1" , _spottedArray];};
					if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, FINAL ARRAY _spottedPosA: %1" , _spottedPosA];};
		};
		//**************//**************//**************
		//**************//**************//**************
		/*
		Output comando "nearTargets";
			[
				[15767.3,18294.5,1.22627],
				"B_helicrew_F",
				WEST,
				1.00381e+007,
				B JULIET:3,
				0.221653
			]
		*/
		_fired = false;
		
		if (count _spottedPosA > 0) then
		{
			_target = ((_spottedPosA select 0) select 4); //nemico del mortaio, player
			if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, _target: %1" ,_target];};
			_array = [];
			//for [{_i = 0},{_i < count _spottedArray},{_i = _i + 1}] do
			{		
				_eneKnow = _x knowsAbout _target;
				_array 	 = _array + [_eneKnow]; //ARRAY of knowsAbout of other soldiers
			} foreach _Elist;
			_knowAb = _gunner knowsAbout _target; //Check if gunner knowsAbout
			if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, FINAL _EkownE: %1" ,_knowAb];};
			if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, ARRAY VALUES _eneKnow: %1" ,_array];};
			// Valore più alto knowsAbout su player
			_EkownE = [_array] call BIS_fnc_greatestNum;
			if (BTC_debug == 1) then {diag_log text format ["BTC_ARTY.SQF, _EkownE: %1" ,_EkownE];};
			if (_EkownE > _knowAb) then {_knowAb = _EkownE;} else {_knowAb = _knowAb; };
			

			if (((position _target) distance (position _gunner) < _maxDist)&&
				((position _target) distance (position _gunner) > 100)&&
				((getPosAtl _target) select 2 < 30) ) 
			then
			{
		
				if (_knowAb > 1) then 
				{
					_grp setCombatMode "RED";
					_xx = _target select 0;
					_yy = _target select 1;
					_zz = _target select 2;
					//_spread = _spread / _knowAb;
					for [{_i = 0},{_i < _nBomb},{_i = _i + 1}] do
					{
						sleep (random _rof) + 1;
						_grp commandArtilleryFire [[_xx + (_spread - (random (_spread *2))) , _yy + (_spread - (random (_spread *2))), _zz], _ammo, 1];
						diag_log text format ["BTC_ARTY.SQF, ARTILLERY DO FIRE"];
						Player sideChat format ["BTC_ARTY.SQF, ARTILLERY DO FIRE"];
					};
				}else{_knowAb = 0; _grp setCombatMode "BLUE";};
				(vehicle _gunner) setVehicleAmmo 1;
			};
		};
		
		_grp setCombatMode "BLUE";
		sleep _sleep;
	};
	
 };
 
 };
 
 
 
 
 
 
 