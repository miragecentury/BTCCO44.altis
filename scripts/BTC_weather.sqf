///////////////////////////////////////////////////
/// BTC_weather.sqf
/// ® March 2013 =BTC= Muttley 					 //	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

if (isServer) then 
{	
	WaitUntil {!(isNil ("BTC_weather"))};
	WaitUntil {!(isNil ("BTC_fog"))};
	1 setFog 0;
	_value = BTC_weather;
	1 setOvercast _value;
	1 setWaves _value;
	1 setGusts _value;
	1 setWindForce (_value / 2);
	1 setWindStr (_value / 2);
	if (BTC_fog > 0) then {1 setFog BTC_fog;};
	if (BTC_fog == 100) then {1 setFog (random 1);};
	if (BTC_fog == 1000) then {1 setFog (random 0.3);};
	skipTime 24;
	if ((BTC_weather >= 0.7)&&(BTC_weather < 1))
	then
	{
		1800 setRain (random 0.4) + 0.4; 
		1800 setLightnings (random 0.5) + 0.5; 
		if (BTC_fog > 0) then {1800 setFog BTC_fog;};
		if (BTC_fog == 100) then {1800 setFog (random 1);};
		if (BTC_fog == 1000) then {1800 setFog (random 0.3);};
	};

	if ((BTC_weather >= 0.7)&&(BTC_weather < 1))
	then 
	{
		for "_i" from 0 to 999 do
		{
			sleep 1800;
			1800 setRain (random 0.4) + 0.4; 
			1800 setLightnings (random 0.5) + 0.5; 
			if (BTC_fog > 0) then {1800 setFog BTC_fog;};
			if (BTC_fog == 100) then {1800 setFog (random 1);};
			if (BTC_fog == 1000) then {1800 setFog (random 0.3);};
		};
	};
};








