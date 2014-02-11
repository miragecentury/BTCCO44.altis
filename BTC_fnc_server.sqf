///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

waitUntil{!isnil "bis_fnc_init"};


//===========================================================================


BTC_find_pos =
{
private["_position","_rg1","_rg2","_Loc","_range","_px","_py","_Mpx","_Mpy","_result"];
_position = _this select 0; // marker,object

switch (typeName _position) do
{
	//case "ARRAY" :{_pos = _position; 				};
	case "STRING":{_pos = getMarkerPos _position; _angle = markerDir _position; };
	case "OBJECT":{_pos = position _position; 	  _angle = getDir _position; };
};
_rg1 = _pos select 0; // x size
_rg2 = _pos select 1; // y size

_Loc = "Land_Camping_Light_F" createVehicle _pos;
_Loc setDir _angle;
_range = 2 * (sqrt ((_rg1 * _rg1) + (_rg2 * _rg2)));
_px = _pos select 0;
_py = _pos select 1;
_MpX = _pX + (random _range) - (_range/2);
_MpY = _pY + (random _range) - (_range/2);
while {not ([_Mpx,_Mpy] in _Loc)} do
{
_MpX = _pX + (random _range) - (_range/2);
_MpY = _pY + (random _range) - (_range/2);
};

_result = [_MpX,_MpY];

deleteVehicle _Loc;

[_MpX,_MpY]
};

//===========================================================================

BTC_LandMine = 
{
	// _null = ["name_marker",radius, mine quantity, mine deepness, side know position] spawn BTC_underwaterMine;w
	// _null = ["mrk_1",110,100,50,-1.5,EAST] spawn BTC_underwaterMine; // "Marker",Max_dist,Min_dist,NumberQTY,Deep,Side
	private ["_spawn_zones","_max_rad","_min_rad","_layers","_space","_mine_side","_center_mrk","_pos","_mines","_attempts","_rad_buoy","_deg","_pos_buoy","_isWater","_mine","_mrk_mine","_posX","_posY","_new_pos"];
	_spawn_zones = _this select 0;	//Marker Area ""
	_max_rad 	= _this select 1;	//Max distance from center marker 55
	_min_tpy 	= _this select 2; 	//Type ""
	_layers		= _this select 3;	//Space between 
	_space	 	= _this select 4;	//Min space between layers
	_mine_side	= _this select 5;	
	_center_mrk  = getMarkerPos _spawn_zones;
	_pos 		 = [];
	
	_mines = 0;	_degr = 3 ; _nn = 0 + (random 359); _dist = _max_rad + _space; _numb = 360 / _degr;
	while {_mines < _layers} do
	{
		for "_i" from 0 to (_numb -1) do
		{
			_isWater = surfaceIsWater [((_center_mrk) select 0)-(_dist)*sin(_nn), ((_center_mrk) select 1)-(_dist)*cos(_nn), 0];
			if !(_isWater) then 
			{
				_mine = createMine [_min_tpy, [((_center_mrk) select 0)-(_dist)*sin(_nn), ((_center_mrk) select 1)-(_dist)*cos(_nn), 0], [], 0]; 
				_mine_side revealMine _mine; _mine setDir _nn;
				if (BTC_track) then {_spawn = [_mine] execVM "scripts\BTC_track_unit.sqf";};
			};
			_nn = _nn + _degr;
		};
		
		_dist = _dist + _space;
		_mines = _mines + 1;
		_nn = _nn + (_degr /2);
		if (_mines > _layers) exitWith {_dist};
	};	
	
	//Signals
	_degr_s = 5; _nn_s = 0; _sign = _dist + 0; _numb = 360 / _degr_s;
	for "_i" from 0 to (_numb) do
	{
		_isWater = surfaceIsWater [((_center_mrk) select 0)-(_sign)*sin(_nn_s), ((_center_mrk) select 1)-(_sign)*cos(_nn_s), 0];
		if !(_isWater) then 
		{
			_signal = ["Land_Sign_WarningUnexplodedAmmo_F","Land_Sign_Mines_F"] call BIS_fnc_selectRandom;
			_accura = createVehicle [_signal, [((_center_mrk) select 0)-(_sign)*sin(_nn_s),((_center_mrk) select 1)-(_sign)*cos(_nn_s),0], [], 0, "NONE"]; 
			_accura setDir _nn_s;
			if (BTC_track) then {_spawn = [_accura] execVM "scripts\BTC_track_unit.sqf";};
		};
		_nn_s = _nn_s + _degr_s;
	};
}; // parentesi fine

//===========================================================================
BTC_underwaterMine = 
{
	// _null = ["name_marker",radius, mine quantity, mine deepness, side know position] spawn BTC_underwaterMine;w
	// _null = ["mrk_1",110,100,50,-1.5,EAST] spawn BTC_underwaterMine; // "Marker",Max_dist,Min_dist,NumberQTY,Deep,Side
	private ["_spawn_zones","_max_rad","_layers","_min_dep","_space","_mine_side","_center_mrk","_pos","_mines","_attempts","_rad_buoy","_deg","_pos_buoy","_isWater","_mine","_mrk_mine","_posX","_posY","_new_pos"];
	_spawn_zones = _this select 0;	//Marker Area
	_max_rad 	 = _this select 1;	//Max distance from center marker
	_layers	 	 = _this select 2; 	//Layers of mines
	_min_dep	 = _this select 3;	//Deepness of mines
	_space	 	 = _this select 4;	//Min space between Layers
	_mine_side	 = _this select 5;	
	_center_mrk  = getMarkerPos _spawn_zones;
	_pos 		 = [];

	_mines = 0;	_degr = 10; _nn = 0; _dist = _max_rad + _space; _numb = 360 / _degr;
	while {_mines < _layers} do
	{
		
		for "_i" from 0 to (_numb -1) do
		{
			_isWater = surfaceIsWater [((_center_mrk) select 0)-(_dist)*sin(_nn), ((_center_mrk) select 1)-(_dist)*cos(_nn), _min_dep];
			if (_isWater) then {
			_mine = createMine ["UnderwaterMine", [((_center_mrk) select 0)-(_dist)*sin(_nn), ((_center_mrk) select 1)-(_dist)*cos(_nn), _min_dep], [], 0]; 
			if (BTC_track) then {_spawn = [_mine] execVM "scripts\BTC_track_unit.sqf";};};
			_nn = _nn + _degr;
		};
	
		_dist = _dist + _space;
		_mines = _mines + 1;
		_nn = _nn + (_degr /2);
		if (_mines > _layers) exitWith {_dist};
	};
	
	//Boe
	_degr = 30; _nn = 0; _dist_buoy = _dist + 30; _numb = 360 / _degr;
	for "_i" from 0 to (_numb -1) do
	{
		_isWater = surfaceIsWater [((_center_mrk) select 0)-(_dist_buoy)*sin(_nn), ((_center_mrk) select 1)-(_dist_buoy)*cos(_nn), 0];
		if (_isWater) then {_buoy = createVehicle ["Land_BuoyBig_F", [((_center_mrk) select 0)-(_dist_buoy)*sin(_nn), ((_center_mrk) select 1)-(_dist_buoy)*cos(_nn), 0], [], 0, "CAN_COLLIDE"]; 
		if (BTC_track) then {_spawn = [_buoy] execVM "scripts\BTC_track_unit.sqf";};};
		_nn = _nn + _degr;
	};
}; // parentesi fine

