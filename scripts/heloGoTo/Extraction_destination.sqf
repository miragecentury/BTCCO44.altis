// Extraction_destination.sqf
// APRIL 2013- norrin
private ["_heli","_pilot","_crew","_group","_timeChopLand","_sleep","_exPos","_unit","_mrker_pos","_mrkr_ex","_heliH","_target","_dir","_wp_target","_smoke_target"];
 _heli = _this select 0;
if (!local _heli) exitWith {};
_pilot 					= driver _heli;
_crew					= crew _heli;
_group 					= group _heli;
_timeChopLand			= 30;
_sleep 					= 0;
_exPos = _heli getVariable "NORRN_H_exPos";
_unit  = _heli getVariable "NORRN_H_commandingUnit";
// Set heli variables
_heli setVariable ["NORRN_heliStayPut", true, true];
_heli setVariable ["NORRN_heloGoto_cancel", false, true];
_heli setVariable ["NORRN_aerialTaxiRTB", false, true];
// Create Marker
_mrker_pos = _exPos;
_mrkr_ex = format ["%1", _heli];
createMarker [_mrkr_ex, _mrker_pos];
_mrkr_ex setMarkerColor "ColorBlue";
_mrkr_ex setMarkerType "mil_pickup";
_mrkr_ex setMarkerText "Extraction point";
_mrkr_ex setMarkerSize [1.0, 1.0];
sleep 0.5;
// Create HeilH
_heliH = "Land_HelipadEmpty_F" createVehicle (getMarkerPos _mrkr_ex); 
sleep 1;
// Turn on engine 
_heli engineOn true;
if ((getPos _heli) select 2 < 5) then {sleep 20};
// Heli takes off
_heli flyInHeight 40;
_heli doMove getPos _heli;
//  Set heli behaviour 
_heli setBehaviour "CARELESS";
_heli setSkill 1;
// Create new move to point otherwise heli won't move to marker
_target = getPos _heliH;
_dir = ((_target select 0) - (getpos _heli select 0)) atan2 ((_target select 1) - (getpos _heli select 1));
_wp_target = [((_target select 0) + (50 * sin _dir)),((_target select 1) + (50 * cos _dir)),0]; //reduced flypast distance
while {((getPos _heli) select 2) < 20 && !(_heli getVariable "NORRN_heloGoto_cancel")} do {sleep 0.5};
sleep 5;
_heli doMove _wp_target;
sleep 5;
// Send extraction message to commanding unit
if (local _unit) then 
{
	hint Nor_HT_M0;
} else { 
	Nor_HT_M = [_unit, Nor_HT_M0];
	publicVariable "Nor_HT_M";
};
sleep 5;
while {_heli distance _heliH > 200 && alive _heli && canMove _heli} do 
{	
	_heli doMove _wp_target;
	sleep 5;
};
if (canMove _heli && alive _heli) then 
{
	_heli doMove (getPos _heliH);
	// Deploy Smoke
	if (local _unit) then 
	{
		hint Nor_HT_M1
	} else { 
		Nor_HT_M = [_unit, Nor_HT_M1];
		publicVariable "Nor_HT_M";
	};
	_smoke_target = [((_target select 0) + (5 * sin _dir)),((_target select 1) + (5 * cos _dir)),0];
	"SmokeShellGreen" createVehicle _smoke_target;
};
while {_heli distance _heliH > 100 && canMove _heli} do 
{
	_heli doMove _wp_target;
	sleep 5;
};
if (canMove _heli) then {_heli land "LAND"};
while {_heli distance _heliH > 20 && (getPos _heli select 2) > 10 && canMove _heli} do 
{
	_heli doMove (getPos _heliH);
	sleep 5;
};
if (canMove _heli) then
{ 	
	if (canMove _heli) then {_heli land "LAND"};
	while {(canMove _heli) && (getPos _heli select 2) > 2} do {_heli land "LAND"; sleep 1};
	_heli engineOn false;	
	sleep 0.5;
	_heli setVelocity [0, 0, 0];
	sleep 2;
	_heli land "none";
	[_heli] spawn Norrn_heliStayPut_Func; 
	if !(isEngineOn _heli) then {_heli engineOn true};
	// Hint commanding unit "Board the chopper"
	if (local _unit) then 
	{
		hint Nor_HT_M8;
	} else {
		Nor_HT_M = [_unit, Nor_HT_M8];
		publicVariable "Nor_HT_M";
	};
	sleep 5;
	// Add chopper depart location action to commander
	if (local _unit) then 
	{
		[_unit] spawn Nor_HT_S1;
	} else { 
		Nor_HT_S = [_unit, Nor_HT_S1];	
		publicVariable "Nor_HT_S";
	};
};
while {(getPos _heli) select 2 < 20 && canMove _heli && alive _heli} do {sleep 0.1};
deleteVehicle _heliH;
deleteMarker _mrkr_ex; 

