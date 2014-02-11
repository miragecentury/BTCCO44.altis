// addHeliDepartAction.sqf
// © OCTOBER 2011 - norrin
private ["_unit","_heli"];
_unit = _this select 0;
if(!local _unit) exitWith {};
_heli = player getVariable "NORRN_taxiHeli";
sleep 1;
while {!(player in crew _heli)} do {sleep 0.1}; 
NORRN_getTheFoutOfDodge_action = _heli addAction ["Give chopper all clear for takeoff", "scripts\heloGoTo\heliDepartAction.sqf",[_unit, _heli],1, false];
hint "Give chopper all clear for takeoff";
while {(getPos _heli select 2) < 20} do {sleep 0.1};
NORRN_heliGoToRTB_action = _heli addAction  ["Return to base", "scripts\heloGoTo\RTBaction.sqf", _heli];
_heli setVariable ["NORRN_H_destChosen", false, true];