//===========================================================================
BTC_create_trigger_count_unit = 
{			
		//_n = ["marker",500,"east","PRESENT","this && IsServer && (count thislist < 2)","hint 'Area clear of enemies'"] spawn BTC_create_trigger_count_unit;
		//http://community.bistudio.com/wiki/setTriggerActivation
		private["_mrk","_rad","_side","_type","_act","_code","_dt"];
		_mrk  = _this select 0;
		_rad  = _this select 1;
		_side = _this select 2;
		_type = _this select 3;
		_act  = _this select 4;
		_code = _this select 5;
		switch (typeName _mrk) do
		{
			case "ARRAY" :{_mrk = _mrk; 				};
			case "STRING":{_mrk = getMarkerPos _mrk; 	};
			case "OBJECT":{_mrk = position _mrk; 		};
		};
		_dt = createTrigger ["EmptyDetector", _mrk];
		_dt setTriggerArea [_rad, _rad, 0, false];
		_dt setTriggerActivation [_side, _type, false]; // [by, type, repeating] 
		_dt setTriggerStatements [_act,_code, ""];
		_dt
};


//===========================================================================
BTC_create_trigger_check = 
{
		//_n = ["marker",500,"east","PRESENT","this && IsServer && (count thislist < 2)","hint 'Area clear of enemies'",35] spawn BTC_create_trigger_check;
		//http://community.bistudio.com/wiki/setTriggerActivation
		private ["_mrk","_rad","_side","_type","_act","_code","_dt"];
		_mrk  = _this select 0;
		_rad  = _this select 1;
		_side = _this select 2;
		_type = _this select 3;
		_act  = _this select 4;
		_code = _this select 5;
		_tm	  = _this select 6;
		switch (typeName _mrk) do
		{
			case "ARRAY" :{_mrk = _mrk; 				};
			case "STRING":{_mrk = getMarkerPos _mrk; 	};
			case "OBJECT":{_mrk = position _mrk; 		};
		};
		_dt = createTrigger ["EmptyDetector", _mrk];
		_dt setTriggerArea [_rad, _rad, 0, false];
		_dt setTriggerActivation [_side, _type, true]; // [by, type, repeating] 
		_dt setTriggerStatements [_act,_code, ""];
		_dt setTriggerTimeout [_tm, _tm, _tm, false ];
		_dt
};

//===========================================================================

BTC_create_marker =
{	//_spawn = [1,1,45,"ICON","Solid","ColorRed","marker text","mrk_type","name_area1","pos_wp1_1"] spawn BTC_create_marker;
	
	//_mrk_dir : gradi di rotazione, 0,45,90,270,33
	//_mrk_shape "ICON", "RECTANGLE" or "ELLIPSE"
	//_mrk_brush "Solid" "Horizontal" "Vertical" "Grid" "FDiagonal" "BDiagonal" "DiagGrid" "Cross" "Border" (ArmA2 only) "SolidBorder" (OA only)
	//configfile >> "CfgMarkerColors" >> "ColorOrange" "ColorOPFOR" "ColorKhaki" "ColorIndependent" "ColorGrey" "ColorGreen" "ColorCivilian" 
	// "ColorBrown" "ColorBLUFOR" "ColorBlue" "ColorBlack"
	//_mrk_type "Flag" "Flag1" "Dot" "mil_destroy" "Start" "End" "Warning" "Join" "Pickup" "Unknown" "Marker" "Arrow" "Empty"
	// http://community.bistudio.com/wiki/cfgMarkers
	private["_mrk_size_x","_mrk_size_y","_mrk_dir","_mrk_shape","_mrk_brush","_mrk_color","_mrk_text","_mrk_type","_mrk_name","_mrk_pos","_marker"];	
	_mrk_size_x = _this select 0;  	
	_mrk_size_y = _this select 1; 
	_mrk_dir 	= _this select 2; 	
	_mrk_shape 	= _this select 3;
	_mrk_brush 	= _this select 4; 	
	_mrk_color 	= _this select 5;	
	_mrk_text 	= _this select 6;
	_mrk_type 	= _this select 7;
	_mrk_name 	= _this select 8;
	_mrk_pos	= _this select 9;
	switch (typeName _mrk_pos) do
	{
		case "ARRAY" :{_mrk_pos = _mrk_pos; 				};
		case "STRING":{_mrk_pos = getMarkerPos _mrk_pos; 	};
		case "OBJECT":{_mrk_pos = position _mrk_pos; 		};
	};
	_marker = createMarker [_mrk_name,_mrk_pos];
	_marker setMarkerSize [_mrk_size_x, _mrk_size_y];
	_marker setMarkerDir _mrk_dir;
	_marker setMarkerShape _mrk_shape;
	_marker setMarkerBrush _mrk_brush;
	_marker setMarkerColor _mrk_color;
	_marker setMarkerText _mrk_text;
	_marker setMarkerType _mrk_type;
	MARKER_NAME = _mrk_name; PublicVariable "MARKER_NAME";
};

