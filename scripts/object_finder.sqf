///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Identify closest object
//get all objects within a X meter radius
_all_objects = [];
_all_objects = nearestObjects [trg_finder, ["Ship"], 50]; 

if ((count _all_objects) > 1) then
{
	diag_log "ALL OBJECTS";
	diag_log format ["%1", _all_objects];
	{
	//find out its type 
	_object_type = typeOf _x;
	//Position
	_object_pos = getPosATL _x;
	//Dir
	_object_dir = getDir _x;
	//hint type
	diag_log "OBJECT TYPE"; 	diag_log format ["%1", _object_type];
	diag_log "OBJECT POSITION"; diag_log format ["%1", _object_pos];
	diag_log "OBJECT DIRECTION";diag_log format ["%1", _object_dir];
	} foreach _all_objects;
};
