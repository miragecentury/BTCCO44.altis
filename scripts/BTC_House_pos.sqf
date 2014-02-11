///////////////////////////////////////////////////
/// BTC_house_pos.sqf							 //	
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

// Give a 100% chance to patrol inside building per Waypoint
_unit = _this select 0;
_house = nearestBuilding vehicle _unit;
if ((vehicle _unit isKindOf "Man")&&(_house distance vehicle _unit < 50)) then
{	
	_rnd = 1; //_rnd = round (random 1)+1;
	if (_rnd ==1) then
	{	
		while { format ["%1", _house buildingPos _x] != "[0,0,0]" } do {_x = _x + 1};
		_x = _x - 1;
		_pos = (_house buildingPos (random _x)); 
	};
	if (_x > 0) then {_unit DoMove _pos;};
};