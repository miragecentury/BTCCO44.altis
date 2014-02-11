


if (isClass(configFile >> "CfgPatches" >> "ace_main")) then 
{
	haloed = true;
	Titletext ["Click on the map where you'd like to HALO.","plain",1];
	//hint "Click on the map where you'd like to HALO.";
	onMapSingleClick "player setPos _pos; [player] execVM 'scripts\para\halo.sqf'; haloed = false; hint 'Close the map and don''t forget to open your chute!'";
	waitUntil{!haloed};
	onMapSingleClick "";
	
} else {
		titleText ["","PLAIN"];
		haloed = true;
		Titletext ["Left Click on the map where you'd like to HALO.","plain",1];
		//onMapSingleClick "player setPos _pos; [player, BTC_halo_height] execVM 'scripts\para\halo.sqf'; haloed = false; titleText ['Close the map and dont forget to open your chute!','BLACK FADED'];";
		onMapSingleClick "player setPos _pos; [player, BTC_halo_height] execVM 'A3\functions_f\misc\fn_halo.sqf'; haloed = false; titleText ['Close the map and dont forget to open your chute!','BLACK FADED'];";
		waitUntil{!haloed};
		onMapSingleClick "";
		sleep 3;
		titleText ["","PLAIN"];
		//"mrk_halo" setMarkerPos getPos Player;
		//if (BTC_debug >= 1) then {onMapSingleClick "player setpos _pos";};

		};




