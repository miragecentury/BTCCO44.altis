// cond_fn1.sqf
// © OCTOBER 2011 - norrin
private ["_escort","_heli","_var"];
_escort = _this select 0;
_heli 	= _this select 1;
_var 	= false;
if (canMove _escort && canMove _heli  && !(_heli getVariable "NORRN_heloGoto_cancel") && !(_heli getVariable "NORRN_aerialTaxiRTB") && !(_heli getVariable "NORRN_H_destChosen")) then {_var = true};
_var