// https://github.com/ConnorAU/A3UserInputMenus/wiki
// add a3userinputmenus to mission, then:

// _nul = [] execVM "fnc_setOverCastSlider.sqf";

currentOvercast = format["Current overcast is %1 - Change overcast to", overcast];
[
    [
        [0.0,1.0],
        overcast,
        [0.1,0.1]
    ],
	currentOvercast,
    {format["%1", _position]},
    {
		if _confirmed then {
			if (_position > 0.6) then { 
				rndRain = random 1; 
				0 setRain rndRain;
				// NOTE: The following will have no effect (even though the value of lightnings changes) unless Manual Override option is enabled in 'Attributes->Environment->Lightnings'
				if (_position > 0.7) then { 
					rndLightnings = [0.1, 1.0] call BIS_fnc_randomNum;
					0 setLightnings rndLightnings;
				};
			}else { 
				0 setRain 0;
				lightningOn = false;
			};
			0 setOverCast _position;
			forceWeatherChange;
        } else {
            // systemchat "Aborted";
        };
    },
    "Set overcast",
    "Abort"
] call CAU_UserInputMenus_fnc_slider;