// enableAttackMode.sqf - Nor_HT_S20
// © OCTOBER 2011 - norrin
private ["_heli"];
_heli = _this select 0;
_heli enableAI "TARGET";
_heli enableAI "AUTOTARGET";
_heli enableAI "MOVE";
_heli setCombatMode "RED";
_heli enableAttack true;
_heli setBehaviour "COMBAT";
