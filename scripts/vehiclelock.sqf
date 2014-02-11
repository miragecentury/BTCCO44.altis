///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley                   //	
/// Visit us: www.blacktemplars.altervista.org   //
/// Script per evitare il furto del veicolo		 //
/// da parte delle AI o fazione opposta			 //
/// _null = [this] execVM "vehiclelock.sqf";	 //
///////////////////////////////////////////////////

if (isServer) then 
{
	_vehicle = _this select 0;  
	
	_vehicle addEventHandler 
	["GetIn", 
		{
			_unit = _this select 2;
			if (side _unit == BTC_enemy_side1) then 
			{
				_veh = _this select 0;
				_fuel = fuel _veh;
				_veh setFuel 0;
				_unit action ["eject", _veh];
				[_unit,_veh,_fuel] spawn 
				{
					waitUntil {sleep 1; vehicle (_this select 0) == (_this select 0)};
					(_this select 1) setFuel (_this select 2);
				};
			};
		}
	];

};




