	// by =BTC= Muttley http://www.blacktemplars.altervista.org/.	
	////////////////////////////////////
	// Assegnazione tasks lato client //
	////////////////////////////////////
	/*
	// http://forums.bistudio.com/showthread.php?147677-ArmA-3-Editor-Inbuilt-Editor-Tasks
	[player, "objTask1", ["This is the Task Description", "Task Title", "taskMarkerName"], objNull, true] call BIS_fnc_taskCreate; 
	// So this would assign to the player objTask 1, with the task description "This is the Task Description", 
	// the title "Task Title", associated with the marker "taskMarkerName", with no associated destination object (objNull), 
	// and make it the current task (true).
	*/
	
	// le variabili BTC_start_mission_X vengono pubblicate dallo script MissionsX
	// quindi a JIP vengono passate al player
	
	diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";
	diag_log (format["PLAYER TASKS START"]);
	
	_track = ["RadioAmbient2","LeadTrack01_F","Track01_Proteus","Track03_OnTheRoad","LeadTrack03_F","Track05_Underwater2","Track04_Underwater1","Track02_SolarPower","LeadTrack04a_F","LeadTrack05_F","LeadTrack01b_F","AmbientTrack01a_F","AmbientTrack04_F"];
	BTCM_radio_mess	 = _track select 0;
	BTCM_music_tsk_1 = _track select 1;
	BTCM_music_tsk_2 = _track select 2;
	BTCM_music_tsk_3 = _track select 3;
	BTCM_music_tsk_4 = _track select 4;
	BTCM_music_tsk_5 = _track select 5;
	BTCM_music_tsk_6 = _track select 6;
	BTCM_music_tsk_7 = _track select 7;
	BTCM_music_tsk_8 = _track select 8;
	BTCM_music_tsk_9 = _track select 9;
	BTCM_music_tsk_10 = _track select 10;
	BTCM_music_tsk_11 = _track select 11;
	BTCM_music_tsk_12 = _track select 12;
	
	waitUntil {player == player};
	

			
	_set_task_info = [] spawn 
	{
		[
			player, // Task owner(s)
			"task_info", // Task ID (used when setting task state, destination or description later)
			[
			"Use radio to call for a mission. Hit 002 on keyborad, to call for a new mission.","Call for a mission", "Call for a mission" ], // Task description
			objNull, //getMarkerPos "mrk01", // Task destination
			true // true to set task as current upon creation
		] call BIS_fnc_taskCreate;
		waitUntil {sleep 1; !(isNil ("BTC_mission_request"))};
		waitUntil {sleep 1; (BTC_mission_request)};
		_task_info = ["task_info", player] call BIS_fnc_taskReal;
		_task_info setTaskState "Succeeded";
	};

			_message = [] spawn 
			{	
				waitUntil {sleep 1; !(isNil ("BTC_All_task_end"))};
				while {!(BTC_All_task_end)}
				do 
				{ 
				waitUntil {sleep 1; !(side_chose_init)}; 
				player Sidechat "HQ: To all squads, please wait for next mission";
				waitUntil {sleep 1; (side_chose_init)}; 
				};
			};
			
			
//////////////////////////////////////////// START TASKS ///////////////////////////////////////////
	
	_set_task1 = [] spawn 
	{
		//waituntil {sleep 5; (!(isNil "BTC_start_mission_1"))};
		waitUntil {sleep 4; (BTC_start_mission_1)};
			[
			player, // Task owner(s)
			"task1", // Task ID (used when setting task state, destination or description later)
			["1. Clear the area from enemies, the area it's marked on <marker name='mrk01'>''map''.</marker>","Clear the area from enemies!", "Clear the area from enemies!" ], // Task description
			getMarkerPos "mrk01", // Task destination
			true // true to set task as current upon creation
			] call BIS_fnc_taskCreate;
			//playsound "IncomingChallenge";
			"mrk_miss_1" setMarkerAlpha 1; "mrk01" setMarkerAlpha 1;
	};
	
		_end_task1 = [] spawn 
		{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss1")))};
				waitUntil {sleep 4; (BTC_start_mission_1)&&(BTC_end_mission_1)};
				if !(skip_miss1)
				then 
				{
					//["task1","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task1", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					playMusic BTCM_music_tsk_1;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
					if !(isNil ("task1")) then {task1 setTaskState "Succeeded";};
				} 
				else 
				{
					//["task1","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task1", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
					if !(isNil ("task1")) then {task1 setTaskState "Canceled";}; 
				};
		};
	
