// RTB.sqf
// © OCTOBER 2011 - norrin
private ["_heli","_group","_base","_pilot","_flightCrew","_gunners","_unit","_escort","_target","_dir","_wp_target"];
_heli 		= _this select 0;
if (!local _heli) exitWith {};
_group 		= group _heli;
_base 		= _heli getVariable "NORRN_heloGoTo_basePos";
_pilot 		= driver _heli;
_flightCrew	= crew _heli;
_gunners	= [];
_unit 		= _heli getVariable "NORRN_H_commandingUnit";
// Identify if gunners are present
{if(count(assignedVehicleRole _x) == 2) then {_gunners = _gunners + [_x]}}forEach _flightcrew;
// Chopper takes off
_heli flyInHeight 60;
_heli doMove (getPos _heli);
sleep 5;
// Set RTB var true
_heli setVariable ["NORRN_aerialTaxiRTB", true, true];
// Identify flight crew
{if(count(assignedVehicleRole _x) == 2 && _x == driver _heli) then {_flightCrew = _flightCrew + [_x]}}forEach crew _heli;
_flightCrew = _flightCrew - [_pilot];
_heli removeAction NORRN_heliGoToRTB_action;
_target = (getPos _base);
_heli doMove _target;
// Hint commanding unit "Chopper returning to base"
if (local _unit) then 
{
	hint Nor_HT_M6;
} else { 
	Nor_HT_M = [_unit, Nor_HT_M6];
	publicVariable "Nor_HT_M";
};
sleep 5;
while {_heli distance _base> 200 && canMove _heli} do {sleep 1};
_dir = ((_target select 0) - (getpos _heli select 0)) atan2 ((_target select 1) - (getpos _heli select 1));
_wp_target = [((_target select 0) + (20 * sin _dir)),((_target select 1) + (20 * cos _dir)),0]; //reduced flypast distance
_heli doMove _wp_target;
_heli flyInHeight 40;
while {_heli distance _base > 100 && canMove _heli} do 
{	
	_heli doMove _wp_target;
	sleep 5;
};
if (canMove _heli) then {_heli land "LAND"};
while {_heli distance _heliH > 20 && (getPos _heli select 2) > 10 && canMove _heli} do 
{
	_heli doMove _wp_target;
	sleep 5;
};
if (canMove _heli) then
{ 	
	if (canMove _heli) then {_heli land "LAND"};
	while {(canMove _heli) && (getPos _heli select 2) > 5} do {_heli land "LAND"; sleep 1};
	_heli engineOn false;	
	sleep 2;
	_heli setVelocity [0, 0, 0];
	sleep 2;
	_heli land "none";
	// Remove unecessary actions
	if (local _unit) then 
	{
		[_unit] spawn Nor_HT_S6
	} else {
		Nor_HT_S = [_unit, Nor_HT_S6];
		publicVariable "Nor_HT_S";
	};
	if (isEngineOn _heli) then {_heli engineOn false};
	// Hint commanding unit "Chopper refuelling at base"
	if (local _unit) then 
	{
		hint Nor_HT_M4;
	} else {
		Nor_HT_M = [_unit, Nor_HT_M4];
		publicVariable "Nor_HT_M";
	};
	sleep 10;
	if (!isNull(_heli getVariable "NORRN_H_escort")) then 
	{	
		_escort = (_heli getVariable "NORRN_H_escort");
		while {canMove _escort && (getPos _escort select 2) > 5} do {_heli engineOn false; sleep 1};
	};
	_heli setVariable ["NORRN_aerialTaxiRTB", false, true];
	_heli setFuel 1;
	sleep 5;
	//  Hint commanding unit "Chopper awaiting orders"
	if (local _unit) then 
	{
		hint Nor_HT_M5
	} else {
		Nor_HT_M = [_unit, Nor_HT_M5];
		publicVariable "Nor_HT_M";
	};
	_c = 0;
	if !(_pilot in crew _heli) then {_pilot moveInDriver _heli};
	{if (_x == vehicle _x) then {_x moveInTurret [_heli, [_c]]; _c = _c + 1}} forEach _gunners;
	_heli setVariable ["NORRN_H_destChosen", false, true];
	// Re-add extraction action
	if (local _unit) then {
		[_unit] spawn Nor_HT_S13
	} else {
		Nor_HT_S = [_unit, Nor_HT_S13];
		publicVariable "Nor_HT_S";
	};
};







