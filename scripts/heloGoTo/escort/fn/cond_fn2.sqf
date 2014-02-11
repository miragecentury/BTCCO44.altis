// cond_fn2.sqf
// © OCTOBER 2011 - norrin
private ["_escort","_heli","_var"];
_escort = _this select 0;
_heli 	= _this select 1;
_var 	= false;
if (canMove _heli && canMove _escort && !(_heli getVariable "NORRN_H_destChosen") && !(_heli getVariable "NORRN_aerialTaxiRTB")) then {_var = true};
_var