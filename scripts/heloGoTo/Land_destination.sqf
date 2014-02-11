// LAND_destination.sqf
// APRIL 2013 - norrin
private ["_heli","_pilot","_heliH","_base","_landPos","_unit","_mrker_pos","_mrkr_ex","_target","_dir","_wp_target"];
_heli       = _this select 0;
if (!local _heli) exitWith {};
_pilot 		= driver _heli;
_heliH 		= objNull;
_landPos 	= _heli getVariable "NORRN_H_destPos";
_unit  		= _heli getVariable "NORRN_H_commandingUnit";
// Set heli variables
_heli setVariable ["NORRN_heliStayPut", true, true];
_heli setVariable ["NORRN_heloGoto_cancel", false, true];
_heli setVariable ["NORRN_aerialTaxiRTB", false, true];
sleep 1;
// Create Marker
_mrker_pos = _landPos;
_mrkr_ex = format ["%1", _heli];
createMarker [_mrkr_ex, _mrker_pos];
_mrkr_ex setMarkerColor "ColorBlue";
_mrkr_ex setMarkerType "mil_objective";
_mrkr_ex setMarkerText "Chopper destination";
_mrkr_ex setMarkerSize [1.0, 1.0];
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
_wp_target = [((_target select 0) + (50 * sin _dir)),((_target select 1) + (50 * cos _dir)),0]; 
while {((getPos _heli) select 2) < 20 && !(_heli getVariable "NORRN_heloGoto_cancel")} do {sleep 0.5};
sleep 5;
_heli doMove _wp_target;
sleep 5;
while {_heli distance _heliH > 100 && !(_heli getVariable "NORRN_heloGoto_cancel") && canMove _heli} do 
{
	_heli doMove _wp_target;
	sleep 5;
};
if !(_heli getVariable "NORRN_heloGoto_cancel" && canMove _heli) then {_heli land "LAND"};
while {_heli distance _heliH > 20 && !(_heli getVariable "NORRN_heloGoto_cancel") && (getPos _heli select 2) > 10 && canMove _heli} do 
{
	_heli doMove _wp_target;
	sleep 5;
};
if (!(_heli getVariable "NORRN_heloGoto_cancel") && canMove _heli) then
{ 	
	// Remove unecessary actions
	if (local _unit) then 
	{
		[_unit] spawn Nor_HT_S6;
	} else { 
		Nor_HT_S = [_unit, Nor_HT_S6];	
		publicVariable "Nor_HT_S";
	};
	if (canMove _heli) then {_heli land "LAND"};
	while {(canMove _heli) && (getPos _heli select 2) > 5} do {_heli land "LAND"; sleep 1};
	_heli engineOn false;
	sleep 1;
	//  Hint commanding unit "Disembark the chopper"
	if (local _unit) then 
	{
		hint Nor_HT_M7;
	} else { 
		Nor_HT_M = [_unit, Nor_HT_M7];
		publicVariable "Nor_HT_M";
	};
	sleep 0.5;
	_heli setVelocity [0, 0, 0];
	sleep 2;
	_heli land "none";
	[_heli] spawn Norrn_heliStayPut_Func;
	if !(isEngineOn _heli) then {_heli engineOn true};
	sleep 5;
	// Spawn addHeliDepartLandAction.sqf for commanding unit
	if (local _unit) then 
	{
		[_unit] spawn Nor_HT_S7
	} else {
		Nor_HT_S = [_unit, Nor_HT_S7];	
		publicVariable "Nor_HT_S";
	};
};
while {(getPos _heli) select 2 < 20 && alive _heli && !(_heli getVariable "NORRN_heloGoto_cancel")} do {sleep 0.1};
deleteVehicle _heliH;
deleteMarker _mrkr_ex;
	