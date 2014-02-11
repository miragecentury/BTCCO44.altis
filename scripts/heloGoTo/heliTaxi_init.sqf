// heliTaxi_init.sqf
// APRIL 2013 - norrin
private ["_heli", "_escort"];
_heli 		= _this select 0;
// Define escort chopper if it exists 
if (isnil ("NORRN_heliTaxi_init")) then {  
	NORRN_heliTaxi_init = true;
	if (count _this > 1) then
	{
		_escort		= _this select 1;
		[_escort,_heli] execVM "scripts\heloGoTo\escort\heliEscort_init.sqf";
		[_heli,_escort] execVM "scripts\heloGoTo\heloGoTo_init.sqf";
	} else {
		[_heli] execVM "scripts\heloGoTo\heloGoTo_init.sqf";
	};
};