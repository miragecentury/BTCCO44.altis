/**************************************************
 BTC_MFUPS MULTY FUNCTIONAL URBAN PATROL SCRIPT	
 ® August 2013 =BTC= Muttley  				 	
 Visit us: www.blacktemplars.altervista.org   
 V 0.4 - 20/11/2013
**************************************************/

if (isServer) then 
{
waitUntil {!isnil "bis_fnc_init"};
waitUntil {(init_server_done)};
//diag_log (format["BTC_UPS START"]);
//nul = [leader _group, MARKER, WAYT_TIME, HEIGHT] execVM "scripts\BTC_UPS.sqf";
//_patrol = [leader _group,"area10", 30, 0] execVM "scripts\BTC_UPS.sqf";
private ["_unit","_patrolMarker","_unitWaittime","_flyInHeight","_WPradius","_pos_mrk","_max_mrk_prtl","_unitFormation","_unitBehaviour","_min_wp_dist"];

_unit          = _this select 0;
_patrolMarker  = _this select 1;
_unitWaittime  = _this select 2;
_flyInHeight   = _this select 3;
_radius_patrol = _this select 4;
_WPradius = 0;
_objDist= 0;
_wpType = 0;
_dist_base = 2000;

switch (typeName _patrolMarker) do
{
	case "ARRAY" :	{_pos_mrk = _patrolMarker; _min_wp_dist = 50;};
	case "STRING":	{
						_pos_mrk = getMarkerPos _patrolMarker; 
						_min_wp_dist = ((getMarkerSize _patrolMarker) select 0) / 4;
						//if (BTC_debug == 1) then {_patrolMarker setmarkeralpha 1;} else {_patrolMarker setmarkeralpha 0;};
						if (vehicle _unit isKindOf "Air") then {_pos_mrk setMarkerPos [(GetMarkerPos _pos_mrk) select 0, (GetMarkerPos _pos_mrk) select 1, _flyInHeight];};
					};
	case "OBJECT":	{_pos_mrk = position _patrolMarker; _min_wp_dist = 50;};
};
 

if (isNil ("_flyInHeight")) then {_flyInHeight = 0;};
if (isNil ("_radius_patrol"))
then 
{
	switch (typeName _patrolMarker) do
	{
		case "ARRAY" :{_max_mrk_prtl = _patrolMarker;};
		case "STRING":{_max_mrk_prtl = (getMarkerSize _patrolMarker) select 0;};
		case "OBJECT":{_max_mrk_prtl = getPos _patrolMarker;};
	};
}
else {_radius_patrol = _this select 4; _max_mrk_prtl = _radius_patrol; _min_wp_dist = _max_mrk_prtl /4; };

if (vehicle _unit isKindOf "Air") then { if (_flyInHeight < 60) then {_flyInHeight = 60}; };

//if (BTC_debug == 1) then {diag_log (format["BTC_UPS script UNIT: %1", TRACK_Instances]);diag_log (format["BTC_UPS script MARKER: %1",_pos_mrk]); };

if (vehicle _unit isKindOf "Ship")
	then {_WPradius = 20; _objDist = 10; _wpType = 2; _dist_base = 2000;}
	else {
			if (vehicle _unit isKindOf "Air")
			then {_WPradius = _flyInHeight; _objDist = 10; _wpType = 1; if (_flyInHeight > 100)then{_WPradius = 100;}; _dist_base = 2000;}
			else {
					if (vehicle _unit isKindOf "LandVehicle")
					then {_WPradius = 20; _objDist = 10; _wpType = 0; _dist_base = 2000;}
					else {_WPradius = 2; _objDist = 1; _wpType = 0; _dist_base = 2000;};
				};
		};
/// If Diver or Submarine
if ((vehicle _unit isKindOf "O_Soldier_diver_base_F")||(vehicle _unit isKindOf "B_Soldier_diver_base_F")||
(vehicle _unit isKindOf "I_Soldier_diver_base_F")||(vehicle _unit isKindOf "SDV_01_base_F")) 
then {_WPradius = 2; _objDist = 5; _wpType = 2;};

_unitFormation = ["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND", "FILE", "FILE", "FILE"] call BIS_fnc_selectRandom;
_unitBehaviour = ["SAFE", "SAFE", "SAFE", "SAFE", "SAFE", "SAFE", "SAFE", "SAFE", "AWARE", "STEALTH"] call BIS_fnc_selectRandom;
//if (BTC_debug == 1) then {diag_log (format["BTC_UPS script UNIT FORMATION: %1",_unitFormation]);diag_log (format["BTC_UPS script UNIT BEHAVIOUR: %1",_unitBehaviour]); };

private ["_grp","_unitSpeed","_pos","_pos1","_pos2","_pos3","_house","_x","_Newpos","_posX","_posY","_posZ"];
_x = 0;
_grp = group _unit;
if (BTC_debug == 1) then {_unitSpeed = "FULL";} ELSE {_unitSpeed = "LIMITED";};
//"FULL" "NORMAL" "LIMITED";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////*** START Create waypoints ***////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_prevPos = _pos_mrk;

for "_i" from 0 to (2 + (floor (random 2))) do
{
/// Set waypoint height below sea level
if ((vehicle _unit isKindOf "O_Soldier_diver_base_F")||(vehicle _unit isKindOf "B_Soldier_diver_base_F")||(vehicle _unit isKindOf "I_Soldier_diver_base_F")||(vehicle _unit isKindOf "SDV_01_base_F")) 
then
{
	private ["_position","_attempt","_isWater","_objectASL","_objectATL","_dist","_My_deepness"];
	_obj = ["Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_FMradio_F","Land_HandyCam_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_SurvivalRadio_F","Land_PencilGreen_F","Land_PencilRed_F","Land_PencilYellow_F","Land_PenRed_F"] call BIS_fnc_selectRandom;
	_position  = [_prevPos, 5, _max_mrk_prtl,  _objDist, _wpType, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
	_isWater = surfaceIsWater _position;
	_attempt = 0;
	while {(!(_isWater)||(_position distance _prevPos > _max_mrk_prtl))}
	do 
	{
		_position  = [_prevPos, 5, _max_mrk_prtl,  _objDist, _wpType, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
		_isWater = surfaceIsWater _position; _attempt = _attempt + 1; 
		if (_attempt > 10) exitWith {diag_log "BTC_MFUPS ERROR: Couldn't find a water position";};
	};
	_prevPos = _position;
	_objectASL = createVehicle [_obj, _position, [], 0, "None"];
	_objectASL setPosASL [(GetPosASL _objectASL select 0), (GetPosASL _objectASL select 1), 0];
	_objectATL = createVehicle [_obj, _position, [], 0, "None"];
	_objectATL setPosATL [(GetPosATL _objectATL select 0), (GetPosATL _objectATL select 1), 0];
	_dist = (_objectASL distance _objectATL) /2;
	_My_deepness = -1 * _dist;
	deleteVehicle _objectASL;  _rnd= round(random 2)+1;  if !(_rnd == 1)then {deleteVehicle _objectATL;};
	_posX = _position select 0;
	_posY = _position select 1;
	_pos = [_posX,_posY,_My_deepness];
}
else 
{
	_pos = [_prevPos, _min_wp_dist, _max_mrk_prtl, _objDist, _wpType, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_attempt = 0;
	while {((_pos distance _prevPos) > _max_mrk_prtl)||(_pos distance (getMarkerPos "base_flag") < _dist_base ) } do 
	{
		_pos = [_prevPos, _min_wp_dist, _max_mrk_prtl, _objDist, _wpType, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
		_attempt = _attempt + 1;
		if (_attempt > 100) exitwith 
		{
			_pos = [((_prevPos) select 0)-((random _max_mrk_prtl)/2)*sin(random 359), ((_prevPos) select 1)-((random _max_mrk_prtl)/2)*cos(random 359), _flyInHeight];
			diag_log "BTC_UPS: BIS_fnc_findSafePos fail ''_pos''!"; 
		};
	};
	_prevPos = _pos;
	//if (BTC_debug == 1) then {diag_log text format ["BTC_UPS Coord. waypoint: %1", _pos];};
};

_waypoint = _grp addWaypoint [_pos,0];
_waypoint setWaypointType "Move";
_waypoint setWaypointBehaviour _unitBehaviour;
_waypoint setwaypointcombatmode "RED"; 
_waypoint setWaypointSpeed _unitSpeed; 
_waypoint setWaypointFormation _unitFormation;
_waypoint setWaypointCompletionRadius _WPradius; 
_waypoint setWaypointTimeout [_unitWaittime, _unitWaittime, _unitWaittime];
_waypoint setWaypointScript "_script = [_unit] execVM 'scripts\BTC_house_pos.sqf';";

}; ///NON CANCELLARE


////////////////////////////////////////////////////////////////////////////////
_waypoint = _grp addWaypoint [_pos,0]; 
_waypoint setWaypointType "Cycle";
_waypoint setWaypointBehaviour "UNCHANGED";
_waypoint setwaypointcombatmode "NO CHANGE"; 
_waypoint setWaypointSpeed "UNCHANGED";
_waypoint setWaypointFormation "NO CHANGE";
_waypoint setWaypointCompletionRadius _WPradius; 
_waypoint setWaypointTimeout [_unitWaittime, _unitWaittime, _unitWaittime];

//if (BTC_debug == 1) then {diag_log text format ["BTC_UPS FINISH WAYPOINTS UNIT_%1", TRACK_Instances];};
}; ///NON CANCELLARE




