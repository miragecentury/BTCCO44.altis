/*
*****************************************************************************************
///////////////////////////////////////////////////
/// ® August 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

* Mettere questo su attivazione trigger:
  Example: [this,"COMBAT", 150] execVM "Patrol_House.sqf"; 
  Example: {[_x,"COMBAT", 150] execVM "Patrol_House.sqf"} foreach Thislist; 

  Example: guard = [this,"COMBAT"] execVM "Patrol_House.sqf" 
  You may put any of these five:

    * "CARELESS"
    * "SAFE"
    * "AWARE"
    * "COMBAT"
    * "STEALTH". 
  
  Example: guard = [this,"SAFE",50] execVM "Patrol_House.sqf" 
  Example: {[_x,"COMBAT", 15] execVM "scripts\patrol\Patrol_House.sqf"} foreach Thislist; 

*****************************************************************************************
*/

sleep 0.5;
if (!isServer) exitWith {};

// Setting variables

	_unit 	= _this select 0;
	_beh 	= _this select 1;
	_wtime 	= _this select 2;
	if (count _this > 1) then {_beh = _this select 1;} else {_beh = "SAFE";};
	if (count _this > 2) then {_wtime = _this select 2;} else {_wtime = 30;};
	_unit setBehaviour _beh;
	_Vehiclepos 	= GetPos _unit;
	_Vehicleradius 	= 50;
	_numVehicle = 0;
	_buildings = [];
	_x = 0;	_y = 0;
	_buildings = nearestObjects [_Vehiclepos, ["Building"], _Vehicleradius];
   if (count _buildings > 0) then
   {
		_pos = (count _buildings) - 1;
		_house = _buildings select (round(random _pos));
		while { format ["%1", _house buildingPos _x] != "[0,0,0]" } do {_x = _x + 1};
		_x = _x - 1;
	
		if (_x > 1) then 
		{
			_unit doMove (_house buildingPos (round(random _x))); 

			while {alive _unit} do
			{
				// Waypoint dentro casa
				_y =  round(random _x);
				_unit doMove (_house buildingPos _y);
				sleep 10;
				if ((_unit knowsAbout (vehicle player) > 2)||(!alive _unit)) exitWith {};
				sleep _wtime;
				
				// Waypoint fuori casa
				_position = getPos _unit;
				_pos = [_position, 10, 30, 1, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
				if ((_pos distance _position) < 30) 
				then {_unit doMove _pos; waitUntil {sleep 3;(_unit distance _pos < 5)};}
				else 
				{
					_attempt = 0;
					while {((_pos distance _position) > 30)} do 
					{
						_pos = [_position, 10, 30, 1, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
						_attempt = _attempt + 1;
						if (_attempt > 10) exitwith {_y = round(random _x); _unit doMove (_house buildingPos _y);};
					};
					if ((_pos distance _position) < 30) then {_unit doMove _pos; waitUntil {sleep 3;(_unit distance _pos < 5)}; sleep _wtime;};
				};
			};

		};
	};
	
	
	
	
	
	
	
	
	
	