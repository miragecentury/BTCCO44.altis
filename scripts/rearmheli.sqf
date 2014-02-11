///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

// Activation: {[_x] execVM "rearmheli.sqf"} foreach thislist;

_unit = _this select 0;

// Don't start the script until the unit is below a height of 2, 
// and make sure they hold that height for at least 3 seconds.
WaitUntil{((getPos _unit select 2) < 2)}; 
if ((getPos _unit select 2)> 2) exitWith{};
_unit VehicleChat format ["%1 : Please wait inside the vehicle until complete...", ProfileName];
sleep 1;
_unit engineOn false;
_unit setFuel 0;
sleep 5;
_unit VehicleChat "Repairing vehicle...";
_dam = damage _unit;
for "_i" from 0 to 10 do {_dam = _dam - 0.1; _unit setDamage _dam; sleep 1; if (_dam == 0)exitWith{};};

_unit VehicleChat "Rearming vehicle...";
sleep 5;
_unit setVehicleAmmo 1;

_unit VehicleChat "Refueling vehicle...";
_Fuel = 0;
for "_i" from 0 to 10 do {_Fuel = _Fuel + 0.1; _unit setFuel _Fuel; sleep 1; if (_Fuel == 1)exitWith{};};

_unit VehicleChat format ["%1 : YOUR VEHICLE IS READY", ProfileName];


