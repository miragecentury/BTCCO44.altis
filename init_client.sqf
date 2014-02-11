///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

if !(isDedicated) then
{	player sideChat "Player Initialization...";
	diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";
	diag_log (format["PLAYER INIT START"]);
	
	waitUntil {!isNull player};
	waitUntil {player == player};

	if (BTC_debug >= 1)	then {titletext ["","BLACK IN",3]; map_click = false; player addAction ["<t color='#DF0101'>Teleport ON/OFF</t>","scripts\deb_map_click.sqf"]; 1 fadeSound 1;} 
	else {[] execVM "MPintro.sqf";};
	call compile preprocessFile "BTC_fnc_client.sqf";
	call compile preprocessFile "BTC_ammo.sqf";	
	if !(player hasWeapon "ItemGPS") then {player addItem "ItemGPS", player assignItem "ItemGPS"};
	if !(player hasWeapon "NVGoggles") then {player addItem "NVGoggles", player assignItem "NVGoggles"};
	if !(player hasWeapon "Binocular") then {player addWeapon "Binocular", player assignItem "Binocular"};
	//player additem "muzzle_snds_H"; player assignItem "muzzle_snds_H"; //<<<<<<<<<<<<----------------------
	setViewDistance BTC_view_distance;
	setTerrainGrid BTC_terrain;
	[player,-50] execVM "scripts\BTC_deepgauge.sqf"; //Altimetro SUB
	
	if (BTC_debug == 0) then {waitUntil {(!isNil ("BTC_intro_fnsh"))};	BTC_intro_fnsh = false; publicVariable "BTC_intro_fnsh";};
	_nul = [] execVM "BTC_tasks.sqf";
	_skip_message = [] spawn 
	{	
		waitUntil {Sleep 1; (!isNil ("skip_var"))};
		while {(skip_var)} do 
		{
		if ((BTC_mission_request)&&!(BTC_All_task_end)) then 
		{
			player GlobalChat "HQ: Please wait for the next mission..."; 
			//[] spawn {["TaskAssigned",["","HQ: Please wait for orders!"]] call bis_fnc_showNotification;};  
		};
		sleep 1;
		};
	};
	if (rank player == "MAJOR") then {	player addEventhandler ["respawn", {_this execvm "scripts\respawn.sqf"}]; };
	player sideChat "Player Initialization Complete";
	
	diag_log (format["PLAYER INIT END"]);
	diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";
};	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
