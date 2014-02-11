// escortRTB.sqf
// © OCTOBER 2011 - norrin
private ["_escort","_heli","_base","_group","_groupH","_unit","_target","_dir","_wp_target"];
_escort = _this select 0;
_heli	= _this select 1;
_base 	= _this select 2;
_group	= _this select 3;
_groupH	= group _heli;
_unit	= _heli getVariable "NORRN_H_commandingUnit";
// Give escort command to return to base
_target = (getPos _base);
_heli doMove _target;
// Hint commanding unit that escort is returning to base
if (local _unit) then 
{
	hint Nor_HT_M9;
} else { 
	Nor_HT_M = [_unit, Nor_HT_M9];
	publicVariable "Nor_HT_M";
};
while {_escort distance _base > 200 && canMove _escort} do 
{
	_escort commandMove _target;
	sleep 5;
};
// Escort joins own group for RTB and landing
if (_escort in units _groupH) then {[_escort] joinSilent _group};
sleep 1;
_dir = ((_target select 0) - (getpos _heli select 0)) atan2 ((_target select 1) - (getpos _heli select 1));
_wp_target = [((_target select 0) + (20 * sin _dir)),((_target select 1) + (20 * cos _dir)),0]; //reduced flypast distance
_escort doMove _wp_target;
_escort flyInHeight 45;
while {_escort distance _base > 100 && canMove _escort} do 
{
	_escort doMove _wp_target;
	sleep 5;
};
if (canMove _escort) then {_escort land "LAND"};
while {_escort distance _base > 20 && (getPos _escort select 2) > 10 && canMove _escort} do 
{	
	_escort doMove _wp_target;
	sleep 5;
};	
if (canMove _escort) then 
{
	_escort land "LAND";
	while {(canMove _escort) && (getPos _escort select 2) > 5} do {_escort land "LAND"; sleep 1};
	_escort engineOn false;	
	sleep 4;
	_escort setVelocity [0, 0, 0];
	sleep 2;
	_escort land "none";
	if (isEngineOn _escort) then {_escort engineOn false};
	// Refuel escort
	_escort setFuel 1;
	[_escort,_heli] spawn Nor_HT_SS2;
};
