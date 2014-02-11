///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////


if (isServer) then 
{
	waitUntil{!isnil "bis_fnc_init"};
	
	_spw= [] spawn 
	{
		if (BTC_debug == 1) then {player sideChat "START CHOSE MISSION SELECTION"; };
		diag_log (format["START CHOSE MARKER SCRIPT"]);
		private ["_BTC_rnd_city_miss_array","_MissionsCount","_Slct_miss"];

		//_BTC_rnd_city_miss_array = 	["mrk_city_1","mrk_city_2","mrk_city_3","mrk_city_4","mrk_city_5","mrk_city_6","mrk_city_7","mrk_city_8","mrk_city_9","mrk_city_10","mrk_city_11","mrk_city_12","mrk_city_13","mrk_city_14","mrk_city_15","mrk_city_16","mrk_city_17","mrk_city_18","mrk_city_19","mrk_city_20","mrk_city_21","mrk_city_22","mrk_city_23","mrk_city_24","mrk_city_25","mrk_city_26","mrk_city_27","mrk_city_28","mrk_city_29","mrk_city_30","mrk_city_31","mrk_city_32","mrk_city_33","mrk_city_34"];
		_BTC_rnd_city_miss_array = BTC_mrk_civ_citys;
		_MissionsCount = count _BTC_rnd_city_miss_array;
		BTC_rnd_city_miss_array = [];
		_numberM = 0;

		for [{_i = 0},{_i < _MissionsCount},{_i = _i + 1}] do 
		{
		  _numberM = floor random (count _BTC_rnd_city_miss_array); // gets current number of elements
			BTC_rnd_city_miss_array = BTC_rnd_city_miss_array + [_BTC_rnd_city_miss_array select _numberM];// places selected marker name in post array
			  _BTC_rnd_city_miss_array set [_numberM,-1];// you cant delete a nested element/array so we replace it with a normal element that can 
				_BTC_rnd_city_miss_array = _BTC_rnd_city_miss_array -[_BTC_rnd_city_miss_array select _numberM]; // removes selected element
		};
		
		if (BTC_debug == 1) then 
		{
		  // used for debug only 
		  //hint str BTC_rnd_city_miss_array; player sidechat format["%1",BTC_rnd_city_miss_array];
		  sleep  1;
		  //hint str (BTC_rnd_city_miss_array select 0); 
		  diag_log (format["RANDOM MISSION MARKERS ARRAY"]);
		  diag_log str BTC_rnd_city_miss_array; 	// Array contenente la sequenza random dei marker missione
		};
	};
	
		_spw= [] spawn 
	{
	
		if (BTC_debug == 1) then {player sideChat "START CHOSE MISSION SELECTION"; };
		diag_log (format["START CHOSE MISSION SELECTION"]);
		private ["_BTC_rnd_outcity_miss_array","_MissionsCount","_Slct_miss"];
		
		_BTC_rnd_outcity_miss_array = BTC_mrk_out_citys;
		_MissionsCount = count _BTC_rnd_outcity_miss_array;
		BTC_rnd_outcity_miss_array = [];
		_numberM = 0;

		for [{_i = 0},{_i < _MissionsCount},{_i = _i + 1}] do 
		{
		  _numberM = floor random (count _BTC_rnd_outcity_miss_array); // gets current number of elements
			BTC_rnd_outcity_miss_array = BTC_rnd_outcity_miss_array + [_BTC_rnd_outcity_miss_array select _numberM];// places selected marker name in post array
			  _BTC_rnd_outcity_miss_array set [_numberM,-1];// you cant delete a nested element/array so we replace it with a normal element that can 
				_BTC_rnd_outcity_miss_array = _BTC_rnd_outcity_miss_array -[_BTC_rnd_outcity_miss_array select _numberM]; // removes selected element
		};
		
		if (BTC_debug == 1) then 
		{
		  // used for debug only 
		  //hint str BTC_rnd_outcity_miss_array; player sidechat format["%1",BTC_rnd_outcity_miss_array];
		  sleep  1;
		  //hint str (BTC_rnd_outcity_miss_array select 0); 
		  diag_log (format["RANDOM MISSION MARKERS OUT ARRAY"]);
		  diag_log str BTC_rnd_outcity_miss_array; 	// Array contenente la sequenza random delle missioni
		};
	};
	
};
		



