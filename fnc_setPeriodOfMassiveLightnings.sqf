// Slider UI dialog to set the params for "fnc_Lightning.sqf" 
// https://github.com/ConnorAU/A3UserInputMenus/wiki
// add a3userinputmenus to mission, then:

// _nul = [] execVM "fnc_setPeriodOfMassiveLightnings.sqf";

lightningOn = false;
rndFogIntensity = [0.005, 0.01] call BIS_fnc_randomNum;
rndFogAltitude = [5, 10] call BIS_fnc_randomNum;

[
    [
        [10,600],
        30,
        [1,1]
    ],
	"Create a period of lightning weather lasting",
    {format["%1 seconds", round _position]},
    {
		if _confirmed then {
			lightningOn = true;
			rndOverCast = [0.7, 1.0] call BIS_fnc_randomNum;
			rndRain = [0.4, 1.0] call BIS_fnc_randomNum;
			0 setOverCast rndOverCast;
			0 setRain rndRain;
			forceWeatherChange;
			_nulLightningPeriod = [_position,5,100,100] execVM "fnc_Lightning.sqf";
        } else {
            // systemchat "Aborted";
        };
    },
    "Start Lightning",
    "Abort"
] call CAU_UserInputMenus_fnc_slider;