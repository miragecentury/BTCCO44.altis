///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

if (isServer) then 
{
_id = _this select 0;
_pname = _this select 1;
_puid  = _this select 2;

if ((_puid == BTC_rp_owner)&&!(BTC_RALLY_DEPLOYED)) 
then {RALLY_POINT setPos GetMarkerPos "rally_mrk_base"; 
BTC_rally_point = RALLY_POINT addaction ["<t color='#CC9900'>TAKE RALLY POINT</t>","scripts\BTC_rally_point.sqf",[],7,true,true];};

};




