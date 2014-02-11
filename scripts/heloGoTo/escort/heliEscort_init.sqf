// heliEscort_init.sqf
// © OCTOBER 2011 - norrin
private ["_heli","_escort","_escortBase"];
if (!isServer) exitWith {};
_escort		= _this select 0;
_heli 		= _this select 1;
// Identify the base position of the escort
if ( format ["%1", (_escort getVariable "NORRN_heloGoTo_basePos")] == "<null>") then 
{
		_escortBase = "Land_HelipadSquare_F" createVehicle getPos _escort;
		_escortBase setDir (getDir _escort); 
		_escortBase setPos [(getPos _escort) select 0,(getPos _escort) select 1, 0];
		sleep 2;
		_escort setVariable ["NORRN_heloGoTo_basePos", _escortBase, false];
};
sleep 1;
// Define chopper to be escorted
_escort setVariable ["NORRN_aerialTaxi", _heli, false];
// Start chopper escort script 
[_escort,_heli] spawn Nor_HT_SS2;
// Add Escort functions
Nor_HTE_S0 = Compile PreprocessFile "scripts\heloGoTo\escort\fn\escortRTB.sqf";
// Add Escort functional conditions
Nor_HTE_C1 = Compile PreprocessFile "scripts\heloGoTo\escort\fn\cond_fn1.sqf";
Nor_HTE_C2 = Compile PreprocessFile "scripts\heloGoTo\escort\fn\cond_fn2.sqf";
Nor_HTE_C3 = Compile PreprocessFile "scripts\heloGoTo\escort\fn\cond_fn3.sqf";



