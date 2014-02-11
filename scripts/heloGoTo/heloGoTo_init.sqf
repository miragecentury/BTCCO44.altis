// heloGoTo_init.sqf
// APRIL 2013 - norrin
private ["_heli","_heliBase","_escort"];
_heli = _this select 0;
// Compile script functions for server and client
execVM "scripts\heloGoTo\compileFunctions.sqf";
sleep 1;
[_heli] spawn Nor_HT_S18;
if (!isServer) exitWith {};
// Define heli start-up variables
_escort = objNull;
if (isNil "NORRN_aerialTaxiRespawnOff") then {NORRN_aerialTaxiRespawnOff = false};
if (isNil "NORRN_H_keepOldCrew") then {NORRN_H_keepOldCrew = false};
if (isNil "NORRN_H_keepOldHeli") then {NORRN_H_keepOldHeli = false};
_heli setVariable ["NORRN_H_destChosen", false, true];
_heli setVariable ["NORRN_aerialTaxiDestroyed", false, true];
_heli setVariable ["NORRN_aerialTaxiRTB", false, false];// Define heli return to base variable
// Define escort if it exists
if (count _this > 1) then {if (!isNull (_this select 1)) then {_escort	= _this select 1}};
// Compile server only chopper functions
Norrn_heliStayPut_Func = Compile PreprocessFile "scripts\heloGoTo\heliStayPut.sqf";
// Identify the base position of the helicopter - modified for respawn
if ( format ["%1", (_heli getVariable "NORRN_heloGoTo_basePos")] == "<null>") then 
{
	_heliBase = "Land_HelipadSquare_F" createVehicle getPos _heli;
	_heliBase setDir (getDir _heli); 
	_heliBase setPos [(getPos _heli) select 0,(getPos _heli) select 1, 0];
	sleep 2;
	_heli setVariable ["NORRN_heloGoTo_basePos", _heliBase, true];
};
sleep 2;
//Added for respawning heli
[_heli] spawn Nor_HT_S15;
if (!isNull _escort) then {[_escort,_heli] spawn Nor_HT_S19; _heli setVariable ["NORRN_H_escort", _escort, false]} else {_heli setVariable ["NORRN_H_escort", objNull, false]};