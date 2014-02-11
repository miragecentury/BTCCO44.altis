// cancelGotoAction.sqf
// OCTOBER 2011 - norrin
private ["_heli"];
_heli = _this select 3;
_heli removeAction NORRN_heliGoToCancel_action;
_heli setVariable ["NORRN_H_destChosen", false, true];
_heli setVariable ["NORRN_heloGoto_cancel", true, true];
_heli doMove getPos _heli;
NORRN_heliGoToRTB_action = _heli addAction  ["Return to base", "scripts\heloGoTo\RTBaction.sqf", _heli];


