// heliDepartLandAction.sqf
// © OCTOBER 2011 - norrin
private ["_array","_unit","_heli"];
_array = _this select 3;
_unit = _array select 0;
_heli = _array select 1;
player removeAction NORRN_getTheFoutOfDodge_action;
// Added for stayPut function
_heli setVariable ["NORRN_heliStayPut", false, true];
// Send take off message to players
Nor_HT_M = [objNull, Nor_HT_M3];
publicVariable "Nor_HT_M";
hint Nor_HT_M3;
// Send chopper back to base
if (local _heli) then 
{
	[_heli] spawn Nor_HT_S14;
} else {
	Nor_HT_S = [_heli, Nor_HT_S14];	
	publicVariable "Nor_HT_S";
};
