// https://github.com/ConnorAU/A3UserInputMenus/wiki
// add a3userinputmenus to mission, then:

// _nul = [] execVM "fnc_setHourOfDay.sqf";

readableTime = [daytime, "HH:MM"] call BIS_fnc_timeToString;
currentTime = format["Time is %1 - Change hour of day to", readableTime];
[
    [
        [0,23],
        date select 3,
        [1,1]
    ],
	currentTime,
    {format["%1",round _position]},
    {
        if _confirmed then {
			rndHour = _position;
			rndMin = [0, 59] call BIS_fnc_randomInt;
			rndOverCast = [0.1, 0.8] call BIS_fnc_randomNum;
			rndFog = [0.1, 0.6] call BIS_fnc_randomNum;
			rndFogIntensity = [0.005, 0.01] call BIS_fnc_randomNum;
			rndFogAltitude = [5, 10] call BIS_fnc_randomNum;
			
			// setDate to some month and day where there are fuller moons, to make nights a bit brighter			
			setDate[1968,9,19,rndHour,rndMin];

			// Exception to above, just enough clouds for a beatiful sunrise/sunset during sunrise/sunset hours
			if ((rndHour == 5) || (rndHour == 6) || (rndHour == 17) || (rndHour == 18)) then{
				rndOverCast = [0.1, 0.3] call BIS_fnc_randomNum;
			};
			0 setOvercast rndOverCast;
			if (rndOverCast > 0.6) then { 
				rndRain = random 1; 
				0 setRain rndRain; 
			}else { 
				0 setRain 0; 
			};
			0 setRainbow 0;
			0 setFog [rndFog,rndFogIntensity,rndFogAltitude];
			forceWeatherChange;
        } else {
            // systemchat "Aborted";
        };
    },
    "Set Time",
    "Abort"
] call CAU_UserInputMenus_fnc_slider;