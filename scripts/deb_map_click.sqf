///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//On map single click activator

if !(map_click) 
then {
	onMapSingleClick "vehicle player setpos [_pos select 0,_pos select 1,0];
	{_x setPos _pos;} forEach units player;"; 
	Titletext ["TELEPORT & GOD MODE ON","plain",0]; map_click = true; player allowDamage false;
	} 
else {
	onMapSingleClick ""; Titletext ["TELEPORT & GOD MODE OFF","plain",0]; 
	map_click = false; player allowDamage true;
	};