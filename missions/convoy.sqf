/*************************************************
 BTC CONVOY SCRIPT 					® OTTOBRE 2013
 Autor: =BTC= Muttley
 Visit us: www.blacktemplars.altervista.org
 V 0.1 - 15/10/2013
*************************************************/

//private ["_car_array","_speed","_dist","_waypoint","_head","_back","_car_back","_car_front","_count"];
// _spw = [[coda,convoglio,testa],m/s,distance,destination] spawn BTC_check_dist_car;
// _spw = [[CONV8,CONV7,CONV6,CONV5,CONV4,CONV3,CONV2,CONV1],m/s,distance,destination] execVM "missions\convoy.sqf";
// _spw = [[CONV8,CONV7,CONV6,CONV5,CONV4,CONV3,CONV2,CONV1],7,50] execVM "missions\convoy.sqf";

	
	//_null = [] spawn BTC_conv_move;
	private ["_conv_dest","_conv1","_conv2","_conv3","_conv4","_conv5","_conv6","_conv7","_conv8","_pos_w","_wp","_str_pos"];
	
	_cars		= _this select 0;
	_speed 		= _this select 1;
	_dist		= _this select 2;
	_str_pos 	= getMarkerPos mrk_side_conv_str;
	_conv_dest 	= dest_obj;
	
	if ((count _cars) > 0) then {_conv1	= _cars select 0;} else {_conv1 = objNull;};
	if ((count _cars) > 1) then {_conv2	= _cars select 1;} else {_conv2 = objNull;};
	if ((count _cars) > 2) then {_conv3	= _cars select 2;} else {_conv3 = objNull;};
	if ((count _cars) > 3) then {_conv4	= _cars select 3;} else {_conv4 = objNull;};
	if ((count _cars) > 4) then {_conv5	= _cars select 4;} else {_conv5 = objNull;};
	if ((count _cars) > 5) then {_conv6	= _cars select 5;} else {_conv6 = objNull;};
	if ((count _cars) > 6) then {_conv7	= _cars select 6;} else {_conv7 = objNull;};
	if ((count _cars) > 7) then {_conv8	= _cars select 7;} else {_conv8 = objNull;};

	_spaw = [_conv1,_conv_dest,100] spawn BTC_give_waypoint; 
	//[] SPAWN {waitUntil {sleep 1;( getMarkerPos mrk_side_conv_str distance getPos CONV1 > 1000 )}; doStop CONV1;};
	waitUntil {sleep 1;(getPos _conv1 distance _str_pos > 1000)};
	doStop _conv1;
	
	_spw = [_conv2,_conv1,7,50] spawn BTC_check_convoy;
	waitUntil {sleep 1;( getPos _conv2 distance getPos _conv1 > 800 )};
	_spaw = [_conv2,getPos _conv1,100] spawn BTC_give_waypoint;
	
	if ((count _cars) > 1) then {_spw = [_conv3,_conv2,7,50] spawn BTC_check_convoy;	waitUntil {sleep 1;( getPos _conv3 distance getPos _conv2 > 150 )};};
	_spaw = [_conv3,getPos _conv1,100] spawn BTC_give_waypoint;
	if ((count _cars) > 2) then {_spw = [_conv4,_conv3,7,50] spawn BTC_check_convoy;	waitUntil {sleep 1;( getPos _conv4 distance getPos _conv3 > 150 )};};
	_spaw = [_conv4,getPos _conv1,100] spawn BTC_give_waypoint;
	if ((count _cars) > 3) then {_spw = [_conv5,_conv4,7,50] spawn BTC_check_convoy;	waitUntil {sleep 1;( getPos _conv5 distance getPos _conv4 > 150 )};};
	_spaw = [_conv5,getPos _conv1,100] spawn BTC_give_waypoint;
	if ((count _cars) > 4) then {_spw = [_conv5,_conv4,7,50] spawn BTC_check_convoy;	waitUntil {sleep 1;( getPos _conv6 distance getPos _conv5 > 150 )};};
	_spaw = [_conv6,getPos _conv1,100] spawn BTC_give_waypoint;
	if ((count _cars) > 5) then {_spw = [_conv6,_conv5,7,50] spawn BTC_check_convoy;	waitUntil {sleep 1;( getPos _conv7 distance getPos _conv6 > 150 )};};
	_spaw = [_conv7,getPos _conv1,100] spawn BTC_give_waypoint;
	if ((count _cars) > 6) then {_spw = [_conv7,_conv6,7,50] spawn BTC_check_convoy;	waitUntil {sleep 1;( getPos _conv8 distance getPos _conv7 > 150 )};};
	_spaw = [_conv8,getPos _conv1,100] spawn BTC_give_waypoint;
	if ((count _cars) > 7) then {_spw = [_conv8,_conv7,7,50] spawn BTC_check_convoy;};
	
	if ((count _cars) > 5) then 
	{
		waitUntil {sleep 1;( (getPos _conv8) distance (getPos _conv1) < 500 )};
		waitUntil {sleep 1;( (getPos _conv8) distance (getPos _conv7) < 60  )};
		_conv1 doMove (getPos _conv_dest);
		[] SPAWN 
		{
			waitUntil 
			{sleep 5; (
			(({((isPlayer _x) && (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance CONV1) < 2000)} count allUnits) > 0)||
			(({((isPlayer _x) && (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance CONV1) < 3000)} count allUnits) > 0)||
			(({((isPlayer _x) && (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance CONV1) < 4000)} count allUnits) > 0)
			)};	
			_damage = [] spawn {{if(Alive _x) then {_x AllowDamage true;}} foreach [CONV1,CONV2,CONV3,CONV4,CONV5,CONV6,CONV7,CONV8];};
		};
		//New code
		_head_pos = getPos _conv1;
		while {(Alive _conv1)&&(CanMove _conv1)}
		do
		{
			waitUntil {sleep 5;(_head_pos distance getPos _conv1 > 450)};
			_head_pos = getPos _conv1;
			doStop _conv1;
			if ((Alive _conv2)&&(CanMove _conv2))then{_spaw = [_conv2,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv3)&&(CanMove _conv3))then{_spaw = [_conv3,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv4)&&(CanMove _conv4))then{_spaw = [_conv4,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv5)&&(CanMove _conv5))then{_spaw = [_conv5,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv6)&&(CanMove _conv6))then{_spaw = [_conv6,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv7)&&(CanMove _conv7))then{_spaw = [_conv7,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv8)&&(CanMove _conv8))then{_spaw = [_conv8,getPos _conv1,100] spawn BTC_give_waypoint;};
			
			if ((Alive _conv2)&&(CanMove _conv2))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv2 < 100)};};
			if !((Alive _conv2)&&(CanMove _conv2))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv3 < 100)};};
			if !((Alive _conv3)&&(CanMove _conv3))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv4 < 100)};};
			if !((Alive _conv4)&&(CanMove _conv4))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv5 < 100)};};
			if !((Alive _conv5)&&(CanMove _conv5))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv6 < 100)};};
			if !((Alive _conv6)&&(CanMove _conv6))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv7 < 100)};};
			if !((Alive _conv7)&&(CanMove _conv7))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv8 < 100)};};
			_conv1 doMove (getPos dest_obj);
		};
		
	}
	else
	{
		waitUntil {sleep 1;( (getPos _conv5) distance (getPos _conv1) < 300 )};
		waitUntil {sleep 1;( (getPos _conv5) distance (getPos _conv4) < 60  )};
		_conv1 doMove (getPos _conv_dest);
		[] SPAWN 
		{
			waitUntil 
			{sleep 5; (
			(({((isPlayer _x) && (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Man") && ((_x distance CONV1) < 2000)} count allUnits) > 0)||
			(({((isPlayer _x) && (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "LandVehicle") && ((_x distance CONV1) < 3000)} count allUnits) > 0)||
			(({((isPlayer _x) && (side _x == BTC_friendly_side1)) && (vehicle _x isKindOf "Air") && ((_x distance CONV1) < 4000)} count allUnits) > 0)
			)};	
			_damage = [] spawn {{if(Alive _x) then {_x AllowDamage true;}} foreach [CONV1,CONV2,CONV3,CONV4,CONV5];};
		};
		//New code
		_head_pos = getPos _conv1;
		while {(Alive _conv1)&&(CanMove _conv1)}
		do
		{
			waitUntil {sleep 5;(_head_pos distance getPos _conv1 > 450)};
			_head_pos = getPos _conv1;
			doStop _conv1;
			if ((Alive _conv2)&&(CanMove _conv2))then{_spaw = [_conv2,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv3)&&(CanMove _conv3))then{_spaw = [_conv3,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv4)&&(CanMove _conv4))then{_spaw = [_conv4,getPos _conv1,100] spawn BTC_give_waypoint;};
			if ((Alive _conv5)&&(CanMove _conv5))then{_spaw = [_conv5,getPos _conv1,100] spawn BTC_give_waypoint;};
			
			if ((Alive _conv2)&&(CanMove _conv2))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv2 < 100)};};
			if !((Alive _conv2)&&(CanMove _conv2))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv3 < 100)};};
			if !((Alive _conv3)&&(CanMove _conv3))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv4 < 100)};};
			if !((Alive _conv4)&&(CanMove _conv4))then{waitUntil {sleep 5;(getPos _conv1 distance GetPos _conv5 < 100)};};
			_conv1 doMove (getPos dest_obj);
		};
	};
















