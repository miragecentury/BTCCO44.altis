///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

private ["_xx","_chose_mrk_rnd","_minDist","_maxDist","_size_area","_mrk_side_miss"];
_xx = 0;
_chose_mrk_rnd = true;
_minDist = 1500 + BTC_search_min;
_maxDist = 2000 + BTC_search_max;
_size_area = 1000;
while {(_chose_mrk_rnd)} do
{
	_mrk_side_miss = BTC_rnd_city_miss_array select _xx;
	if (BTC_debug == 1) then {diag_log (format["::SIDES PATROLS:: RANDOM CITY MARKER ARRAY = %1", _mrk_side_miss]);};
	if (
	(({(isPlayer _x) && ((_x distance (getMarkerPos _mrk_side_miss)) > _minDist)} count allUnits) > 0)&&
	(({(isPlayer _x) && ((_x distance (getMarkerPos _mrk_side_miss)) < _maxDist)} count allUnits) > 0) )
	then 
	{
	 _chose_mrk_rnd = false;
	 BTC_rnd_city_miss_array = BTC_rnd_city_miss_array - [BTC_rnd_city_miss_array select _xx];
	 BTC_position = markerPos _mrk_side_miss; //markerPos (BTC_rnd_city_miss_array select _xx);
	 BTC_position_mrk = _mrk_side_miss;
	 if (BTC_debug == 1) then { diag_log (format["::SIDES PATROLS:: RANDOM CITY MARKER, LAST ARRAY: %1", str BTC_rnd_city_miss_array]);};
	}
	else {_chose_mrk_rnd = true; _xx = _xx + 1;}; 

	if (_xx == (count BTC_rnd_city_miss_array) -1)
	then {_maxDist = _maxDist + 500; _xx = 0; diag_log (format["::SIDES PATROLS:: 'BTC_find_miss_place' MAX DISTANCE INCREASE"]);};
};
// // // // // // // // // // // // // // // // // // // //

	if (BTC_place_miss != 0)
	then 
	{
		if (BTC_place_miss == 2)
		then //Out city
		{
			BTC_position = [getMarkerPos _mrk_side_miss, _size_area, _size_area *2, 3, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
			while {({BTC_position distance (getMarkerPos _x) < 900} foreach BTC_rnd_city_miss_array)}
			do
			{
				BTC_position = [getMarkerPos _mrk_side_miss, _size_area, _size_area *2, 3, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
				if ({BTC_position distance (getMarkerPos _x) > 900}foreach BTC_rnd_city_miss_array)	exitWith {BTC_position};
			};
			if (BTC_debug == 1) then {player sidechat format ["Mission Place: Out city"];}; 
			diag_log (format["Mission Place: Out city %1", mapGridPosition BTC_position]);
		};
	}
	else //Anyware
	{
		BTC_position = [getMarkerPos _mrk_side_miss, 0, _size_area, 3, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
		while {(BTC_position distance (getMarkerpos "base_flag") < 2500)} do
		{BTC_position = [getMarkerPos _mrk_side_miss, 0, _size_area, 3, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;};
		if (BTC_debug == 1) then {player sidechat format ["Mission Place: Anyware"];}; 
		diag_log (format["Mission Place: Anyware %1", mapGridPosition BTC_position]);
	};



		



