///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil {!isnil "bis_fnc_init"};
waitUntil {sleep 3;(init_server_done)};
if ((isServer)&&(BTC_civ_city == 1)) then 
{

	//if (BTC_debug == 1) then {diag_log text format ["::PATROL_CIV.SQF::, SCRIPT START"];};
		
		private["_city_area","_size_area","_group","_unit","_myunit"];
		_city_area = _this select 0;
		if (typename _city_area != "STRING") exitWith {diag_log text format ["::PATROL_CIV:: ERROR, VALUE MUST BE A STRING"];};
		_size_area = (getmarkerSize _city_area) select 0;
		//if (BTC_debug == 1) then {diag_log text format["PATROL_CIV.SQF, CIVILIAN _city_area = %1", _city_area];};
		//trigger_del_civilian setPos (getmarkerPos _city_area);
				
		while {(true)} do 
		{
			//if (BTC_debug == 1) then {diag_log text format ["::PATROL_CIV.SQF::, SCRIPT WAIT FOR PLAYER NEAR CITY"];};
			waitUntil 
			{sleep 2;
			( (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getmarkerPos _city_area)) < _size_area + 800)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getmarkerPos _city_area)) < _size_area + 800)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Helicopter") && ((_x distance (getmarkerPos _city_area)) < _size_area + 800)} count allUnits) > 0) 
			||(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Plane") && ((_x distance (getmarkerPos _city_area)) < 10)} count allUnits) > 0) 
			) };
			
			//if (BTC_debug == 1) then {_city_area setmarkeralpha 1;};
			_cond = round ((count (nearestObjects [markerPos _city_area, ["House"], _size_area])) / 10) -1;
			if (_cond < 3) then {_cond = 3;};
			if (_cond > 10) then {_cond = 10;};
			//if (BTC_debug == 1) then {diag_log text format["PATROL_CIV.SQF, CITY: %1 SIZE: %2m, CIVILIAN TOT: %3", _city_area, _size_area, _cond];};
			
			// Spawn CIVILIAN
			for "_i" from 0 to (_cond) do 
			{
				_unit = BTC_civilian select (round (random ((count BTC_civilian) - 1)));
				_group = createGroup CIVILIAN;
				_group createUnit [_unit, (getmarkerPos _city_area), [], _size_area, "NONE"];
				_myunit = leader _group; 
				_myunit setSkill 0;
				if (BTC_track) then {_spawn = [_myunit] execVM "scripts\BTC_track_unit.sqf";};
				_myunit addEventHandler ["FiredNear", {[_this select 0] execVM "scripts\patrol\patrols_CivPanic.sqf";}];

				//Waypoint types
				_rnd = 0;
				_rnd = round (Random 1) + 1;
				if (_rnd == 1) then //civilian patrol house
				{
					private["_no_building","_attempt","_house","_mrk_pos_H"];
					_str_dist= 100;
					_house = nearestbuilding _myunit;
					_mrk_pos_H = 0; 
					while { format ["%1", _house buildingPos _mrk_pos_H] != "[0,0,0]" } 
					do {_mrk_pos_H = _mrk_pos_H + 1}; _mrk_pos_H = (_mrk_pos_H - 1);
					
					if (_mrk_pos_H > 0) then
					{
						//_myunit doMove ( _house buildingpos (random ( floor (_mrk_pos_H / 2)) + ( floor (_mrk_pos_H / 2))) ); 
						_myunit doMove ( _house buildingpos _mrk_pos_H ); 
						_guard = [_myunit,"SAFE",20] execVM "scripts\patrol\patrols_House.sqf";
						//if (BTC_debug == 1) then {diag_log text format ["PATROL_CIV.SQF, Civilian will patrol house"];};
					};

				}
				else //civilian patrol city
				{
					_patrol = [_myunit,_city_area, 30, 0] execVM "scripts\BTC_UPS.sqf"; 
					//if (BTC_debug == 1) then {diag_log text format ["PATROL_CIV.SQF, Civilian will patrol city"];};
				};
			};
			
			// Spawn cars
			_list = [];
			for "_i" from 0 to (round ((_cond) /4)) do
			{
				_veh_type = BTC_civ_veh select (round (random ((count BTC_civ_veh) - 1)));
				_pos = [(getmarkerPos _city_area), _size_area /2, _size_area, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
				_list = _pos nearRoads 5;
				_attempt = 0;
				while {((count _list) > 0)&&(_attempt < 10)}
				do {_pos = [(getmarkerPos _city_area), _size_area /2, _size_area, 5, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos; _list = _pos nearRoads 5; _attempt = _attempt + 1; sleep 0.1;};
				_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"];
				if (BTC_track) then {_spawn = [_veh] execVM "scripts\BTC_track_unit.sqf";};
				if (_veh distance (markerPos _city_area) > _size_area *1.5) then {deleteVehicle _veh;};
				sleep 0.1;
			};
			
			//***//***//***//***//***
			_city_area setmarkeralpha 0;
			//if (BTC_debug == 1) then {diag_log text format ["PATROL_CIV.SQF, Civilian waiting to be deleted..."];};
			waitUntil
			{sleep 2;
			( (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getmarkerPos _city_area)) < _size_area + 800)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getmarkerPos _city_area)) < _size_area + 800)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance (getmarkerPos _city_area)) < _size_area + 800)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Plane") && ((_x distance (getmarkerPos _city_area)) < 10)} count allUnits) < 1)
			) };
			
			_civ_pop = [];
			_civ_pop = nearestObjects [(getmarkerPos _city_area), ["MenCIV","Civilian","Animal","Car"], _size_area *2];
			_civ_type = [];
			{_civ_type = _civ_type + [typeOf _x]} foreach _civ_pop;
			
			//if (BTC_debug == 1) then {diag_log text format["PATROL_CIV.SQF, CIVILIAN POPULATION BEFORE DELETE: %1", _civ_pop];};
			//if (BTC_debug == 1) then {diag_log text format["PATROL_CIV.SQF, CIVILIAN POPULATION TYPE: %1", _civ_type];};
			
			{if (alive _x) then {deleteVehicle _x;}; } foreach _civ_pop;
	
			while {((count _civ_pop) > 0)} do 
			{
				{
					if ((_x isKindOf "MenCIV")||(_x isKindOf "Civilian")||(_x isKindOf "Animal")) 
					then {{deleteVehicle _x} foreach units _x; deleteVehicle _x;  }; 
					if (isNull driver vehicle _x) then { deleteVehicle _x; };
				} foreach _civ_pop;	
				
				sleep 1;
				_civ_pop = nearestObjects [(getmarkerPos _city_area), ["MenCIV","Civilian","Animal","Car"], _size_area *1.5];
				//if (BTC_debug == 1) then {diag_log text format["PATROL_CIV.SQF, CIVILIAN POPULATION AFTER DELETE: %1", _civ_pop];};
				//trg_civ_del = true; publicVariableServer "trg_civ_del"
			};

			sleep 1; // Time before respawn again
		}; // Fine 

////if (BTC_debug == 1) then {diag_log text format ["PATROL_INF.SQF, SCRIPT END"];};
};///////////






