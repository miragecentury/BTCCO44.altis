////////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 ///	
/// Visit us: www.blacktemplars.altervista.org   ///
/// File: patrols_BASE.sqf						 ///
/// Last update: 22/09/13						 ///
////////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};
waitUntil {sleep 1;(init_server_done)};
if ((isServer)&&(BTC_patrols_base_stat == 1)) then 
{

BTC_mrk_base_area 	= "base";

// CASE BASE IS WEST 
//BTC_friendly_static= ["B_HMG_01_high_F","B_GMG_01_high_F","B_static_AA_F","B_static_AT_F","B_Mortar_01_F"];
_BTC_type_stat_base = 
[
BTC_friendly_static select 2,BTC_friendly_static select 2,BTC_friendly_static select 2, // 3 x AA
BTC_friendly_static select 3,BTC_friendly_static select 3,BTC_friendly_static select 3, // 3 x AT
BTC_friendly_static select 0,BTC_friendly_static select 0,BTC_friendly_static select 0   // 3 x HMG
];
_BTC_mrk_stat_base_0   = ["BTC_mrk_stc_hmg_1","BTC_mrk_stc_aa_1","BTC_mrk_stc_at_1"];
_BTC_mrk_stat_base_120 = ["BTC_mrk_stc_hmg_2","BTC_mrk_stc_aa_2","BTC_mrk_stc_at_2"];
_BTC_mrk_stat_base_240 = ["BTC_mrk_stc_hmg_3","BTC_mrk_stc_aa_3","BTC_mrk_stc_at_3"];


	BTC_fnc_static_defense =
	{
		private ["_area","_BTC_type_veh","_degree","_statica","_stat_wep","_statica_grp"];
		
		_area 		  = _this select 0;
		_BTC_type_veh = _this select 1;
		_degree  	  = _this select 2;
	
		while {(BTC_patrols_inf == 1)} do 
		{
			waitUntil{sleep 3; ( 
			  (({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getMarkerPos _area)) < 1000)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getMarkerPos _area)) < 1500)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Air") && ((_x distance (getMarkerPos _area)) < 3000)} count allUnits) > 0) 
					 ) 			};
			
			//Statica BTC_mrk_stc_XX_X /////////////////////////////////////////////////////////////
			_statica = [getMarkerPos _area, _degree,_BTC_type_veh,BTC_friendly_side1] call bis_fnc_spawnvehicle; 
			_stat_wep = _statica select 0;
			_statica_grp = group leader (_statica select 2); if (BTC_track) then {_track = [leader _statica_grp] execVM "scripts\BTC_track_unit.sqf";};
			
			waitUntil {sleep 3; (
			(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getMarkerPos _area)) < 1000)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getMarkerPos _area)) < 1500)} count allUnits) < 1)
			&&(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Air") && ((_x distance (getMarkerPos _area)) < 3000)} count allUnits) < 1) 
			)		};
			
			if ((Alive vehicle _stat_wep)) then {{deleteVehicle _x;} forEach crew _stat_wep; deleteVehicle _stat_wep; };
			
			////if (BTC_debug == 1) then {player sideChat format["PATROL_INF.SQF, PATROL RESPAWN"];};
			waitUntil{sleep 3; ( 
			  (({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (getMarkerPos _area)) < 1000)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (getMarkerPos _area)) < 1500)} count allUnits) > 0)
			||(({((isPlayer _x) OR (side _x == BTC_enemy_side1)) && (vehicle _x isKindOf "Air") && ((_x distance (getMarkerPos _area)) < 3000)} count allUnits) > 0)
					 ) 			};
		}; // Fine parentesi while do
	};

	["BTC_mrk_stc_hmg_1", BTC_friendly_static select 0, 0] spawn BTC_fnc_static_defense;
	["BTC_mrk_stc_aa_1", BTC_friendly_static select 2 , 0] spawn BTC_fnc_static_defense;
	["BTC_mrk_stc_at_1", BTC_friendly_static select 3 , 0] spawn BTC_fnc_static_defense;
	
	["BTC_mrk_stc_hmg_2", BTC_friendly_static select 0, 120] spawn BTC_fnc_static_defense;
	["BTC_mrk_stc_aa_2", BTC_friendly_static select 2 , 120] spawn BTC_fnc_static_defense;
	["BTC_mrk_stc_at_2", BTC_friendly_static select 3 , 120] spawn BTC_fnc_static_defense;
	
	["BTC_mrk_stc_hmg_3", BTC_friendly_static select 0, 240] spawn BTC_fnc_static_defense;
	["BTC_mrk_stc_aa_3", BTC_friendly_static select 2 , 240] spawn BTC_fnc_static_defense;
	["BTC_mrk_stc_at_3", BTC_friendly_static select 3 , 240] spawn BTC_fnc_static_defense;
	
//if (BTC_debug == 1) then {diag_log text format ["PATROL_INF.SQF, SCRIPT END"];};


};





