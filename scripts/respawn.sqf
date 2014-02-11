///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

if !(isDedicated) then
{
__player = _this select 0;
// Debug teleport
if (BTC_debug >= 1)	then {map_click = false; player addAction ["<t color='#DF0101'>Teleport ON/OFF</t>","scripts\deb_map_click.sqf"]; };

// Rally point, se il player con il RP muore prima di piazzarlo al respawn avra' ancora il RP.
if ((rank __player == "MAJOR")&&(getPlayerUID __player == BTC_rp_owner)&&(!isNil ("BTC_rp_owner"))&&!(BTC_RALLY_DEPLOYED)) then 
{
	RALLY_POINT setPosATL [0,0,0];
	RALLY__player = __player addaction 
	[
		"<t color='#CC9900'>DEPLOY RALLY POINT</t>",
		"
		__player = _this select 0;
		__player playMove 'AinvPknlMstpSnonWnonDnon_medic_1'; sleep 3;
		__player switchMove 'AinvPknlMstpSnonWnonDnon_medic_1'; sleep 5;
		_call_vect = getDir __player;
		RALLY_POINT setPosATL [(getPosATL __player select 0)+ 3*sin((_call_vect)),(getPosATL __player select 1)+ 3*cos((_call_vect)),(getPosATL __player select 2)];
		BTC_RALLY_DEPLOYED = true;  publicVariable 'BTC_RALLY_DEPLOYED';'mrk_rally_point' setMarkerPos getPos RALLY_POINT; 'mrk_rally_point' setMarkerAlpha 1; 
		__player sideChat 'Rally point deployed'; __player removeAction RALLY__player;
		",[],7,true,true 
	];
};

};














