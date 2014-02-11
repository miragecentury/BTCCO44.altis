/*
///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley  				 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////
Parameter(s):
_this select 0: this is the diver
_this select 1: this is the max depth the diver can go.
Example(s): null = [this,-30] execVM "deepgauge.sqf"
*/
private ["_BTC_unit","_BTC_maxdepth","_deep_v","_factor","_deep_v"];
waitUntil {!isNull player};

_BTC_unit = _this select 0;
_BTC_maxdepth = if (count _this > 1) then {_this select 1} else {-50};
while {true} do 
{
	sleep 1;
	while {(getPosASLW _BTC_unit) select 2 < -1.7} do // -1.7: Offset to start the Deepgauge only when your head go underwater
	{
		sleep 1; 
		_deep_v = (getPosASLW _BTC_unit) select 2;
		_factor = 10^(1);
		_deep_v = ((round (_deep_v * _factor)) / _factor) +1.7;
		hintsilent format ["Depth meters: %1", _deep_v];
		if ((getPosASLW _BTC_unit) select 2 < (_BTC_maxdepth + 5)) then 
		{
			if ((((getPosASLW _BTC_unit) select 2 < (_BTC_maxdepth + 5)) && ((getPosASLW _BTC_unit) select 2 > _BTC_maxdepth))&&(vehicle _BTC_unit == _BTC_unit)) then
			{
				hintsilent parseText format ["<t color='#ff0000'>YOU ARE GOING TOO DEEP DO NOT DIVE MORE OR YOU WILL GET INJURED!.</t>"];
				sleep 2;
			};
			if (((getPosASLW _BTC_unit) select 2 < _BTC_maxdepth)&&(vehicle _BTC_unit == _BTC_unit)) then
			{
				hintsilent parseText format ["<t color='#ff0000'>YOU ARE TOO DEEP, GO UP!.</t>"];
				sleep 0.5;
				titletext ["","WHITE OUT"];
				_BTC_unit setDamage (damage _BTC_unit) + 0.05;
				sleep 0.5;
				titletext ["","PLAIN"];
			};
		};
	};
	hint "";
};			

