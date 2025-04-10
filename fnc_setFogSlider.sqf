// https://github.com/ConnorAU/A3UserInputMenus/wiki
// add a3userinputmenus to mission, then:

// _nul = [] execVM "fnc_setFogSlider.sqf";

rndFogIntensity = [0.005, 0.01] call BIS_fnc_randomNum;
rndFogAltitude = [5, 10] call BIS_fnc_randomNum;

currentFog = format["Current fog level is %1 - Change fog level to", fog];
[
    [
        [0.0,1.0],
        fog,
        [0.1,0.1]
    ],
	currentFog,
    {format["%1", _position]},
    {
		if _confirmed then {
			0 setFog [_position, rndFogIntensity, rndFogAltitude];
			forceWeatherChange;
        } else {
            // systemchat "Aborted";
        };
    },
    "Set fog",
    "Abort"
] call CAU_UserInputMenus_fnc_slider;