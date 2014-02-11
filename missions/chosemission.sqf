///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////


if (isServer) then 
{
	[] execVM "missions\chosemarkers.sqf";
	sleep 5; // Aspetta che si inizializzi la mappa NECESSARIO
	waitUntil{!isnil "bis_fnc_init"};
	
	_spw= [] spawn 
	{
		if (BTC_debug == 1) then {player sideChat "START CHOSE MISSION SELECTION"; };
		diag_log (format["START CHOSEMISSION SCRIPT"]);
		private ["_MissionsList","_MissionsCount","_Rnd_Missions_Array","_Slct_miss"];

		_MissionsList = [1,2,3,4,5,6,7,8,9,10,11,12];
		_MissionsCount = count _MissionsList;
		_Rnd_Missions_Array = [];
		_numberM = 0;

		for [{_i = 0},{_i < _MissionsCount},{_i = _i + 1}] do 
		{
		  _numberM = floor random (count _MissionsList); // gets current number of elements
			_Rnd_Missions_Array = _Rnd_Missions_Array + [_MissionsList select _numberM];// places selected marker name in post array
			  _MissionsList set [_numberM,-1];// you cant delete a nested element/array so we replace it with a normal element that can 
				_MissionsList = _MissionsList -[_MissionsList select _numberM]; // removes selected element
		};
		
		if (BTC_debug == 1) then 
		{
		  // used for debug only 
		  hint str _Rnd_Missions_Array; player sidechat format["%1",_Rnd_Missions_Array];
		  sleep  1;
		  //hint str (_Rnd_Missions_Array select 0); 
		  //diag_log (format["RANDOM MISSION ARRAY"]);  diag_log str _Rnd_Missions_Array; 	// Array contenente la sequenza random delle missioni
		};
			
		// Missioni in sequenza
		if (BTC_chs_miss == 0) 
		then 
		{
		_Rnd_Missions_Array = [];
		_Rnd_Missions_Array = [1,2,3,4,5,6,7,8,9,10,11,12];
		};
	
		//======================================
		//========= CHOOSE THE MISSIONS ========
		//======================================
		
		//waitUntil {sleep 1;(BTC_chosemarker_init)};
		waitUntil {sleep 3;(side_chose_init)&&(BTC_mission_request)};
		private ["_Slct_miss","_mission","_nul"];
		_Slct_miss = 0;
		//_Slct_miss = 6; //_Rnd_Missions_Array = [7,7,7];/// ***** TEST ONLY ***** \\\
		while {(_Slct_miss < _MissionsCount)} 
		do 
		{
			_mission = _Rnd_Missions_Array select _Slct_miss;
			_nul = execVM format["missions\mission%1.sqf", _mission];
			side_chose_init = false; publicVariable "side_chose_init";
			BTC_mission_request = false; publicVariableServer "BTC_mission_request";
			waitUntil {sleep 3;(side_chose_init)&&(BTC_mission_request)};
			_Slct_miss = _Slct_miss + 1;
		};
	
	};
	
};
		



