// resetCommandingUnit.sqf
// © OCTOBER 2011 - norrin
private ["_unit","_heli"];
_unit = _this select 0;
if (!local _unit) exitWith {};
sleep 2;
while {alive(player getVariable "NORRN_taxiHeli")} do
{
	if (!alive player) then 
	{
		_heli = player getVariable "NORRN_taxiHeli";
		while {!alive player} do {sleep 1};
		_heli setVariable ["NORRN_H_commandingUnit", player, true];
	};
	sleep 0.5;
};
