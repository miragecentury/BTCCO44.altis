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
	_mrk_side_miss = BTC_rnd_outcity_miss_array select _xx;
	if (BTC_debug == 1) then {diag_log (format["::SIDES PATROLS:: RANDOM CITY MARKER ARRAY = %1", _mrk_side_miss]);};
	if (
	(({(isPlayer _x) && ((_x distance (getMarkerPos _mrk_side_miss)) > _minDist)} count allUnits) > 0)&&
	(({(isPlayer _x) && ((_x distance (getMarkerPos _mrk_side_miss)) < _maxDist)} count allUnits) > 0) )
	then 
	{
	 _chose_mrk_rnd = false;
	 BTC_rnd_outcity_miss_array = BTC_rnd_outcity_miss_array - [BTC_rnd_outcity_miss_array select _xx];
	 BTC_position_out = markerPos _mrk_side_miss; //markerPos (BTC_rnd_outcity_miss_array select _xx);
	 BTC_position_mrk = _mrk_side_miss;
	 if (BTC_debug == 1) then { diag_log (format["::SIDES PATROLS:: RANDOM CITY MARKER, LAST ARRAY: %1", str BTC_rnd_outcity_miss_array]);};
	}
	else {_chose_mrk_rnd = true; _xx = _xx + 1;}; 

	if (_xx == (count BTC_rnd_outcity_miss_array) -1)
	then {_maxDist = _maxDist + 500; _xx = 0; diag_log (format["::SIDES PATROLS:: 'BTC_find_miss_place' MAX DISTANCE INCREASE"]);};
};
// // // // // // // // // // // // // // // // // // // //




		



