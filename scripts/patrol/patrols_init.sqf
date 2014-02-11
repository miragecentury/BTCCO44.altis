///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};
waitUntil {sleep 3;(init_server_done)};
if (isServer) then 
{

if (BTC_patrols_inf == 1) then {{[_x] execVM "scripts\patrol\patrols_INF.sqf";} foreach ["sector_NW","sector_NE","sector_SW","sector_SE"];};// OK
if (BTC_patrols_veh == 1) then {{[_x] execVM "scripts\patrol\patrols_VEH.sqf";} foreach ["sector_NW","sector_NE","sector_SW","sector_SE"];};// OK
if (BTC_patrols_ship == 1) then {{[_x] execVM "scripts\patrol\patrols_SHIP.sqf";} foreach BTC_sea_miss_array}; 								// OK
if (BTC_patrols_air == 1) then {{[_x] execVM "scripts\patrol\patrols_AIR.sqf";}foreach ["sector_NW","sector_NE","sector_SW","sector_SE"];}; // OK
if (BTC_patrols_base_inf == 1) then {[] execVM "scripts\patrol\patrols_BASE.sqf"; }; 														// OK
if (BTC_patrols_base_stat == 1) then {[] execVM "scripts\patrol\patrols_BASE_S.sqf";}; 														// OK
if (BTC_patrols_fob == 1) then {{[_x] execVM "scripts\patrol\patrols_FOB.sqf";}foreach ["outpost","outpost_1","outpost_2","outpost_3","outpost_4"];}; // OK
if (BTC_civ_city == 1) then { {[_x] execVM "scripts\patrol\patrols_CIV.sqf";}foreach BTC_mrk_civ_citys; }; // TEST

}; // Fine parentesi isServer