//===========================================================================

BTC_spw_inf_group_ph =
{	//_spawn = [1,1,45,"ICON","Solid","ColorRed","marker text","mil_destroy","area1","wp1_1"] spawn BTC_create_marker;
	//_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;
	// BTC_enemy_TL, BTC_type_units
	private ["_side","_spwn_mrk","_rad_ptrl","_min_patrl","_center_mrk","_size","_n_enemy","_pos","_group","_skill","_house"];	
	_side       = BTC_enemy_side1;
	_spwn_mrk   = _this select 0;
	_rad_ptrl	= _this select 1;
	_center_mrk = getMarkerPos _spwn_mrk;
	_size		= getMarkerSize _spwn_mrk;
	_rad_ptrl	= _size select 0;
	_min_patrl	= _rad_ptrl / 2;
	if ((count _this) > 1) then {_rad_ptrl = _this select 1;} else {_rad_ptrl = _size select 0;};
	_n_enemy    = (round(random 1));
	_pos = [_center_mrk, _min_patrl, _rad_ptrl, 1, 0, 70*(pi / 180), 0] call BIS_fnc_findSafePos;
	_group = createGroup _side;
	_group createUnit [(BTC_enemy_recon select 0), _pos, [], 0, "NONE"];
	for "_i" from 0 to (_n_enemy - 1) do
	{
		_unit_type = BTC_enemy_recon select (round (random ((count BTC_enemy_recon) - 1)));
		_group createUnit [_unit_type, _center_mrk, [], 10, "NONE"];
	};
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	_house = nearestBuilding leader _group;
	if (_house distance _center_mrk < (_rad_ptrl *0.75))
	then {_patrol = [leader _group,"COMBAT", 30] execVM "scripts\patrol\patrols_House.sqf";}
	else {_patrol = [leader _group,"SAFE", 300] execVM "scripts\patrol\patrols_House.sqf";};
	if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};
	

//===========================================================================

BTC_spawn_inf_group_patrol =
{	//_spawn = [1,1,45,"ICON","Solid","ColorRed","marker text","mil_destroy","area1","wp1_1"] spawn BTC_create_marker;
	//_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;
	// BTC_enemy_TL, BTC_type_units
	private ["_side","_spwn_mrk","_rad_ptrl","_min_patrl","_center_mrk","_size","_n_enemy","_pos","_group","_skill","_rndm"];	
	_side       = BTC_enemy_side1;
	_spwn_mrk   = _this select 0;
	_rad		= _this select 1;
	_center_mrk = getMarkerPos _spwn_mrk;
	_size		= getMarkerSize _spwn_mrk;
	_rad_ptrl	= _size select 0;
	_min_patrl	= _rad_ptrl / 2;
	if ((count _this) > 1) then {_rad_ptrl = _this select 1;} else {_rad_ptrl = _size select 0;};
	_n_enemy    = 2 + (round(random 1));
	_pos = [_center_mrk, _min_patrl, _rad_ptrl, 1, 0, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
	_group = createGroup _side;
	_group createUnit [ BTC_enemy_TL, _pos, [], 0, "NONE"];
	for "_i" from 0 to (_n_enemy - 1) do
	{
		_unit_type = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));
		_group createUnit [_unit_type, _center_mrk, [], 10, "NONE"];
	};
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	_rndm = [1,2,3] call BIS_fnc_selectRandom;
	if (_rndm == 1)
	then {_patrol = [leader _group,_spwn_mrk,random 3, 0] execVM "scripts\BTC_UPS.sqf";}
	else {
			_house = nearestBuilding leader _group;
			if (_house distance _center_mrk < (_rad_ptrl))
			then {_patrol = [leader _group,"SAFE", 20] execVM "scripts\patrol\patrols_House.sqf";}
			else {_patrol = [leader _group,_spwn_mrk,random 120, 0] execVM "scripts\BTC_UPS.sqf";};
		};
	
	if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};
	

//===========================================================================

BTC_man_island_prtl =
{	//_spw = ["mrk","position","O_Soldier_AT_F","O_Soldier_LAT_F"] spawn BTC_man_island_prtl;
	// O_Soldier_AA_F, O_Soldier_AT_F, O_Soldier_LAT_F, O_Soldier_AR_F, O_medic_F
	private["_spwn_mrk","_spw_pos","_unit_type","_unit_type2","_veh_name","_side","_size","_rad_ptrl","_group","_SOLD1","_SOLD2","_skill"];	
	
	_spwn_mrk   = _this select 0;
	_spw_pos	= _this select 1;
	_unit_type	= _this select 2;
	_unit_type2	= _this select 3;
	_veh_name	= _this select 4;
	_side		= _this select 5;
	
	if (_spwn_mrk == "") exitWith {Titletext ["Error: ''BTC_man_island_prtl'' marker not assigned","plain down",0]; diag_log (format["Error: ''BTC_man_island_prtl'' marker not assigned"]);};
	if (isNil ("_spw_pos")) exitWith {Titletext ["Error: ''BTC_man_island_prtl'' position not assigned","plain down",0]; diag_log (format["Error: ''BTC_man_island_prtl'' position not assigned"]);};

	if (_unit_type == "") then {_unit_type = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));} 
							else {_unit_type = _this select 2};
	if (_unit_type2 == "") then {_unit_type2 = BTC_enemy_units select (round (random ((count BTC_enemy_units) - 1)));} 
							else {_unit_type2 = _this select 3};
		
	_group = createGroup _side;
	_SOLD1 = _group createUnit [_unit_type, _spw_pos, [], 0, "this setRank 'COLONEL';"];
	_SOLD2 = _group createUnit [_unit_type2, _spw_pos, [], 10, "FORM"];
	
	leader _group SetVehicleVarName _veh_name; leader _group Call Compile Format ["%1=_this ; PublicVariable ""%1""",_veh_name];
	waitUntil {(vehicleVarName leader _group == _veh_name)};
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	_patrol = [leader _group,_spwn_mrk,random 120, 0] execVM "scripts\BTC_UPS.sqf";
	if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};

