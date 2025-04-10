// This script randomly changes weather and daytime.
// If the script seeds a night time hour, it sets the date/time to a period where the moon lights up the map a nudge (setDate[1968,2,30,3,0], with random but minimal cloud cover. To avoid pitch black nights)
// _nul = [] execVM "fnc_randomWeather.sqf";
   
rndHour = [0, 23] call BIS_fnc_randomInt;
rndMin = [0, 59] call BIS_fnc_randomInt;
rndOverCast = 0.2;
rndFog = [0.1, 0.6] call BIS_fnc_randomNum;
rndFogIntensity = [0.005, 0.01] call BIS_fnc_randomNum;
rndFogAltitude = [5, 10] call BIS_fnc_randomNum;
rndChanceNight = 50;

// if night hours, then show the moon, for just enough night light, else just randomize
if (( rndHour > 19) || (rndHour < 5)) then{
	rndChanceNight = [0, 100] call BIS_fnc_randomInt;
	if ( rndChanceNight > 50 ) then{
		rndHour = [6, 18] call BIS_fnc_randomInt;
	} else {
		switch (rndHour) do            
		{            
			case 20: { if (rndMin > 30) then{ rndOverCast = random 0.1; setDate[1968,2,30,3,0]; }; };
			case 4: { if (rndMin < 15) then{ rndOverCast = random 0.1; setDate[1968,2,30,3,0]; }; };
			default { rndOverCast = random 0.1; setDate[1968,2,30,3,0]; };
		};
	};
}else{
	rndOverCast = random 1;
	setDate[1968,7,1,rndHour,rndMin];
};

// Exception to above, just enough clouds for a beatiful sunrise/sunset during sunrise/sunset hours
if ((rndHour == 5) || (rndHour == 6) || (rndHour == 7) || (rndHour == 17) || (rndHour == 18) || (rndHour == 19)) then{
	rndOverCast = random 0.28;
};

0 setOvercast rndOverCast;
if (rndOverCast > 0.7) then { rndRain = random 1; 0 setRain rndRain; }else { 0 setRain 0; };
0 setRainbow 0;
0 setFog [rndFog,rndFogIntensity,rndFogAltitude];
forceWeatherChange;

