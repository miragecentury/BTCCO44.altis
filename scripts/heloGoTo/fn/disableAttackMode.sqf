// disableAttackMode.sqf - Nor_HT_SS1
// © OCTOBER 2011 - norrin
private ["_heli","_escort"];
_heli 	= _this select 0; 
_escort = _this select 0; 
_heli disableAI "TARGET";
_heli setBehaviour "CARELESS";
_heli setCombatMode "BLUE";
_heli doWatch objNull;
_heli enableAttack false;
if (isNull _escort) exitWith {};
_escort disableAI "TARGET";	
_escort setBehaviour "CARELESS";
_escort setCombatMode "BLUE";
_escort doWatch objNull;
_escort enableAttack false;
_escort land "none";