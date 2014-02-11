///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

_hostage = _this select 0;
_caller  = _this select 1;
BTC_action =  [];

	// Allowing Suspect to move and change position// 
	if (side _hostage == BTC_friendly_side1) then {_hostage setCaptive false};
	if (side _hostage == BTC_enemy_side1) then {_hostage setCaptive true};
	_hostage stop false;
	_hostage setUnitPos "AUTO";
	_hostage enableAI "MOVE";
	_hostage enableAI "ANIM";
	_hostage playMove "AmovPercMstpSnonWnonDnon_Ease";
	[_hostage] joinsilent _caller; doStop _hostage;
	
	waitUntil {sleep 3; (_hostage distance (getMarkerPos "jail_mrk") < 10)};
	_hostage setCombatMode "BLUE";
	_hostage setBehaviour "SAFE";
	_hostage doMove GetMarkerPos "jail_mrk";
	waitUntil {sleep 3; (_hostage distance (getMarkerPos "jail_mrk") < 5)};
	
	[_hostage ] joinSilent grpNull;
	_house = nearestbuilding _hostage;				// Controlla le case vicino al pilota
	if ((_house distance _hostage) < 10) then 		// Se la casa è vicina 
	{
		_pos_H = 0;
		while { format ["%1", _house buildingPos _pos_H] != "[0,0,0]" } do {_pos_H = _pos_H + 1};
		_pos_H = _pos_H - 1;
		if (BTC_debug == 1) then {diag_log (format["House position quantity: %1",_pos_H]);};
		_hostage doMove (_house buildingPos _pos_H);
		
	} else {_hostage doMove GetMarkerPos "jail_mrk";};
	sleep 20;
	_hostage disableAI "MOVE";









