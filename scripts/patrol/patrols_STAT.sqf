///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil {!isnil "bis_fnc_init"};
waitUntil {sleep 1;(init_server_done)};
if ((isServer)&&((BTC_stc_city == 1))) then 
{

	private ["_city_area","_size_area","_area"];
	_city_area = _this select 0;
	if (typename _city_area != "STRING") exitWith {diag_log text format ["::PATROL_STAT:: ERROR, VALUE MUST BE A STRING"];};
	if (BTC_debug == 1) then {diag_log text format [""];};
	if (BTC_debug == 1) then {diag_log text format ["::PATROL_STAT:: CITY MARKER: '%1'",_city_area];};
	if (BTC_debug == 1) then {diag_log text format [""];};
	_size_area = (getmarkerSize _city_area) select 0;
	_area = MarkerPos _city_area;
		
	_nn = 0;
	_nn2 = random 359;
	_xx = 0;
	for "_i" from 0 to BTC_val_diff do
	{
		_pos = [[(_area select 0)+(_size_area)*sin(_nn2),(_area select 1)+(_size_area)*cos(_nn2), 0], 0, 30, 3, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos;
		_attempt = 0;
		while {(_pos distance _area > (_size_area *2))}
		do {_pos = [[(_area select 0)+(_size_area)*sin(_nn2),(_area select 1)+(_size_area)*cos(_nn2), 0], 0, 30, 3, 0, 30*(pi / 180), 0] call BIS_fnc_findSafePos; 
		if (_attempt > 10) exitWith {}; 
		_attempt = _attempt + 1;};
		
		if (_pos distance _area < _size_area *2)
		then 
		{
			_static = BTC_enemy_static select (round (random ((count BTC_enemy_static) - 1)));
			_spw_sta = createVehicle [_static, _pos, [], 0, ""];
			_spw_sta setFormDir _nn2;
			_group = createGroup BTC_enemy_side1;
			_sentinel = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
			_sold = _group createUnit [_sentinel, getPos _spw_sta, [], 0, "none"];
			_sold moveinGunner _spw_sta; _sold assignAsGunner _spw_sta;
			_gunn = gunner _spw_sta;
			_gunn setFormDir _nn2;
			
			for "_i" from 0 to 3 do
			{
				_bagfence = createVehicle ["Land_BagFence_Long_F", [((_pos) select 0)+(2)*sin(_nn), ((_pos) select 1)+(2)*cos(_nn), 0], [], 0, "CAN_COLLIDE"]; 
				_bagfence setDir _nn;
				_nn = _nn + 90; 
				sleep 0.1;
			};
			if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
			_nn2 = _nn2 + 90;
			_xx = _xx + 1;
			sleep 0.1;
		};
	};

};///////////






