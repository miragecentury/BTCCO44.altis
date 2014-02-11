// addHeliDepartLandAction.sqf
// © OCTOBER 2011 - norrin 
private ["_unit","_heli","_pilot"];
_unit = _this select 0;
if(!local _unit) exitWith {};
_heli = player getVariable "NORRN_taxiHeli";
sleep 1;
while {(player in crew _heli)} do {sleep 0.1}; 
NORRN_getTheFoutOfDodge_action = player addAction ["Give chopper all clear for takeoff", "scripts\heloGoTo\heliDepartLandAction.sqf",[_unit, _heli],1, false];
_pilot = driver _heli;
hint "Give chopper all clear for takeoff";
while {(getPos _heli select 2) < 5} do {sleep 0.1}; 
player switchMove "c7a_bravo_dovadeni3";
sleep 2;
player switchMove "";