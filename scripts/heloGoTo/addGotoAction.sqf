// addGotoAction.sqf
// © OCTOBER 2011 - norrin
private ["_unit","_heli"];
_unit = _this select 0;
_heli = vehicle _unit;
if (!local _unit || !(player in crew _heli) || player != (leader group player) || isplayer (driver _heli)) exitWith {}; 
while {(_heli getVariable "NORRN_H_destChosen") && (player in crew _heli)} do {sleep 1};
//added in case extraction chopper not defined in init.sqf 100210
_heli setVariable ["NORRN_H_commandingUnit", _unit, true];
player setVariable ["NORRN_taxiHeli", _heli, true];
NORRN_heliGoToLand_action = _heli addAction  ["Set chopper destination", "scripts\heloGoTo\landMapClick.sqf", [_heli, _unit]];
// Activate remove fastrope action script
while {(player in crew _heli)} do {sleep 0.5};
_heli removeAction NORRN_heliGoToLand_action;

