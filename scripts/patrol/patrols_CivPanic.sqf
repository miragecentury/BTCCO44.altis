///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
/// File: scripts\patrol\patrols_CivPanic.sqf	 //	
///////////////////////////////////////////////////

waitUntil {!isnil "bis_fnc_init"};
waitUntil {sleep 1;(init_server_done)};

if ((isServer)&&((BTC_civ_city == 1))) then 
{

_Scared = _this select 0;

if (BTC_debug == 1) then {diag_log text format["PATROL_CivPanic.SQF, ACTIVATED city_area"];};
if (BTC_debug == 1) then {diag_log text format["PATROL_CivPanic.SQF, CIVILIAN escaping to safe position"];};
if (BTC_debug == 1) then {player sideChat format["PATROL_CivPanic.SQF, CIVILIAN escaping to safe position"];};
_grp = group _Scared;
if (BTC_debug == 1) then {diag_log text format["PATROL_CivPanic.SQF, group _Scared: %1", _grp];};
_Array = waypoints _grp; //Unit waypoints
if (BTC_debug == 1) then {diag_log text format["PATROL_CivPanic.SQF, _Array waypoints _Scared: %1", _Array];};

if (count _Array > 0) then 
{ {deleteWaypoint [_grp, _x]} foreach [1,2,3,4,5,6,7,8,9]; };
_pos = [(getPos _Scared), 3000, 3000, 1, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
_Scared doMove _pos;
if (BTC_debug == 1) then {player sideChat format["PATROL_CivPanic.SQF, CIVILIAN escaping to safe position"];};

//_Scared allowfleeing 1; _Scared setskill ["courage",0]; _Scared disableai "fsm"; 

waitUntil
{sleep 2;
( (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance (position _Scared)) < 1000)} count allUnits) < 1)
&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance (position _Scared)) < 1000)} count allUnits) < 1)
&&(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance (position _Scared)) < 1000)} count allUnits) < 1) 
) };

deleteVehicle _Scared;

//if (BTC_debug == 1) then {diag_log text format ["PATROL_CivPanic.SQF, SCRIPT END"];};
};///////////