//===========================================================================

BTC_spawn_inf_recon_patrol =
{	//_spawn = [1,1,45,"ICON","Solid","ColorRed","marker text","mil_destroy","area1","wp1_1"] spawn BTC_create_marker;
	//_BTC_grp = ["areaI"] spawn BTC_spawn_inf_group_patrol;
	private ["_side","_spwn_mrk","_rad_ptrl","_min_patrl","_center_mrk","_size","_n_enemy","_pos","_group","_skill"];	
	_spwn_mrk   = _this select 0;
	_rad		= _this select 1;
	_center_mrk = getMarkerPos _spwn_mrk;
	_size		= getMarkerSize _spwn_mrk;
	_rad_ptrl	= _size select 0;
	_min_patrl	= _rad_ptrl /3;
	if ((count _this) > 1) then {_rad_ptrl = _this select 1;} else {_rad_ptrl = _size select 0;};
	_n_enemy    = 1 + (round(random 1));
	_pos = [_center_mrk, _min_patrl, _rad_ptrl, 1, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;
	_group = createGroup BTC_enemy_side1;
	_unit_type = BTC_enemy_recon select (round (random ((count BTC_enemy_recon) - 1)));
	_group createUnit [ _unit_type, _pos, [], 0, "NONE"];
	for "_i" from 0 to (_n_enemy - 1) do
	{
		_unit_type = BTC_enemy_recon select (round (random ((count BTC_enemy_recon) - 1)));
		_group createUnit [_unit_type, _center_mrk, [], 10, "NONE"];
	};
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	_patrol = [leader _group,_spwn_mrk,random 120, 0] execVM "scripts\BTC_UPS.sqf";
	if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};


//===========================================================================

BTC_spawn_veh =
{	//_spawn = ["marker_spawn1","marker_patrol","type_T34_TK_EP1"] spawn BTC_spawn_veh;
	// Ha bisogno di un marker prima di essere richiamata (area0, area1...area10)
	//_spawn = [mrk_side_miss,"",""] spawn BTC_spawn_veh;
	if	(!isServer) exitWith {};
	private ["_spwn_mrk","_center_mrk","_veh_type","_size","_rad_ptrl","_group","_pos","_veh","_gunner","_commander","_cargo","_skill"];
	_spwn_mrk   = _this select 0;
	_prt_mrk	= _this select 1;
	_veh_type	= _this select 2;
	_vehi_patrol= _this select 3;
	if (count _this <= 3) then {_vehi_patrol = true;} else {_vehi_patrol= _this select 3;};
	//_center_mrk = getMarkerPos _spwn_mrk;
	if (_veh_type isKindof "StaticWeapon") 
	then {_rad_ptrl	= _this select 1;} 
	else {_rad_ptrl = (getMarkerSize _prt_mrk) select 0;};
	
	switch (typeName _spwn_mrk) do
	{
		case "ARRAY" :{_center_mrk = _spwn_mrk;};
		case "STRING":{_center_mrk = getMarkerPos _spwn_mrk;};
		case "OBJECT":{_center_mrk = position _spwn_mrk;};
	};
	_group = createGroup BTC_enemy_side1;
	if (_veh_type == "") then {_veh_type = BTC_enemy_veh select (round (random ((count BTC_enemy_veh) - 1)));} else {_veh_type = _this select 2};
	_pos = [];
	if (_veh_type isKindOf "Ship")
	then {_pos = [_center_mrk, 0, _rad_ptrl, 2, 2, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;}
	else {
			if (_veh_type isKindOf "Air")
			then {_pos = [_center_mrk, 0, _rad_ptrl, 2, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;}
			else {_pos = [_center_mrk, _rad_ptrl /2, _rad_ptrl, 2, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;};
		 };
	waitUntil {!(isNil ("_pos"))};
	
	_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"];
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Truck") then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	if (_veh_type isKindof "StaticWeapon") then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	if (_gunner > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];};
		if (_veh_type isKindof "StaticWeapon") then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];};
	};
	if (_commander > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_center_mrk, _group, "this moveinCommander _veh"];};
		if (_veh_type isKindof "StaticWeapon") then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
	};
	if (_cargo > 0) then
	{
		If (_veh isKindOf "Ship")
		then
		{
				for "_i" from 0 to (_cargo) do
				{
					_veh_type = BTC_enemy_diver select (round (random ((count BTC_enemy_diver)-1 )));
					_veh_type createUnit [_center_mrk, _group, "this assignAsCargo _veh; this moveinCargo _veh;"];
				};
		}
		else 
		{
				for "_i" from 0 to (_cargo) do
				{
					_veh_type = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
					_veh_type createUnit [_center_mrk, _group, "this assignAsCargo _veh; this moveinCargo _veh;"];	
				};
		};
	};
	
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	/// Start patrol
	if (_vehi_patrol) then
	{
		if !(_veh isKindof "StaticWeapon") then 
		{
		If (_veh isKindOf "Air") 
		then { _patrol = [leader _group,_prt_mrk, 0, 80] execVM "scripts\BTC_UPS.sqf";}
		else { _patrol = [leader _group,_prt_mrk,random 300, 0] execVM "scripts\BTC_UPS.sqf";};
		};
	}
	else 
	{
		doStop leader _group; 
		leader _group doMove getPos _veh; 
		_veh forceSpeed 0;
	};
	if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};

//===========================================================================

