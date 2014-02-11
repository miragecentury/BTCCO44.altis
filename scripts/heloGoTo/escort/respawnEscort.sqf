// respawnEscort.sqf
// © OCTOBER 2011 - norrin
private ["_heli","_type","_name","_new_heli","_side","_group","_onboard","_crew","_type_crew","_assignedRole_crew","_aerialTaxi","_slick","_commandingUnit","_base","_loop","_typeNew","_assignedNew","_unitsGroup","_guy"]; //
_heli 		= _this select 0;
_slick		= _this select 1;
_type 		= typeOf _heli;
_name 		= format ["%1", _heli];
_new_heli	= objNull;
_side 		= side _heli;
_group 		= group _heli; 
if (!local _heli) exitWith {};
sleep 2;
// Identify crew members
_onboard = crew _heli;
_crew = [];
{if(count(assignedVehicleRole _x) == 2 || _x == driver _heli) then {_crew = _crew + [_x]}}forEach _onboard;
_type_crew = [];
{_type_crew = _type_crew + [typeOf _x]} forEach _crew;
_assignedRole_crew = [];
{_assignedRole_crew = _assignedRole_crew + [assignedVehicleRole _x]} forEach _crew;
_aerialTaxi = _heli getVariable "NORRN_aerialTaxi";
_commandingUnit = _slick getVariable "NORRN_H_commandingUnit";
// Sleep while heli is OK
while {canMove _heli && alive _heli && canMove _slick} do {sleep 1};
if (!canMove _slick && canMove _heli) exitWith {};
_base = _heli getVariable "NORRN_heloGoTo_basePos";
while {(getPos _heli select 2) > 5} do {sleep 1};
// Notify player of damage to escort
if (local _commandingUnit) then 
{
	titleText [Nor_HT_TT2, "Plain Down", 0.3]
} else { 
	Nor_HT_TT = [_commandingUnit, Nor_HT_TT2];
	publicVariable "Nor_HT_TT";
};
if (canMove _slick) then
{
	_slick disableAI "TARGET";
	_slick setBehaviour "CARELESS";
	_slick setCombatMode "BLUE";
	_slick doWatch objNull;
};
sleep 5;
// Delete heli and crew once it reaches the ground
if (!NORRN_H_keepOldCrew) then {{if (!isplayer _x) then {deleteVehicle _x}} forEach _crew};
sleep 1; 
if (!NORRN_H_keepOldHeli) then {deleteVehicle _heli}; 
_heli = objNull;
sleep 1; 
if (NORRN_aerialTaxiRespawnOff) exitWith {};
//Respawn new heli
_new_heli = _type createVehicle (getPos _base);
waitUntil {!isNull _new_heli};
_new_heli setPos getPos _base;

// Notify player that new chopper has respawned
if (local _commandingUnit) then 
{
	titleText [Nor_HT_TT3, "Plain Down", 0.3]
} else {
	Nor_HT_TT = [_commandingUnit, Nor_HT_TT3];
	publicVariable "Nor_HT_TT";
};
// Name new heli
_new_heli setVehicleVarName _name;
_new_heli call compile format ["%1=_This ; PublicVariable '%1'",_name];
// Create crew
_group = createGroup _side;
for [{ _loop = 0 },{ _loop < count  _crew},{ _loop = _loop + 1}] do
{	
	_typeNew = _type_crew select _loop;
	_assignedNew = _assignedRole_crew select _loop;
	_unit = _typeNew createUnit [(getPos _base), _group];
	sleep 1;
};
sleep 2;
// Crew board new heli
_group reveal _new_heli;
_unitsGroup  = units _group;
for [{ _loop = 0 },{ _loop < count  _unitsGroup},{ _loop = _loop + 1}] do
{	
	_guy = _unitsGroup select _loop;
	_assignedNew = _assignedRole_crew select _loop;
	if (_loop == 0) then {_guy moveInDriver _new_heli} else
	{_guy moveInTurret [_new_heli, [(_loop - 1)]]};
	sleep 0.1;
};
// Reset  heli variables
_new_heli setVariable ["NORRN_heloGoTo_basePos", _base, true];
_new_heli setVariable ["NORRN_aerialTaxi", _aerialTaxi, false];
//_new_heli setVariable ["NORRN_aerialTaxiRTB", false, true];
_aerialTaxi setVariable ["NORRN_H_escort", _new_heli, false];
if (_slick distance _new_heli > 400 && !(_aerialTaxi getVariable "NORRN_aerialTaxiRTB")) then 
{
	if !(_new_heli in units (group _slick)) then {[_new_heli] joinSilent group _slick};	
	sleep 0.1;
	// escort sets slick as leader and formation
	(group _slick) selectLeader _slick;
	(group _slick) setFormation "Line";
	_new_heli flyInHeight 40;
	sleep 5;
	if !(_aerialTaxi getVariable "NORRN_aerialTaxiRTB") then {_new_heli doMove (getPos _slick)};
};
//Added for respawning heli
[_new_heli,_slick] spawn Nor_HT_S19;





 




 