// ====================================================================================
	
	
	_set_task2 = [] spawn 
	{
		//waituntil {sleep 5; (!(isNil BTC_start_mission_2))};
		waitUntil {sleep 4; (BTC_start_mission_2)};
		[
		player, // Task owner(s)
		"task2", // Task ID (used when setting task state, destination or description later)
		[
		"2. Find the enemy camp. Clear the area from enemies and destroy all sensitive military targets! The area it's marked on <marker name='mrk02'>''map''.</marker>",
		"Find enemy camp!",	"Find enemy camp!"], // Task description
		getMarkerPos "mrk02", // Task destination
		true // true to set task as current upon creation
		] call BIS_fnc_taskCreate;
		"mrk_miss_2" setMarkerAlpha 1; "mrk02" setMarkerAlpha 1;
		//playsound "IncomingChallenge";
	};
			_end_task2 = [] spawn 
			{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss2")))};
				waitUntil {sleep 4; (BTC_start_mission_2)&&(BTC_end_mission_2)};
				if !(skip_miss2)
				then 
				{
					//["task2","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task2", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					if !(isNil ("task2")) then {task2 setTaskState "Succeeded";};
					playMusic BTCM_music_tsk_2;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
				} 
				else 
				{
					//["task2","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task2", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task2")) then {task2 setTaskState "Canceled";};
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
				};
			};

	
// ====================================================================================
	
	
	_set_task3 = [] spawn 
	{
		//waituntil {sleep 5; (!(isNil BTC_start_mission_3))};
		waitUntil {sleep 4; (BTC_start_mission_3)};
		[
		player, // Task owner(s)
		"task3", // Task ID (used when setting task state, destination or description later)
		[
		"3. Destroy vehicles patrolling the area and clear the area from enemies.! The area it's marked on <marker name='mrk03'>''map''.</marker>",
		"Destroy motorized patrol!","Destroy motorized patrol!"], // Task description
		getMarkerPos "mrk03", // Task destination
		true // true to set task as current upon creation
		] call BIS_fnc_taskCreate;
		"mrk_miss_3" setMarkerAlpha 1; "mrk03" setMarkerAlpha 1;
		//playsound "IncomingChallenge";
	};
	
			_end_task3 = [] spawn 
			{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss3")))};
				waitUntil {sleep 4; (BTC_start_mission_3)&&(BTC_end_mission_3)};
				if !(skip_miss3)
				then 
				{
					//["task3","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task3", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					if !(isNil ("task3")) then {task3 setTaskState "Succeeded";};
					playMusic BTCM_music_tsk_3;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
				} 
				else 
				{
					//["task3","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task3", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task3")) then {task3 setTaskState "Canceled";};
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
				};
			};

// ====================================================================================	
	

	_set_task4 = [] spawn 
	{
		waitUntil {sleep 4; (BTC_start_mission_4)};
		[
		player, // Task owner(s)
		"task4", // Task ID (used when setting task state, destination or description later)
		[
		"4. A group of recon unit has been spotted. Eliminate the Recon patrolling the area. The area it's marked on <marker name='mrk04'>''map''.</marker>",
		"Eliminate the Recons!","Eliminate the Recons!"], // Task description
		getMarkerPos "mrk04", // Task destination
		true // true to set task as current upon creation
		] call BIS_fnc_taskCreate;
		"mrk_miss_4" setMarkerAlpha 1; "mrk04" setMarkerAlpha 1;
		//playsound "IncomingChallenge";
	};
	
	
			_end_task4 = [] spawn 
			{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss4")))};
				waitUntil {sleep 4; (BTC_start_mission_4)&&(BTC_end_mission_4)};
				if !(skip_miss4)
				then 
				{
					//["task4","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task4", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					if !(isNil ("task4")) then {task4 setTaskState "Succeeded";};
					playMusic BTCM_music_tsk_4;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
				} 
				else 
				{
					//["task4","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task4", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task4")) then {task4 setTaskState "Canceled";};
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
				};
			};
	
