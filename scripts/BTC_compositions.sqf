///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

//Lamps base
{_object = createVehicle ["Land_LampAirport_F",getmarkerpos _x, [], 0, "CAN_COLLIDE"]; _object setDir 225;} 
foreach 
[
"illumination_1","illumination_2","illumination_3","illumination_4","illumination_5",
"illumination_6","illumination_7","illumination_8","illumination_9","illumination_10","illumination_11"
];

//Detention center
_pos = getmarkerPos "jgate1";_object = createVehicle ["Land_Stone_Gate_F", _pos, [], 0, "CAN_COLLIDE"];_object setDir 45;_object setPosATL _pos;
_pos = getmarkerPos "jgate2";_object = createVehicle ["Land_Stone_Gate_F", _pos, [], 0, "CAN_COLLIDE"];_object setDir 45;_object setPosATL _pos;
_pos = getmarkerPos "jail_mrk";_object = createVehicle ["Land_LampAirport_F", _pos, [], 0, "CAN_COLLIDE"];_object setDir 100.875;
_pos = getmarkerPos "jhouse1";_object = createVehicle ["Land_Cargo_House_V1_F", _pos, [], 0, "CAN_COLLIDE"];_object setDir 45;
_pos = getmarkerPos "jhouse2";_object = createVehicle ["Land_Cargo_House_V1_F", _pos, [], 0, "CAN_COLLIDE"];_object setDir 45;
_pos = getmarkerPos "jhouse3";_object = createVehicle ["Land_Cargo_House_V1_F", _pos, [], 0, "CAN_COLLIDE"];_object setDir 45;

//LIGHTS HELIPADS 
{_object = createVehicle ["Land_Flush_Light_yellow_F",getmarkerpos _x, [], 0, "CAN_COLLIDE"];} foreach 
[
"heli_pad_A_1","heli_pad_A_2","heli_pad_A_3","heli_pad_A_4",
"heli_pad_B_1","heli_pad_B_2","heli_pad_B_3","heli_pad_B_4",
"heli_pad_C_1","heli_pad_C_2","heli_pad_C_3","heli_pad_C_4",
"heli_pad_D_1","heli_pad_D_2","heli_pad_D_3","heli_pad_D_4",
"heli_pad_E_1","heli_pad_E_2","heli_pad_E_3","heli_pad_E_4"
];
//_object = createVehicle ["Land_Portable_generator_F", _pos, [], 0, "CAN_COLLIDE"];

//FOBS
//"Land_Cargo_HQ_V2_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Tower_V1_F"
_pos = getmarkerPos "mrk_fob_1"; _BunkTower = createVehicle ["Land_Cargo_Patrol_V2_F", _pos, [], 0, "CAN_COLLIDE"]; _BunkTower setDir 180;
_pos = getmarkerPos "mrk_fob_3"; _BunkTower = createVehicle ["Land_Cargo_Tower_V1_F", _pos, [], 0, "CAN_COLLIDE"]; _BunkTower setDir 130;
_pos = getmarkerPos "mrk_fob_4"; _BunkTower = createVehicle ["Land_Cargo_Patrol_V2_F", _pos, [], 0, "CAN_COLLIDE"]; _BunkTower setDir 180;










