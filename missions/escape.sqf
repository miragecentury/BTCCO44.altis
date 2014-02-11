////////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   ///
/// Visit us: www.blacktemplars.altervista.org   ///
////////////////////////////////////////////////////

if (isServer) then
{

_unit = _this select 0;
[_unit] join grpNull; 
_unit setBehaviour "CARELESS";
_unit setskill ["courage",1];
_unit setskill ["Endurance",1];
_unit setskill ["general",1];
_unit disableai "fsm"; 
_grp = group _unit;
_Array = waypoints _grp; //Unit waypoints
if (count _Array > 0) then { {deleteWaypoint [_grp, _x]} foreach [1,2,3,4,5,6,7,8,9]; };


	_array_obj = [];
	_array	   = [];
	_array = nearestObjects [_unit, ["Car","ship"], 350];
	{if (((damage _x) < 0.2)&&(canMove _x)) then {_array_obj = _array_obj + [_x];};} foreach _array;
	
	diag_log (format[":ESCAPE.SQF: _array= %1 :::::::::::::::::", _array]);
	diag_log (format[":ESCAPE.SQF: _array_obj= %1 :::::::::::::::::", _array_obj]);
	
	if (count _array_obj > 0) then 
	{
		_near_car = _array_obj select 0;
		_unit doMove (position _near_car);
		waituntil { sleep 2; ((_unit distance _near_car) < 5) };
		diag_log (format[":ESCAPE.SQF: Target found a transport. :::::::::::::::::"]);
		if ((Alive _unit)&&((damage _near_car) < 0.2)&&(canMove _near_car)) 
		//exitwith {_unit moveinDriver _near_car; _unit doMove (getMarkerPos "escape_M10"); diag_log (format[":ESCAPE.SQF: Target Driver of vehicle. :::::::::::::::::"]);};
		exitwith 
		{
			_unit moveinDriver _near_car; 
			_unit assignAsDriver _near_car; 
			sleep 0.1;
			if (vehicle _unit isKindOf "ship") 
			then {_escape = [(getPos _unit), 4000, 4000, 1, 0, 50*(pi / 180), 1] call BIS_fnc_findSafePos; "escape_M10" setMarkerPos _escape; "debug_mrk_2" setMarkerPos _escape;} 
			else {_escape = [(getPos _unit), 4000, 4000, 1, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos; "escape_M10" setMarkerPos _escape; "debug_mrk_1" setMarkerPos _escape;};
			[_unit,"escape_M10",100] spawn BTC_give_waypoint; 
			diag_log (format[":ESCAPE.SQF: Target escaping driving a vehicle. :::::::::::::::::"]);
			while {(Alive _unit)} do 
			{
				if !(canMove vehicle _unit) then
				{
					waitUntil {sleep 1; (speed (vehicle _unit) == 0)}; 
					commandGetOut _unit; 
				};
			};
			
		};
	//} else {while {(Alive _unit)} do {_unit doMove (getMarkerPos "escape_M10"); diag_log (format[":ESCAPE.SQF: Target escape on foot. :::::::::::::::::"]);sleep 30; };};
	} else {[_unit,"escape_M10",100] spawn BTC_give_waypoint; diag_log (format[":ESCAPE.SQF: Target escape on foot. :::::::::::::::::"]);};
	
};

