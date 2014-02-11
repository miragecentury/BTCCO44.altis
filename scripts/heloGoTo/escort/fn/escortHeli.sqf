// escortHeli.sqf
// APRIL 2013 - norrin
private ["_escort","_heli","_base","_group","_groupH","_groupE","_slickDisabled","_unit","_pos","_offset","_dir","_targets"];
if (!isServer || local _heli) exitWith {};
_escort 		= _this select 0;
_heli			= _this select 1;
_base 			= _escort getVariable "NORRN_heloGoTo_basePos";
_group 			= group _escort;
_groupH			= group _heli;
_slickDisabled  = false;
_unit 		    = _heli getVariable "NORRN_H_commandingUnit";
_targets		= [];

// Wait until slick engineOn
while {!isEngineOn _heli  && canMove _escort} do {
	_escort engineOn false;	
	sleep 1;
};
if (!canMove _escort) exitWith {}; 
// Turn on escort engine
_escort engineOn true;
// Wait until slick takes off
while {((getPos _heli) select 2) < 5 && canMove _escort} do {sleep 1};
if (!canMove _escort) exitWith {};
if !(_heli getVariable "NORRN_aerialTaxiRTB") then {	
	_escort flyInHeight 40;
	// Set escort behaviour
	_escort setBehaviour "SAFE";
	_escort setSkill 1;
	// Escort joins group slick and sets formation
	if !(_escort in units _groupH) then {[_escort] joinSilent _groupH};
	_escort land "none";
	sleep 0.1;
	// Escort sets slick as leader and formation
	_groupH selectLeader _heli;
	_groupH setFormation "Line";
	// Wait until slick destination chosen
	while {([_escort,_heli] call Nor_HTE_C2)} do {sleep 0.5}; 
	sleep 1;
	_pos = (getMarkerPos (format ["%1", _heli]));
	// Get direction to marker
	_dir = ((_pos select 0) - (getpos _heli select 0)) atan2 ((_pos select 1) - (getpos _heli select 1));
	// Create and move escort to marker offset position
	_offset = [((_pos select 0) + (sin(_dir - 90) * 80) + (60 * sin _dir)), ((_pos select 1) + (cos (_dir - 90) * 80) + (60 * cos _dir)), 40];
	_escort commandMove _offset; //reduced flypast distance
	sleep 5;
	// Disable attack mode for slick
	[_heli,_escort] spawn Nor_HT_SS1;
	_groupH setFormation "Line";
	// Wait until slick gets to destination
	while {([_escort,_heli] call Nor_HTE_C3) && ((getPos _heli) select 2) > 25 && (_escort distance _pos) > 100} do {_escort commandMove _offset; sleep 5};
	if ([_escort,_heli] call Nor_HTE_C3 &&(_heli getVariable "NORRN_H_destChosen")) then {
		// Enable attack mode for escort
		_groupE = createGroup (side _escort);
		sleep 0.5;
		[_escort] joinSilent _groupE;
		sleep 0.5;
		[_escort] spawn Nor_HT_S20;
		sleep 0.5;
		// Alert escort to known targets
		_targets = ((vehicle _escort) nearTargets 500) + ((vehicle _unit) nearTargets 500);
		if (count _targets > 0) then {{_escort reveal (_x select 4)} forEach _targets};
	};
	if (!canMove _escort) exitWith {};
	// Wait until slick lands
	while {([_escort,_heli] call Nor_HTE_C3) && ((getPos _heli) select 2 > 10)} do {sleep 1};
	if (!canMove _escort) exitWith {};
	sleep 10;
	// Wait untilslick takes off
	_escort flyInHeight 40;
	while {([_escort,_heli] call Nor_HTE_C3) && ((getPos _heli) select 2 < 20)} do {sleep 0.5};
	sleep 2;
	// Enable attack mode for slick
	if (canMove _heli) then {[_heli] spawn Nor_HT_S20};
	while {([_escort,_heli] call Nor_HTE_C1)} do {sleep 0.5/*; hintSilent "Escort patrolling landing site"*/};
};
// Disable attack mode for slick and escort
[_heli,_escort] spawn Nor_HT_SS1;
[_escort] joinSilent _groupH;
sleep 2;
deleteGroup _groupE;
//  Escort returns to base if slick returns to base
if (canMove _escort && !(canMove _heli) || canMove _escort && (_heli getVariable "NORRN_aerialTaxiRTB")) exitWith {
	[_escort,_heli,_base,_group] call Nor_HTE_S0;
};
if ((_heli getVariable "NORRN_heloGoto_cancel") && !(_heli getVariable "NORRN_aerialTaxiRTB")) exitWith {_escort doMove (getPos _escort);[_escort,_heli] spawn Nor_HT_SS2};
if ((_heli getVariable "NORRN_H_destChosen") && !(_heli getVariable "NORRN_aerialTaxiRTB")) exitWith 
{
	// Hint commanding unit that escort is returning to formation
	if (local _unit) then {
		hint Nor_HT_M10;
	} else { 
		Nor_HT_M = [_unit, Nor_HT_M10];
		publicVariable "Nor_HT_M";
	};
	[_escort,_heli] spawn Nor_HT_SS2
}; 