// ====================================================================================	
	
	
	_set_task5 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_5)};
	
	[
	player, // Task owner(s)
	"task5", // Task ID (used when setting task state, destination or description later)
	[
	"5. Put down the enemy's communications system, blow up all comunications towers you'll find at marked <marker name='mrk05'>''area''.</marker>",
	"Destroy enemy radio tower!",
	"Destroy enemy radio tower!"], // Task description
	getMarkerPos "mrk05", // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	"mrk_miss_5" setMarkerAlpha 1; "mrk05" setMarkerAlpha 1;
	//playsound "IncomingChallenge";
	};
	
	
			_end_task5 = [] spawn 
			{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss5")))};
				waitUntil {sleep 4; (BTC_start_mission_5)&&(BTC_end_mission_5)};
				if !(skip_miss5)
				then 
				{
					//["task5","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task5", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					if !(isNil ("task5")) then {task5 setTaskState "Succeeded";};
					playMusic BTCM_music_tsk_5;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
				} 
				else 
				{
					//["task5","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task5", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task5")) then {task5 setTaskState "Canceled";};
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
				};
			};
	
// ====================================================================================	
	
	
	_set_task6 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_6)};
	
	[
	player, // Task owner(s)
	"task6", // Task ID (used when setting task state, destination or description later)
	[
	"6. Destroy all enemy ships in the harbor! Be careful, the port is protected by mines, and is accessible only by sea or air! The area it's marked on <marker name='mrk06'>''map''.</marker>",
	"Destroy enemy boats!",
	"Destroy enemy boats!"], // Task description
	getMarkerPos "mrk06", // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	"mrk_miss_6" setMarkerAlpha 1; "mrk06" setMarkerAlpha 1;
	//playsound "IncomingChallenge";
	};
	
	_end_task6 = [] spawn 
		{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss6")))};
				waitUntil {sleep 4; (BTC_start_mission_6)&&(BTC_end_mission_6)};
				if !(skip_miss6)
				then 
				{
					//["task6","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task6", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					if !(isNil ("task6")) then {task6 setTaskState "Succeeded";};
					playMusic BTCM_music_tsk_6;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
				} 
				else 
				{
					//["task6","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task6", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task6")) then {task6 setTaskState "Canceled";};
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
				};
		};
	
