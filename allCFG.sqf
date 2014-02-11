//_null = [] execVM "allCFG.sqf";

hint "== START PRINTING .CFG ==";
diag_log (format["========== START PRINTING .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
/*
diag_log (format["========== CfgMarkers .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgMarkers";
_count = count (configFile >> _rootclass);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configfile >> _rootclass) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
};

diag_log (format["========== CfgWeapons .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgWeapons";
_count = count (configFile >> _rootclass);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configfile >> _rootclass) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
};

 diag_log (format["========== CfgMagazines .CFG =========="]);	
 diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgMagazines";
_count = count (configFile >> _rootclass);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configfile >> _rootclass) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
};

diag_log (format["========== CfgAmmo .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgAmmo";
_count = count (configFile >> _rootclass);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configfile >> _rootclass) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
};

diag_log (format["========== CfgVehicles .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgVehicles";
_count = count (configFile >> "Helicopter" >>_rootclass);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configfile >> _rootclass) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
	//localize format ["%1",_name];
};

diag_log (format["========== PistolCore .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgWeapons";
_count = count ( configFile >> _rootclass >> PistolCore >> Pistol >> Pistol_base_F);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configFile >> _rootclass >> PistolCore >> Pistol >> Pistol_base_F) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
	//localize format ["%1",_name];
};
*/

diag_log (format["========== CfgWeapons .CFG =========="]);
diag_log (format[]);
diag_log (format[]);
_rootclass = "CfgWeapons";
_count = count (configFile >> _rootclass);
for [{_x=0}, {_x<_count}, {_x=_x+1}] do 
{
	sleep 0.001;
	_entry=(configfile >> _rootclass) select _x;
	_name = configName _entry;
	diag_log (format["%1",_name]);
};

hint "== END PRINTING .CFG ==";
diag_log (format["============ END PRINTING .CFG ============"]);

