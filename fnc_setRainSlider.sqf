// https://github.com/ConnorAU/A3UserInputMenus/wiki
// add a3userinputmenus to mission, then:

// _nul = [] execVM "fnc_setRainSlider.sqf";

currentRain = format["Current rain level is %1 - Change rain level to", rain];
[
    [
        [0.0,1.0],
        rain,
        [0.1,0.1]
    ],
	currentRain,
    {format["%1", _position]},
    {
		if _confirmed then {
			rndOverCast = [0.5, 1.0] call BIS_fnc_randomNum;
			0 setOverCast rndOverCast;
			0 setRain _position;
			forceWeatherChange;
        } else {
            // systemchat "Aborted";
        };
    },
    "Set rain",
    "Abort"
] call CAU_UserInputMenus_fnc_slider;