// ====================================================================================	
	
	
	_set_task7 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_7)};
	[
	player, // Task owner(s)
	"task7", // Task ID (used when setting task state, destination or description later)
	[
	"7. A pilot was shot down during a patrol, rescue the pilot! Bring the pilot to the <marker name='jail_mrk'>''Detencion Center''</marker> once rescued, we must interrogate him. Area it's marked on the <marker name='mrk07'>''map''.</marker>",
	"Rescue the hostage!",
	"Rescue the hostage!"], // Task description
	getMarkerPos "mrk07", // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	"mrk_miss_7" setMarkerAlpha 1; "mrk07" setMarkerAlpha 1;
	//playsound "IncomingChallenge";
	
		_nul = [] spawn 
		{ 
			waitUntil {Sleep 5; (({ (_x == player) && (isPlayer _x) && ((_x distance pilot_to_rescue) < 5)} count allUnits) > 0)};
			If (Alive pilot_to_rescue) 
			then {_BTC_action = pilot_to_rescue addaction ["<t color='#CC9900'>Follow me!</t>","missions\follow.sqf",[],7,true,false,"","!(BTC_end_mission_7)"];};
			waitUntil {sleep 4; (BTC_start_mission_7)&&(BTC_end_mission_7)};
			If (Alive pilot_to_rescue) then 
			{ 
				[pilot_to_rescue] join grpNull; 
				waitUntil {Sleep 5; (({ (_x == player) && (isPlayer _x) && ((_x distance pilot_to_rescue) < 200)} count allUnits) < 1)};
				deleteVehicle pilot_to_rescue;
			};
		};
	};
	
	// End task
	_task7 = [] spawn 
	{
		waitUntil {sleep 4; (BTC_start_mission_7)&&(BTC_end_mission_7)};
		if ((pilot_rescued) && !(skip_miss7))
		then 
		{
			_task = ["task7", player] call BIS_fnc_taskReal;
			_task setTaskState "Succeeded";
			if !(isNil ("task7")) then {task7 setTaskState "Succeeded";};
			["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification; 
			playMusic BTCM_music_tsk_7;
		};
		
			if (!(pilot_rescued) && !(skip_miss7)) 
			then 
			{
				_task = ["task7", player] call BIS_fnc_taskReal;
				_task setTaskState "FAILED";
				if !(isNil ("task7")) then {task7 setTaskState "FAILED";};
				["taskFailed",["","MISSION FAILED THE PILOT IS DEAD"]] call bis_fnc_showNotification; 
				playMusic BTCM_radio_mess;
			};
		
				if (!(pilot_rescued) && (skip_miss7))
				then 
				{
					_task = ["task7", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task7")) then {task7 setTaskState "Canceled";};
					["taskCanceled",["","The pilot has seen all Rambo's movies, he would manage this!"]] call bis_fnc_showNotification; 
					playMusic BTCM_radio_mess; pilot_to_rescue setDamage 1;
				}; 
	};
	
// ====================================================================================	
	
	
	_set_task8 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_8)};
	[
	player, // Task owner(s)
	"task8", // Task ID (used when setting task state, destination or description later)
	[
	"8. A mortars site has been noticed by our patrol in the marked area. Find and eliminates the mortars. The approximate area is marked on the <marker name='mrk08'>''map''.</marker>",
	"Eliminates the mortars!",
	"Eliminates the mortars!"], // Task description
	getMarkerPos "mrk08", // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	"mrk_miss_8" setMarkerAlpha 1; "mrk08" setMarkerAlpha 1;
	//playsound "IncomingChallenge";
	};
	
		_end_task8 = [] spawn 
		{
				// End task
				//waituntil {sleep 5; (!(isNil ("skip_miss8")))};
				waitUntil {sleep 4; (BTC_start_mission_8)&&(BTC_end_mission_8)};
				if !(skip_miss8)
				then 
				{
					//["task8","SUCCEEDED",false,true] call BIS_fnc_taskSetState;
					_task = ["task8", player] call BIS_fnc_taskReal;
					_task setTaskState "Succeeded";
					if !(isNil ("task8")) then {task8 setTaskState "Succeeded";};
					playMusic BTCM_music_tsk_8;
					["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification;
				} 
				else 
				{
					//["task8","Canceled",false,true] call BIS_fnc_taskSetState;
					_task = ["task8", player] call BIS_fnc_taskReal;
					_task setTaskState "Canceled";
					if !(isNil ("task8")) then {task8 setTaskState "Canceled";};
					playMusic BTCM_radio_mess;
					["TaskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification;
				};
		};
	
// ====================================================================================		
	
	
	_set_task9 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_9)};
	[
	player, // Task owner(s)
	"task9", // Task ID (used when setting task state, destination or description later)
	[
	"9. Find and kill the enemy Officer, an informant told us that might be in the area indicated to dive! The approximate area is marked on the <marker name='mrk09'>''map''.</marker>",
	"Kill the Officer!",
	"Kill the Officer!"], // Task description
	getMarkerPos "mrk09", // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	"mrk_miss_9" setMarkerAlpha 1; "mrk09" setMarkerAlpha 1;
	//playsound "IncomingChallenge";
	};
	
		// End task
		_task9 = [] spawn 
		{
			waitUntil {sleep 4; (BTC_start_mission_9)&&(BTC_end_mission_9)};
			if (!(skip_miss9) && !(Alive diver_officer))
			then 
			{
				_task = ["task9", player] call BIS_fnc_taskReal;
				_task setTaskState "Succeeded";
				if !(isNil ("task9")) then {task9 setTaskState "Succeeded";};
				["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification; 
				playMusic BTCM_music_tsk_9;
			};
			
				if (!(skip_miss9) && (Alive diver_officer)) 
				then 
				{
					_task = ["task9", player] call BIS_fnc_taskReal;
					_task setTaskState "FAILED";
					if !(isNil ("task9")) then {task9 setTaskState "FAILED";};
					["taskFailed",["","MISSION FAILED THE TARGET ESCAPE"]] call bis_fnc_showNotification; 
					playMusic BTCM_radio_mess;
				};
			
			
					if (skip_miss9) 
					then 
					{
						_task = ["task9", player] call BIS_fnc_taskReal;
						_task setTaskState "Canceled";
						if !(isNil ("task9")) then {task9 setTaskState "Canceled";};
						["taskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification; 
						playMusic BTCM_radio_mess;
					}; 
		
		};

// ====================================================================================
	
	
	_set_task10 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_10)};
	[
	player, // Task owner(s)
	"task10", // Task ID (used when setting task state, destination or description later)
	[
	"10. Someone will have a meeting with high rank enemy commander, he will reveal to the enemy important info about movements of our troops. Find an kill the informer. The area it's well protected so be careful stealth approach it's raccomented, if the informant is aware of your presence could escape. The approximate area is marked on the <marker name='mrk10'>''map''.</marker>",
	"Kill the informer!",
	"Kill the informer!"], // Task description
	getMarkerPos "mrk10", // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	"mrk_miss_10" setMarkerAlpha 1; "mrk10" setMarkerAlpha 1;
	//playsound "IncomingChallenge";
	};
	
		// End task
		_task10 = [] spawn 
		{
			waitUntil {sleep 4; (BTC_start_mission_10)&&(BTC_end_mission_10)};
			if (!(Alive the_informer) && !(skip_miss10))
			then 
			{
				_task = ["task10", player] call BIS_fnc_taskReal;
				_task setTaskState "Succeeded";
				if !(isNil ("task10")) then {task10 setTaskState "Succeeded";}; 
				["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification; 
				playMusic BTCM_music_tsk_10;
			};
	
				if ((Alive the_informer) && !(skip_miss10))  
				then 
				{
					_task = ["task10", player] call BIS_fnc_taskReal;
					_task setTaskState "FAILED";
					if !(isNil ("task10")) then {task10 setTaskState "FAILED";}; 
					["taskFailed",["","MISSION FAILED THE TARGET ESCAPE"]] call bis_fnc_showNotification; 
					playMusic BTCM_radio_mess;
				};
	
					if (skip_miss10) 
					then 
					{
						_task = ["task10", player] call BIS_fnc_taskReal;
						_task setTaskState "Canceled";
						if !(isNil ("task10")) then {task10 setTaskState "Canceled";}; 
						["taskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification; 
						playMusic BTCM_radio_mess;
					};
		};

// ====================================================================================
	
	
	_set_task11 = [] spawn {
	waitUntil {sleep 4; (BTC_start_mission_11)};
	[
	player, // Task owner(s)
	"task11", // Task ID (used when setting task state, destination or description later)
	[
	"11. One of our informant has told us that an enemy convoy is about to start in the south of the island. 
	The convoy headed north to supply ammunition to the enemy troops. 
	Locate and destroy the whole convoy.",
	"Destroy the convoy!","Destroy the convoy!"], // Task description
	objNull, // Task destination
	true // true to set task as current upon creation
	] call BIS_fnc_taskCreate;
	//playsound "IncomingChallenge";
	};
	
	// End task
	_task11 = [] spawn 
	{
			waitUntil {sleep 4; (BTC_start_mission_11)&&(BTC_end_mission_11)};
			if (!(side_conv_end) && !(skip_miss11))
			then 
			{
				_task = ["task11", player] call BIS_fnc_taskReal;
				_task setTaskState "Succeeded";
				if !(isNil ("task11")) then {task11 setTaskState "Succeeded";}; 
				["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification; 
				playMusic BTCM_music_tsk_10;
			};
				
				if ((side_conv_end) && !(skip_miss11))  
				then 
				{
					_task = ["task11", player] call BIS_fnc_taskReal;
					_task setTaskState "FAILED";
					if !(isNil ("task11")) then {task11 setTaskState "FAILED";}; 
					["taskFailed",["","MISSION FAILED CONVOY REACH DESTINATION!"]] call bis_fnc_showNotification; 
					playMusic BTCM_radio_mess;
				};
	
					if (skip_miss11) 
					then 
					{
						_task = ["task11", player] call BIS_fnc_taskReal;
						_task setTaskState "Canceled";
						if !(isNil ("task11")) then {task11 setTaskState "Canceled";}; 
						["taskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification; 
						playMusic BTCM_radio_mess;
					};
	
	};

// ====================================================================================

	
	
	_set_task12 = [] spawn 
	{
		waitUntil {sleep 4; (BTC_start_mission_12)};
		[
		player, // Task owner(s)
		"task12", // Task ID (used when setting task state, destination or description later)
		[
		"12. Kidnap the enemy Officer, we want him alive to interrogate him and get valuable information. 
		Once captured bring it to the <marker name='jail_mrk'>''Detencion Center''</marker> for interrogation. 
		The approximate area is marked on the <marker name='mrk12'>''map''.</marker>",
		"Kidnap enemy Officer!","Kidnap enemy Officer!"], // Task description
		getMarkerPos "mrk12", // Task destination
		true // true to set task as current upon creation
		] call BIS_fnc_taskCreate;
		"mrk_miss_12" setMarkerAlpha 1; "mrk12" setMarkerAlpha 1;
		//playsound "IncomingChallenge";
			_nul = [] spawn
			{
				waituntil {sleep 5; off_surrender};
				_gridPos = mapGridPosition kidnap_officer;
				if (Alive kidnap_officer) then 
				{
				sleep 5;
				player SideChat format["'Enemy Officer: OK, OK do not shoot me, I surrender! I'm at grid %1.';",_gridPos];
				hint format["'Enemy Officer: OK, OK do not shoot me, I surrender! I'm at grid %1.';",_gridPos];
				["TaskSucceeded",["","'Enemy Officer Surrender'"]] call bis_fnc_showNotification;
				_BTC_action = kidnap_officer addaction ["<t color='#CC9900'>Follow me!</t>","missions\follow.sqf",[],7,true,false,"","!(BTC_end_mission_12)"];
				};
				waitUntil {sleep 4; (BTC_start_mission_12)&&(BTC_end_mission_12)};
				If (Alive kidnap_officer) then 
				{ 
					[kidnap_officer] join grpNull; 
					waitUntil {Sleep 5; (({ (_x == player) && (isPlayer _x) && ((_x distance kidnap_officer) < 200)} count allUnits) < 1)};
					deleteVehicle kidnap_officer;
				};
			};
	};
	
	
	// End task
	_task12 = [] spawn 
	{
		waitUntil {sleep 4; (BTC_start_mission_12)&&(BTC_end_mission_12)};
		if ((kidnap_officer_jail) && !(skip_miss12))
		then 
			{
				_task = ["task12", player] call BIS_fnc_taskReal;
				_task setTaskState "Succeeded";
				if !(isNil ("task12")) then {task12 setTaskState "Succeeded";};  
				["TaskSucceeded",["","GOOD JOB!!! MISSION ACCOMPLISHED!!!"]] call bis_fnc_showNotification; 
				playMusic BTCM_music_tsk_10;
			};
		
			if (!(kidnap_officer_jail) && !(skip_miss12))  
			then 
				{
					_task = ["task12", player] call BIS_fnc_taskReal;
					_task setTaskState "FAILED";
					if !(isNil ("task12")) then {task12 setTaskState "FAILED";}; 
					["taskFailed",["","MISSION FAILED THE TARGET DIE"]] call bis_fnc_showNotification; 
					playMusic BTCM_radio_mess;
				};
		
					if (!(kidnap_officer_jail) && (skip_miss12)) 
					then 
					{
						_task = ["task12", player] call BIS_fnc_taskReal;
						_task setTaskState "Canceled";
						if !(isNil ("task12")) then {task12 setTaskState "Canceled";}; 
						["taskCanceled",["","Mission aborted!"]] call bis_fnc_showNotification; 
						playMusic BTCM_radio_mess;
					};
		
    };
	

// ====================================================================================
// ====================================================================================
// ====================================================================================


_set_task_end = [] spawn 
{
	waitUntil {sleep 4; (BTC_All_task_end)};
	["TaskAssigned",["","RETURN TO BASE!"]] call bis_fnc_showNotification; 
	playMusic BTCM_music_tsk_4;
	taskend = player createSimpleTask ["RETURN TO BASE!"];   
	taskend setSimpleTaskDescription ["RETURN TO BASE! No more missions for today, HQ over!","RETURN TO BASE!","RETURN TO BASE!"];     
};

_set_task_end_comp = [] spawn 
{
	waitUntil 
	{
		sleep 5; (all_miss_end) && 
		(BTC_end_mission_1) && (BTC_end_mission_2) && (BTC_end_mission_3) && 
		(BTC_end_mission_4) && (BTC_end_mission_5) && (BTC_end_mission_6) && 
		(BTC_end_mission_7) && (BTC_end_mission_8) && (BTC_end_mission_9) &&
		(BTC_end_mission_10)&& (BTC_end_mission_11) && (BTC_end_mission_12)
	}; 
		["TaskSucceeded",["","DUTY COMPLETE FOR TODAY!"]] call bis_fnc_showNotification; taskend setTaskState "Succeeded";
};



//diag_log (format["PLAYER TASKS END"]);
//diag_log "======================== 'SIDES PATROLS' by =BTC= MUTTLEY ========================";