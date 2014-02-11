////////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   ///
/// Visit us: www.blacktemplars.altervista.org   ///
////////////////////////////////////////////////////

if (isServer) then 
{
	_enemy = kidnap_officer;
	_enemy action ["DROPWEAPON", _enemy, primaryWeapon _enemy];
	sleep 5;
	_enemy playMove "AmovPercMstpSnonWnonDnon_Ease";
	removeallWeapons _enemy;
	_enemy setCaptive true;
	_enemy disableAI "ANIM";
	_enemy disableAI "MOVE";
	_enemy setCaptive true;
	
	waitUntil {sleep 3; (_enemy distance (getMarkerPos "jail_mrk") < 15)};
	_enemy setCombatMode "BLUE";
	_enemy setBehaviour "SAFE";
	_enemy doMove GetMarkerPos "jail_mrk";
	waitUntil {sleep 1; (_enemy distance (getMarkerPos "jail_mrk") < 5)};
	[_enemy] join grpNull;
	_enemy playmove "AmovPercMstpSnonWnonDnon_Ease"; _enemy setCaptive true;
	_enemy disableAI "ANIM"; _enemy disableAI "MOVE";
};