BTC_spawn_veh_name =
{	//_spawn = ["marker_spawn1","marker_patrol","type_T34_TK_EP1","name_tank_1",(potional: radius of spawn)] spawn BTC_spawn_veh_name;
	// Ha bisogno di un marker prima di essere richiamata (area0, area1...area10)
	if !((isServer)||(isDedicated)) exitWith {};
	private ["_spwn_mrk","_prt_mrk","_veh_type","_veh_name","_center_mrk","_size","_rad_spawn","_group","_pos","_veh","_gunner","_commander","_cargo","_skill"];
	_spwn_mrk   = _this select 0;
	_prt_mrk	= _this select 1;
	_veh_type	= _this select 2;
	_veh_name	= _this select 3;
	_rad_spawn	= _this select 4;
	if (count _this > 4) then {_rad_spawn = _this select 4;} else {_rad_spawn = (getMarkerSize _prt_mrk) select 0;};
	switch (typeName _spwn_mrk) do
	{
		case "ARRAY" :{_center_mrk = _spwn_mrk;};
		case "STRING":{_center_mrk = getMarkerPos _spwn_mrk;};
		case "OBJECT":{_center_mrk = position _spwn_mrk;};
	};
	
	_group = createGroup BTC_enemy_side1;
	if (_veh_type == "") then {_veh_type = BTC_enemy_veh select (round (random ((count BTC_enemy_veh) - 1)));} else {_veh_type = _this select 2};
	_pos = [];
	
	if (_rad_spawn > 5) then 
	{
		if (_veh_type isKindOf "Ship")
		then {_pos = [_center_mrk, 0, _rad_spawn, 5, 2, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;}
		else {
				if (_veh_type isKindOf "Air")
				then {_pos = [_center_mrk, 0, _rad_spawn, 5, 1, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;}
				else {_pos = [_center_mrk, 0, _rad_spawn, 5, 0, 50 * (pi / 180), 0] call BIS_fnc_findSafePos;};
			 };
	} else {_pos = _center_mrk};	 
	
	waitUntil {!(isNil ("_pos"))};
	If (_veh_type isKindOf "Air")
	then {_veh = createVehicle [_veh_type, _pos, [], 0, "FLY"]; BTC_enemy_pilot createUnit [_center_mrk, _group, "this moveinDriver _veh"];}
	else {_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"];};
	
	private ["_gunner","_commander","_cargo"];
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Truck") then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_center_mrk, _group, "this moveinDriver _veh"];};
	if (_gunner > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_center_mrk, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];};
	};
	if (_commander > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_center_mrk, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];};
	};
	if (_cargo > 0) then
	{
		If (_veh isKindOf "Ship")
		then
		{		_group_crg = createGroup BTC_enemy_side1;
				for "_i" from 0 to (_cargo) do
				{
					_veh_type = BTC_enemy_diver select (round (random ((count BTC_enemy_diver)-1 )));
					_veh_type createUnit [_center_mrk, _group, "this assignAsCargo _veh; this moveinCargo _veh;"];
				};
				_skill = {_x setSkill ["aimingAccuracy", 0];} foreach units _group_crg;
				_skill = {_x setSkill ["aimingShake", 0];} foreach units _group_crg;
				_skill = {_x setSkill ["spotDistance", 0];} foreach units _group_crg;
		}
		else 
		{		_group_crg = createGroup BTC_enemy_side1;
				for "_i" from 0 to (_cargo) do
				{
					_vehicle_type = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
					If   (_veh isKindOf "Air") 
					then {_vehicle_type createUnit [_center_mrk, _group_crg, "removeBackPack this; this addBackPack 'B_Parachute'; this assignAsCargo _veh; this moveinCargo _veh;"];
						  _para = [_veh] execVM "scripts\BTC_para_drop.sqf";}
					else {_vehicle_type createUnit [_center_mrk, _group_crg, "this assignAsCargo _veh; this moveinCargo _veh;"];};
				};
				_skill = {_x setSkill ["aimingAccuracy", 0];} foreach units _group_crg;
				_skill = {_x setSkill ["aimingShake", 0];} foreach units _group_crg;
				_skill = {_x setSkill ["spotDistance", 0];} foreach units _group_crg;
		};
	};
	
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	
	_veh SetVehicleVarName _veh_name; _veh Call Compile Format ["%1=_this ; PublicVariable ""%1""",_veh_name];
	waitUntil {(vehicleVarName _veh == _veh_name)};
	
	/// Start Patrol
	If (_veh isKindOf "Air") 
	then { _patrol = [leader _group,_prt_mrk, 0, 80] execVM "scripts\BTC_UPS.sqf";}
	else { _patrol = [leader _group,_prt_mrk,random 300, 0] execVM "scripts\BTC_UPS.sqf";};

	if (BTC_track) then {_track = [leader _group] execVM "scripts\BTC_track_unit.sqf";};

	if (isNull (Driver _veh)) exitwith {
	diag_log (format["*** Error BTC_spawn_veh NO Driver spawned ***"]);
	if (BTC_debug == 1) then {player sideChat "*** Error BTC_spawn_veh NO Driver spawned ***";};};
	
	[_pos, _veh, _group, _veh_name]
};


//===========================================================================

BTC_give_waypoint =
{
	private ["_destination","_grp","_pos_w","_wp","_unit","_speed"];
	// _spw = [CAR,POSITION,RADIUS] spawn BTC_give_waypoint;
	
	_unit 		 = _this select 0;
	_destination = _this select 1;
	_complete	 = _this select 2;
	if (count _this > 2) then {_complete = _this select 2;} else {_complete = 10;};
	
	switch (typeName _destination) do
	{
		case "STRING":{_pos_w = getMarkerPos _destination;}; 
		case "OBJECT":{_pos_w = position _destination;};
		case "ARRAY" :{_pos_w = _destination;};
	};

	_grp = Group _unit;
	_wp = _grp addWaypoint [_pos_w, 10];
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointType "MOVE"; 
	_wp setWaypointCombatMode "GREEN";
	[_grp,2] setWaypointCompletionRadius _complete;
	[_grp, 1] setWaypointPosition [_pos_w, 10];
	[_grp, _pos_w]
};

//===========================================================================

BTC_check_convoy =
{
	private ["_car","_car_front","_speed","_dist"];
	_car 		= _this select 0;
	_car_front	= _this select 1;
	_speed		= _this select 2;
	_dist		= _this select 3;

	while {(Alive _car)&&(CanMove _car)}
	do
	{
		if (_car distance position _car_front > _dist +50) then {_car forceSpeed _speed *6;};
		if (_car distance position _car_front > _dist +20) then {_car forceSpeed _speed *4;};
		if ((_car distance position _car_front >= _dist +5)&&(_car distance position _car_front <= _dist + 10)) then {_car forceSpeed _speed *2;};
		if (_car distance position _car_front  < _dist) then {_car forceSpeed 0;};
		if (_car distance position _car_front >= _dist) then {_car forceSpeed _speed;};
		if ((!Alive _car_front)||(!canMove _car_front)) exitwith {_car forceSpeed _speed;};
	};
};

