///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

if ((isServer)&&(BTC_patrols_air == 1)) then 
{

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////// Air Patrol \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	while {(BTC_patrols_veh == 1)} do
	{	private ["_spwn_mrk","_size","_mrk_dim","_pos","_group","_unit_type","_vehicle"];
		_spwn_mrk	= _this select 0;
		if (BTC_debug == 1) then {_spwn_mrk setMarkerAlpha 1; };
		_size		= getMarkerSize _spwn_mrk;
		_mrk_dim	= _size select 0;
		_pos = [markerPos _spwn_mrk, 0, _mrk_dim, 0, 1, 50*(pi / 180), 0] call BIS_fnc_findSafePos;
		while { (({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && ((_x distance _pos) < 6000)} count allUnits) > 0) }
		do {_pos = [markerPos _spwn_mrk, 0, _mrk_dim, 0, 1, 50*(pi / 180), 0] call BIS_fnc_findSafePos; sleep 0.1;};

		waitUntil 
		{sleep 5; (
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance _pos) < 3000)} count allUnits) > 0)||
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance _pos) < 3000)} count allUnits) > 0)||
		(({((isPlayer _x) OR (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance _pos) < 4000)} count allUnits) > 0)
		)};	

		_group = createGroup BTC_enemy_side1;
		_unit_type = BTC_enemy_heli select (round (random ((count BTC_enemy_heli) - 1)));
		_vehicle = createVehicle [_unit_type, _pos, [], 0, "FLY"];
		BTC_enemy_pilot createUnit [_pos, _group, "this moveinDriver _vehicle"];
		private["_gunner","_cargo","_group_crg","_vehicle_type","_skill"];
		_gunner = _vehicle emptyPositions "gunner";
		if (_gunner > 0) then {BTC_enemy_pilot createUnit [_pos, _group, "this moveinGunner _vehicle; this assignAsGunner _vehicle;"];};
		if (BTC_debug == 1) then {player sideChat "PATROL AIR SPAWNED";};
		_cargo = (_vehicle emptyPositions "cargo") - 1;
		if (_cargo > 0) then
		{
			_group_crg = createGroup BTC_enemy_side1;
			for "_i" from 0 to (_cargo) do
			{
				_vehicle_type = BTC_enemy_units select (round (random ((count BTC_enemy_units)-1 )));
				_vehicle_type createUnit [_pos, _group_crg, "removeBackPack this; this addBackPack 'B_Parachute'; this assignAsCargo _vehicle; this moveinCargo _vehicle;"];
			};
			_skill = {_x setSkill ["aimingAccuracy", 0];} foreach units _group_crg;
			_skill = {_x setSkill ["aimingShake", 0];} foreach units _group_crg;
			_skill = {_x setSkill ["spotDistance", 0];} foreach units _group_crg;
		};
		_driver = driver _vehicle;
		If (_vehicle isKindOf "Air") then {[_driver, _vehicle, _cargo] execVM "scripts\BTC_para_drop.sqf";};
		//_patrol = [Driver _vehicle,_spwn_mrk,random 30, 0, 1500] execVM "scripts\BTC_UPS.sqf";
		_nul = [GROUP (Driver _vehicle), getPos _vehicle, 2000] call bis_fnc_taskpatrol;
		if (BTC_track) then {_spawn = [leader _group] execVM "scripts\BTC_track_unit.sqf";};
		sleep 5;
		waitUntil {sleep 5; ((!CanMove _vehicle)||(!Alive _vehicle))};
		if (BTC_debug == 1) then {player sideChat "PATROL AIR KILLED";}; 
		sleep BTC_resp_enemy_time;	//Time before respawn again
	}; // Fine parentesi while do

}; // Fine parentesi isServer







