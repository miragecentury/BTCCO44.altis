///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};
waitUntil {sleep 1;(init_server_done)};
if ((isServer)&&((BTC_patrols_fob == 1))) then 
{
	
_outpost_area = _this select 0;	
_rad_ptr = 25;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////// Infantry OUTPOST WEST  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// FOB North WEST

	while {(BTC_patrols_fob == 1)} do 
	{
		//BTC_PTR_inf
		// B_medic_F, B_soldier_AA_F, B_soldier_AT_F, B_soldier_AR_F, B_Soldier_SL_F
		private["_rad","_pos","_unit","_group","_myunit","_house","_pos_H","_units"];
		_rad = 0;
		waitUntil 
		{sleep 2;
		( (({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getmarkerPos _outpost_area)) < 800)} count allUnits) > 0)
		||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getmarkerPos _outpost_area)) < 1000)} count allUnits) > 0)
		||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Helicopter") && ((_x distance (getmarkerPos _outpost_area)) < 1500)} count allUnits) > 0) 
		||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Plane") && ((_x distance (getmarkerPos _outpost_area)) < 10)} count allUnits) > 0) 
		) };
		if (BTC_debug == 1) then {player sideChat format["PATROL_FOB.SQF, PATROL %1 SPAWN", _outpost_area];};
		
		// Create soldier
		for "_i" from 0 to 4 do
		{
			_pos = markerPos _outpost_area;
			_unit = BTC_friendly_outpost select (round (random ((count BTC_friendly_outpost) - 1)));
			_group = createGroup BTC_friendly_side1;
			_group createUnit [_unit, _pos, [], _rad_ptr, "NONE"];
			_myunit = leader _group; 
			if (BTC_track) then {_spawn = [_myunit] execVM "scripts\BTC_track_unit.sqf";};
			_group setFormDir _rad;
			sleep 0.1;
			_rad = _rad + 90;
		};
		
		//Create Tower sentry
		_Towers = nearestObjects [_pos, ["Cargo_HQ_base_F","Cargo_Patrol_base_F","Cargo_Tower_base_F"], 100];
		//if (BTC_debug == 1) then {diag_log text (format["PATROL_FOB.SQF, Towers: %1", _Towers]);};	
		{
			//Sentry
			_pos_H = 0;
			while { format ["%1", _x buildingPos _pos_H] != "[0,0,0]" } do {_pos_H = _pos_H + 1};
			_pos_H = _pos_H - 1;
			if (_pos_H > 0)
			then 
			{
				_group = createGroup BTC_friendly_side1;
				_sentry = _group createUnit [BTC_friendly_outpost select (round (random ((count BTC_friendly_outpost) - 1))), _pos, [], 0, "this setFormDir (random 359)"];
				_sentry2 = _group createUnit [BTC_friendly_outpost select (round (random ((count BTC_friendly_outpost) - 1))), _pos, [], 0, "this setFormDir (random 359)"];
				if (BTC_track) then { {[_x] execVM "scripts\BTC_track_unit.sqf";}forEach [_sentry, _sentry2];};
				_sentry setpos (_x buildingpos (_pos_H));
				_sentry2 setpos (_x buildingpos (_pos_H - 1));
			};
		} forEach _Towers;
			
		_FobMans = count (nearestObjects [(GetMarkerPos _outpost_area), ["Man"], 50]);
		
		// Delete patrol if Player or enemies are far
		//waitUntil {sleep 3; (({(isPlayer _x)  && ((_x distance (MarkerPos _outpost_area)) < 500)} count allUnits) < 1) };
		waitUntil 
		{sleep 2;
		( (({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getmarkerPos _outpost_area)) < 800)} count allUnits) > 0)
		&&(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getmarkerPos _outpost_area)) < 1000)} count allUnits) > 0)
		&&(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Helicopter") && ((_x distance (getmarkerPos _outpost_area)) < 1500)} count allUnits) > 0) 
		&&(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Plane") && ((_x distance (getmarkerPos _outpost_area)) < 10)} count allUnits) > 0) 
		) };
		
		_units = []; // all BTC_friendly_side1 units within Xm 
		{
		  if (((side _x == BTC_friendly_side1) OR (side _x == BTC_friendly_side2)) && (_x distance (MarkerPos _outpost_area)) < 500) 
		  then {_units = _units + [_x];};
		} forEach allUnits; 
		{deleteVehicle _x} forEach _units;	
		
		//if (BTC_debug == 1) then {player sideChat format["PATROL_FOB.SQF, PATROL %1 DELETED", _outpost_area];};			
		sleep 0.1;
	}; // Fine parentesi while do

};
