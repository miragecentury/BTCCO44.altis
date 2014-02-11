///////////////////////////////////////////////////
/// ® August 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil {(init_server_done)};
sleep 1;
	_leader = _this select 0;
	_grpid =0;
	// give this group a unique index
	TRACK_Instances = TRACK_Instances + 1;
	PublicVariableServer "TRACK_Instances";
	_grpid = TRACK_Instances;
	_grpidx = format["%1",_grpid];
	_grpname = format["%1_%2",(side _leader),_grpidx];
	_side = side _leader;
	_trackername = "";
	_destname = "";
	_markercolor = switch (side _leader) do
	{
		case west: {"ColorBLUFOR"};
		case east: {"ColorOPFOR"};
		case resistance: {"ColorIndependent"};
		case civilian: {"colorCivilian"};
		default {"ColorBlack"};
	};
	
	if (BTC_debug == 1) then
	{	
		while {(Alive _leader)} do
		{	
			If (vehicle _leader isKindOf "LandVehicle") THEN
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "o_motor_inf";
				_trackername setMarkerColor _markercolor;
				_trackername setMarkerText format["%1",_grpidx];
				_trackername setMarkerSize [0.65, 0.65];
			};
			
			If (vehicle _leader isKindOf "tank") THEN
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "o_motor_inf";
				_trackername setMarkerColor "ColorBlack";
				_trackername setMarkerText format["%1",_grpidx];
				_trackername setMarkerSize [0.65, 0.65];
			};
			
						
			If (vehicle _leader isKindOf "Air") THEN 
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				If (_leader isKindOf "UAV_01_base_F") 
				then {_trackername setMarkerType "b_uav";} 
				else {_trackername setMarkerType "b_air";};
				_trackername setMarkerColor _markercolor;
				_trackername setMarkerText format["%1",_grpidx];
				_trackername setMarkerSize [0.65, 0.65];
			}; 		
					
			If (vehicle _leader isKindOf "Ship") THEN 
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "c_ship";
				_trackername setMarkerColor _markercolor;
				_trackername setMarkerText format["%1",_grpidx];
				_trackername setMarkerSize [0.65, 0.65];
			};
			
			If (vehicle _leader isKindOf "Man") THEN 
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "mil_dot";
				_trackername setMarkerColor _markercolor;
				_trackername setMarkerText format["%1",_grpidx];
			};	
			if ((vehicle _leader isKindOf "O_Soldier_diver_base_F")||
				(vehicle _leader isKindOf "B_Soldier_diver_base_F")||
				(vehicle _leader isKindOf "I_Soldier_diver_base_F")||
				(vehicle _leader isKindOf "SDV_01_base_F"))  THEN 
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "mil_triangle";
				_trackername setMarkerColor "colorBlue";
				_trackername setMarkerText format["%1",_grpidx];
			};
			
			If (_leader isKindOf "MineBase") THEN 
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "mil_triangle";
				If (_leader isKindOf "UnderwaterMine") 
				then {_trackername setMarkerColor "ColorBlue";}
				else {_trackername setMarkerColor "ColorRed";};
				_trackername setMarkerSize [0.5, 0.5];
			};
			
			If (vehicle _leader isKindOf "StaticWeapon") THEN 
			{
				// Position
				_trackername=format["trk_%1",_grpidx];
				_markerobj = createMarker[_trackername,[0,0]];
				_markerobj setMarkerShape "ICON";
				_trackername setMarkerType "n_mortar";
				_trackername setMarkerColor _markercolor;
				_trackername setMarkerText format["%1",_grpidx];
			};	
		
		 _leader = _this select 0;
		 _trackername setMarkerPos getPos _leader; 
		 sleep 1; 
		 if !(Alive _leader) exitWith {deleteMarker _trackername;};
					
		};	
	
	};

	
	
	
	
	
	
	
	
	