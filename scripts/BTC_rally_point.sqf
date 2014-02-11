///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

BTC_RALLY_DEPLOYED = false; publicVariable "BTC_RALLY_DEPLOYED";
_target = _this select 0;
_caller = _this select 1;
_playUID= getPlayerUID _caller;
BTC_rp_owner = _playUID; publicVariable "BTC_rp_owner";

_caller playMove "AinvPknlMstpSnonWnonDnon_medic_1"; sleep 3; 
_caller switchMove "AinvPknlMstpSnonWnonDnon_medic_1"; sleep 4;

if (isNil "BTC_rally_point") then {BTC_rally_point = _target addaction ["<t color='#CC9900'>TAKE RALLY POINT</t>","scripts\BTC_rally_point.sqf",[],7,true,true];};

"mrk_rally_point" setMarkerAlpha 0;

if (rank _caller == "MAJOR") then
{
	RALLY_POINT setPosATL [0,0,0]; 
	RALLY_CALLER = _caller addaction 
	[
		"<t color='#CC9900'>DEPLOY RALLY POINT</t>",
		"
		_caller = _this select 0;
		_caller playMove 'AinvPknlMstpSnonWnonDnon_medic_1'; sleep 3; 
		_caller switchMove 'AinvPknlMstpSnonWnonDnon_medic_1'; sleep 5;
		_call_vect = getDir _caller; 
		RALLY_POINT setPosATL [	(getPosATL _caller select 0)+ 3*sin((_call_vect)),(getPosATL _caller select 1)+ 3*cos((_call_vect)),(getPosATL _caller select 2)];
		BTC_RALLY_DEPLOYED = true; publicVariable 'BTC_RALLY_DEPLOYED';'mrk_rally_point' setMarkerPos getPos RALLY_POINT; 'mrk_rally_point' setMarkerAlpha 1; 
		_caller sideChat 'Rally point deployed'; _caller removeAction RALLY_CALLER;
		",[],7,true,true 
	];
};

if (isNil "BTC_FLAG_ACT") then 
{
	BTC_FLAG_ACT = BTC_base_flag_west addaction 
	[
	"<t color='#CC9900'>MOVE TO RALLY POINT</t>",
	"
	titletext ['Moving to Rally point...','BLACK FADED',3]; sleep 4;
	(_this select 1) setPosATL [(getPosATL RALLY_POINT select 0)- 2*sin((random 359)),(getPosATL RALLY_POINT select 1)- 2*cos((random 359)),(getPosATL RALLY_POINT select 2)];
	titletext ['You are at Rally point','BLACK IN',4];
	"
	,[],7,true,false,"","BTC_RALLY_DEPLOYED"
	];
};







