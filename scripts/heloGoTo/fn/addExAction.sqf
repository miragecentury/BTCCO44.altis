// addExAction.sqf
// © OCTOBER 2011 - norrin
private ["_unit", "_pos", "_heli"];
_unit = _this select 0; 
if (!local _unit) exitWith {};
NORRN_heloExtractMapClick = true;
NORRN_heloGotoMapClick = true;
sleep 2;
_pos = getPos _unit;
_heli = player getVariable "NORRN_taxiHeli";
_heli setVariable ["NORRN_H_commandingUnit", player, true];
sleep 2;
if (player != leader group player) exitWith {}; 
if (vehicle player == player) then {hint "Extraction action added"};
NORRN_heliExtract_action = player addAction ["<t color='#ffff00'>CALL CHOPPER EXTRACTION</t>", "scripts\heloGoTo\extractionMapClick.sqf",player,1, false, true,"","vehicle player == player"];
[_unit] spawn Nor_HT_S16;
[_unit] spawn Nor_HT_S17;
sleep 2;
hint "";
while {!(_heli getVariable "NORRN_H_destChosen") &&  NORRN_heloExtractMapClick && NORRN_heloGotoMapClick && alive player && alive _heli && !(_heli getVariable "NORRN_aerialTaxiDestroyed")} do {sleep 0.2};
player removeAction NORRN_heliExtract_action;
sleep 2;
hintSilent "";