//===========================================================================

BTC_spawn_veh_conv =
{	//_spawn = ["marker_spawn1","type_T34_TK_EP1","name_tank_1"] spawn BTC_spawn_veh_conv;
	// Ha bisogno di un marker prima di essere richiamata (area0, area1...area10)
	if !((isServer)||(isDedicated)) exitWith {};
	private["_center_mrk","_veh_type","_veh_name","_group","_veh","_crew","_cargo","_veh_type","_skill","_nul"];
	_center_mrk   = _this select 0;
	_veh_type	  = _this select 1;
	_veh_name	  = _this select 2;
	_spawn		  = getMarkerPos _center_mrk;
	_pos = [];
	_group = createGroup BTC_enemy_side1;
	if (_veh_name == "") exitWith {diag_log "Log: [BTC_spawn_veh_conv] No vehicle name was passed!"; []};
	if (_veh_type == "") then {_veh_type = BTC_enemy_veh select (round (random ((count BTC_enemy_veh) - 1)));} else {_veh_type = _this select 1};
	_pos = [_spawn, 0, 50, 10, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;
	while {(_pos distance _spawn > 50)}
	do {_pos = [_spawn, 0, 50, 10, 0, 40*(pi / 180), 0] call BIS_fnc_findSafePos;};
	waitUntil {!(isNil ("_pos"))};
	_veh = createVehicle [_veh_type, _pos, [], 0, "NONE"];
	_veh setFormDir 0;
	_veh SetVehicleVarName _veh_name; _veh Call Compile Format ["%1=_this ; PublicVariable ""%1""",_veh_name];
	waitUntil {(vehicleVarName _veh == _veh_name)};
	_gunner = _veh emptyPositions "gunner";
	_commander = _veh emptyPositions "commander";
	_cargo = (_veh emptyPositions "cargo") - 1;
	If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_spawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Truck") then {BTC_enemy_TL createUnit [_spawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_spawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_spawn, _group, "this moveinDriver _veh"];};
	If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_spawn, _group, "this moveinDriver _veh"];};
	if (_gunner > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_spawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_spawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_spawn, _group, "this moveinGunner _veh; this assignAsGunner _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_spawn, _group, "this moveinGunner _veh"];};
	};
	if (_commander > 0) then 
	{
		If (_veh isKindOf "Air")   then {BTC_enemy_pilot createUnit [_spawn, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Car")   then {BTC_enemy_TL createUnit [_spawn, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Tank")  then {BTC_enemy_crewmen createUnit [_spawn, _group, "this moveinCommander _veh; this assignAsCommander _veh;"];}; 
		If (_veh isKindOf "Ship")  then {BTC_enemy_diver_TL createUnit [_spawn, _group, "this moveinCommander _veh"];};
	};
	if (_cargo > 0) then
	{	_group_veh = createGroup BTC_enemy_side1;
		If (_veh isKindOf "Ship") 
		then 
		{
				for "_i" from 0 to (_cargo -1) do
				{
					_veh_type = BTC_enemy_diver select (round (random ((count BTC_enemy_diver)-1 )));
					_veh_type createUnit [_spawn, _group_veh, "this moveinCargo _veh; this assignAsCargo _veh;"];
					if (BTC_AI_skill < 10)then{
					_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
					_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
					_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
				};
		}
		else 
		{ 
				for "_i" from 0 to (_cargo -1) do
				{	
					_veh_type = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
					_veh_type createUnit [_spawn, _group_veh, "this moveinCargo _veh; this assignAsCargo _veh;"];	
					if (BTC_AI_skill < 10)then{
					_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
					_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
					_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
				};
		};
	
	};
	ClearWeaponCargo _veh;
	ClearMagazineCargo _veh;
	ClearItemCargo _veh;
	_veh addMagazineCargoGlobal ["Titan_AA", 100];
	_veh addMagazineCargoGlobal ["Titan_AT", 100];
	_veh addMagazineCargoGlobal ["Titan_AP", 100];
	_veh addMagazineCargoGlobal ["RPG32_F", 100];
	_veh addMagazineCargoGlobal ["200Rnd_65x39_cased_box", 200];
	_veh addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 200];
	_veh addMagazineCargoGlobal ["150Rnd_762x51_Box", 200];
	_veh addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 200];
	_drv = (driver _veh) setSkill 1;
	(driver _veh) setSkill ["courage", 1];
	if (BTC_track) then {_track = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};

//===========================================================================

BTC_spawn_diver =
{
	//_spawn = ["area0","radius_spawn","_min_rad"] spawn BTC_spawn_diver;
	private ["_pos","_side","_spawn_zones","_veh_name","_rnd_rad","_dis","_dir","_group","_unit_type","_diver","_rnd_numb","_skill"];
	_spawn		 = _this select 0;
	_min_rad	 = _this select 1;
	_rnd_rad 	 = _this select 2;
	
	switch (typeName _spawn) do
	{	case "ARRAY": {_pos = _spawn;};
		case "STRING":{_pos = getMarkerPos _spawn;};
		case "OBJECT":{_pos = position _spawn;};
	};
	if ((count _this) == 2) then { _min_rad	 = _this select 1; } else {_min_rad = 7;};
	_group 		 = createGroup BTC_enemy_side1;
	_unit_type 	 = BTC_enemy_diver select (round (random ((count BTC_enemy_diver) - 1)));
	_diver = _group createUnit [_unit_type, _pos, [], 0, "NONE"];
	_dir = random 359;
	//_dis = (random _rnd_rad)+ _min_rad;
	_rnd_numb = ((random 20)- 25);
	
	_pos_water = [_pos, _min_rad, _rnd_rad, 1, 2, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
	
	//_diver setPosASLW [((_pos_water) select 0)-(_dis)*sin(_dir), ((_pos_water) select 1)-(_dis)*cos(_dir), _rnd_numb]; 
	_diver setPosASLW [((_pos_water) select 0), ((_pos_water) select 1), _rnd_numb]; 
	_group setFormDir (random 359);
	if (BTC_AI_skill < 10)then{
	_skill = {_x setSkill ["aimingAccuracy", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["aimingShake", (BTC_AI_skill) /2];} foreach units _group;
	_skill = {_x setSkill ["spotDistance", (BTC_AI_skill) /2];} foreach units _group;};
	if (BTC_track) then {_spw = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
	if (typeName _spawn == "STRING") then {	_patrol = [leader _group,_spawn, random 30, -5] execVM "scripts\BTC_UPS.sqf";}
	else {_patrol = [leader _group,"areaS", random 30, -5] execVM "scripts\BTC_UPS.sqf";};


};// fine parentesi

//===========================================================================

BTC_spawn_diver_officer =
{
	//_spawn = ["area0","radius_spawn"] spawn BTC_spawn_diver_officer;
	private["_spawn_zones","_veh_name","_rnd_rad","_dis","_dir","_group","_unit_type","_diver","_rnd_numb","_gr","_div"];
	_spawn_zones = _this select 0;
	_veh_name 	 = "diver_officer";
	_rnd_rad 	 = _this select 1;
	_group = createGroup BTC_enemy_side1;
	_unit_type = BTC_enemy_diver_TL;
	_diver = _group createUnit [_unit_type, getMarkerPos _spawn_zones, [], 0, "NONE"];
	_diver SetVehicleVarName _veh_name; _diver Call Compile Format ["%1=_This ; PublicVariable ""%1""",_veh_name];
	waitUntil {(vehicleVarName _diver == _veh_name)};
	_dir = random 359;
	_rnd_numb = ((random 3)+ 4);
	_diver setPosATL [((position _diver) select 0)+(10)*sin(_dir), ((position _diver) select 1)+(10)*cos(_dir), _rnd_numb]; 
	_group setFormDir (random 359);
	removeAllweapons _diver;	removeBackPack _diver;
	diver_officer switchMove "AswmPercMrunSnonWnonDf_AswmPercMstpSnonWnonDnon";
	// Create unit arround diver, no patrol
	for "_i" from 0 to 3  do 
	{
	_gr = createGroup BTC_enemy_side1;
	_div = _gr createUnit [_unit_type, getPos diver_officer, [], 10, "NONE"]; _gr setFormDir (random 359);
	_rnd_numb = ((random 3)+ 3); _dir = random 359; _dis = (random 5)+5;
	_div setPosATL [((position diver_officer) select 0)-(_dis)*sin(_dir), ((position diver_officer) select 1)-(_dis)*cos(_dir), _rnd_numb]; 
	};
	
		for "_i" from 0 to (floor(BTC_difficulty + 4)/2) do 
		{ 
		_divers = [_diver,10,(BTC_difficulty + 50)] spawn BTC_spawn_diver;	
		};
		
			for "_i" from 0 to (floor(BTC_difficulty + 4)/2) do 
			{ 
			_divers = [_diver,10,(BTC_difficulty + 70)] spawn BTC_spawn_diver;	
			};
};

//===========================================================================

BTC_spawn_pilot_rescue =
{
	//_spawn = ["area0","name"] spawn BTC_spawn_pilot_rescue;
	private["_side","_zone","_veh_name","_rnd_rad","_dis","_dir","_group","_unit_type","_pilot","_rnd_numb"];
	_zone 		 = _this select 0;
	_veh_name 	 = _this select 1;
	_init		 = _this select 2;
	_group 		 = createGroup BTC_enemy_side1;
	_unit_type 	 = BTC_enemy_pilot;
	switch (typeName _zone) do
	{
		case "ARRAY" :{_zone = _zone;};
		case "STRING":{_zone = getMarkerPos _zone;};
		case "OBJECT":{_zone = position _zone;};
	};
	_pilot = _group createUnit [_unit_type, _zone, [], 1, "NONE"];
	_pilot SetVehicleVarName _veh_name; _pilot Call Compile Format ["%1=_This ; PublicVariable ""%1""",_veh_name];
	waitUntil {(vehicleVarName _pilot == _veh_name)};
	_group setFormDir (random 359);
	removeAllweapons _pilot;
	removeBackPack _pilot;
	_pilot SwitchMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";   
	_pilot disableAI "MOVE";
	_pilot disableAI "ANIM";
	_pilot setCaptive true;     
	_pilot addaction _init;
	
	// Enemies guard
	for "_i" from 0 to 2 do
	{
	_group = createGroup BTC_enemy_side1;
	_guard = _group createUnit [BTC_enemy_TL, _zone, [], 8, "NONE"];
	_guard setFormDir (random 359);
	};
};

//===========================================================================

BTC_spawn_civ_group =
{	//_spawn = ["area0",nUman,nAnimals] spawn BTC_spawn_inf_group;
	private["_side","_spawn_zones","_n_CIV","_mrk_size","_mrk_dim","_group","_unit_type","_skill"];
	_side        = civilian;
	_spawn_zones = _this select 0;
	_n_CIV     	 = _this select 1;
	_n_ANIM	     = _this select 2;
	if (isNil ("_n_CIV")) then {_n_CIV = 5;};
	if (isNil ("_n_ANIM")) then {_n_ANIM = 10;};
	_mrk_size 	 = getMarkerPos _spawn_zones;
	_mrk_dim	 = _mrk_size select 0;
	_group = createGroup _side;
	_group createUnit [ BTC_civ_TL, getMarkerPos _spawn_zones, [], 10, "NONE"];
	for "_i" from 0 to (_n_CIV - 1) do
	{
		_unit_type = BTC_civilian select (round (random ((count BTC_civilian) - 1)));
		_group createUnit [_unit_type, getMarkerPos _spawn_zones, [], 10, "NONE"];
		_skill = {_x setSkill 0;} foreach units _group;
	};
	_patrol = [leader _group,_spwn_mrk, random 160, 0] execVM "scripts\BTC_UPS.sqf";
	if (BTC_track) then {_spw = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
		
	private ["_group","_unit_type","_skill"];
	// Animals
	for "_i" from 0 to (_n_ANIM - 1) do
	{
		_group = createGroup _side;
		_unit_type = BTC_animals select (round (random ((count BTC_animals) - 1)));
		_group createUnit [_unit_type, getMarkerPos _spawn_zones, [], 70, "NONE"];
		_skill = {_x setSkill 0;} foreach units _group;
	};
	_patrol = [leader _group,_spwn_mrk, random 60, 0] execVM "scripts\BTC_UPS.sqf";
	if (BTC_track) then {_spw = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
};




//===========================================================================
//===========================================================================
//===========================================================================

/*
Created by =BTC= Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/

Sull'init server inserire _AI = [] spawn BTC_AI_loop;
*/
//Def
BTC_enemy_side  = BTC_enemy_side1;
BTC_player_side = BTC_friendly_side1;
BTC_radio_range = 120;
BTC_AI_id       = 0;
//AI
BTC_AI_loop =
{
	while {true} do
	{
		_groups = [];_groups_to_share = [];_info = [];
		{if (side _x == BTC_enemy_side) then {_groups = _groups + [_x];};} foreach allGroups;
		{if isNil {_x getVariable "BTC_AI_ID"} then {[_x] call BTC_AI_init};} foreach _groups;
		{
			private ["_leader","_targets_list"];
			_leader = leader _x;
			_targets_list = _leader nearTargets 1000;
			if ({_x select 2 == BTC_player_side} count _targets_list > 0) then 
			{
				_info = [];
				{
					if (_x select 2 == BTC_player_side) then
					{
						private ["_knows"];
						_knows = _leader knowsAbout (_x select 4);
						if (_knows > 2) then {_info = _info + [[(_x select 4),_knows]];};
					};
				} foreach _targets_list;
				//diag_log text format ["ID: %1 Targets: %2",(group _leader) getVariable "BTC_AI_ID",_targets_list];
				//diag_log text format ["INFO: %1",_info];
				if (count _info > 0) then
				{
					_groups_to_share = [];
					{
						if (leader _x distance _leader <= BTC_radio_range) then {_groups_to_share = _groups_to_share + [_x];};
					} foreach _groups;
				};
				//diag_log text format ["%1 comunication to groups: %2",(group _leader) getVariable "BTC_AI_ID",_groups_to_share];
				if (count _groups_to_share > 0) then
				{
					{
						private ["_leader_to_share"];
						_leader_to_share = leader _x;
						{
							_leader_to_share reveal _x;
						} foreach _info;
					} foreach _groups_to_share;
				};
				//player sideChat format ["GROUP ID %1 Shares %2",(group _leader) getVariable "BTC_AI_ID",_info];
			};
			[_x,_info] call BTC_behaviour;
			sleep 0.5;
		} foreach _groups;
		sleep 10;
	};
};
BTC_AI_init =
{
	_group = _this select 0;
	if (isNil {_group getVariable "BTC_AI_ID"}) then 
	{ 
		_group setVariable ["BTC_AI_ID",BTC_AI_id,false];
		BTC_AI_id = BTC_AI_id + 1;
		//if (BTC_debug == 1) then {diag_log text format ["%1",BTC_AI_id];};
	};
	//if (BTC_debug == 1) then {diag_log text format ["ADDING %1(%2)",_group,_group getVariable "BTC_AI_ID"];};
	if (isClass(configFile >> "cfgPatches" >> "asr_ai_main")) exitWith {};
	{
		_x setSkill ["aimingAccuracy", 0.15];
		_x setSkill ["aimingShake", 0.6];
		_x setSkill ["aimingSpeed", 0.5];
		_x setSkill ["endurance", 0.6];
		_x setSkill ["spotTime", 0.8];
		_x setSkill ["courage", 0.4];
		_x setSkill ["reloadSpeed", 1];
		if (leader _group == _x) then
		{
			_x setSkill ["commanding", 1];
			_x setSkill ["spotDistance", 0.4];
		};
	} foreach units _group;
};
BTC_behaviour =
{
	_group = _this select 0;
	_info  = _this select 1;
	_distance = 1000;
	{
		if ((_x select 0) distance leader _group < _distance) then {_distance = (_x select 0) distance leader _group;};
	} foreach _info;
	//if (BTC_debug == 1) then {diag_log text format ["%1 - %2 - %3",_group getVariable "BTC_AI_ID",_distance,_info];};
	switch (true) do
	{
		case (_distance < 120) : 
		{
			{
				_x setBehaviour "COMBAT";
				_x setSkill ["aimingAccuracy", 0.25];
				_x setSkill ["aimingShake", 0.4];
				_x setSkill ["aimingSpeed", 0.6];
				_x setSkill ["reloadSpeed", 1];
			} foreach units _group;
			_group setBehaviour "COMBAT";
			//if (BTC_debug == 1) then {player sideChat format ["%1 in combat",_group getVariable "BTC_AI_ID"];};
		};
		case (_distance >= 120 && _distance < 700) : 
		{
			{
				_x setBehaviour "AWARE";
				_x setSkill ["aimingAccuracy", 0.15];
				_x setSkill ["aimingShake", 0.6];
				_x setSkill ["aimingSpeed", 0.4];
				_x setSkill ["endurance", 0.6];
				_x setSkill ["spotTime", 0.5];
				_x setSkill ["courage", 0.4];
				_x setSkill ["reloadSpeed", 1];
			} foreach units _group;
			_group setBehaviour "AWARE";
			//if (BTC_debug == 1) then {player sideChat format ["%1 in aware",_group getVariable "BTC_AI_ID"];};			
		};
		case (_distance >= 700) : 
		{
			{
				_x setBehaviour "SAFE";
				_x setSkill ["aimingAccuracy", 0.1];
				_x setSkill ["aimingShake", 0.7];
				_x setSkill ["aimingSpeed", 0.5];
				_x setSkill ["endurance", 0.6];
				_x setSkill ["spotTime", 0.4];
				_x setSkill ["courage", 0.4];
				_x setSkill ["reloadSpeed", 1];
			} foreach units _group;
			_group setBehaviour "SAFE";
			//if (BTC_debug == 1) then {player sideChat format ["%1 in safe",_group getVariable "BTC_AI_ID"];};
		};
	};
	true
};





