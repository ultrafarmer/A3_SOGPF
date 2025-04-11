// Example call:
// test = [[24,-12,-12,1,1],"fnc_wingman.sqf"] remoteExec ["BIS_fnc_execVM",2];
// Params explained:
// _xformpos = formation pos meters left/right of player vehicle
// _yformpos = formation pos meters front/behind player vehicle
// _zformpos = formation pos meters above/under player vehicle
// "should wingman fire when I fire" (1 = true, 0 = false)
// "should wingman aircraft approach with a fly in (1 = true) or spawn in formation immediately  (0 = false)

params [
	"_xformpos","_yformpos","_zformpos","_wingman_twinfire","_fly_in"
];  
	if ( _xformpos > 40 || _xformpos < -40 || _yformpos > 40 || _yformpos < -40 || _zformpos > 40 || _zformpos < -40 ) exitWith
	{
		systemChat "fnc_wingman: Formation position too far away. No dice.";
	};
	// helis fly low, in this case attach them at a z position above player vehicle
	if (vehicle player isKindOf "Helicopter") then{
		_zformpos = 10;
	};
	wingman_group = createGroup [(side player), true];
	wingman_aircraft =  createVehicle [(typeOf vehicle player), ((vehicle player) modelToWorld[0,-1000,(getposATL (vehicle player) select 2)]),[], 0, "FLY"];   
	wingman_pilot = wingman_group createUnit [(typeOf player), ((vehicle player) modelToWorld[0,-1000,(getposATL (vehicle player) select 2)]) , [], 0, "FORM"];
	wingman_pilot moveInDriver wingman_aircraft;
	createVehicleCrew wingman_aircraft;
	{ _x disableAI "RADIOPROTOCOL"; }forEach crew wingman_aircraft;
	[wingman_pilot] joinSilent group (player);
	wingman_aircraft enableDynamicSimulation false; 
	wingman_aircraft flyInHeight (getposATL (vehicle player) select 2); 
	wingman_aircraft setPos (vehicle player modelToWorld[0,-1000,(getposATL (vehicle player) select 2)]); 
	vel = velocity (vehicle player);   
	dir = direction (vehicle player); 
	wingman_aircraft setDir dir;   
	speed_veh_player = -10;   
	wingman_aircraft setVelocity [   
		(vel select 0) + (sin dir * speed_veh_player),   
		(vel select 1) + (cos dir * speed_veh_player),   
		(vel select 2)   
	];
	
	max_speed_veh_player = getNumber(configFile >> "cfgVehicles" >> (typeOf vehicle player) >> "maxSpeed");
    half_max_speed_veh_player = round(max_speed_veh_player / 2);
    _future = time + 60; // timeout after 60 seconds, attach wingman
	if ( _fly_in == 1) then{ 
		while {((vehicle player) distance wingman_aircraft > 300) && time < _future} do {   
			wingman_aircraft flyInHeight (getposATL (vehicle player) select 2); 
			wingman_aircraft moveTo getPosATL (vehicle player);  
			current_speed_veh_player = speed (vehicle player);  
			wingman_aircraft_speedLimit = round(current_speed_veh_player + 200);
			wingman_aircraft limitSpeed wingman_aircraft_speedLimit; 
			wingman_aircraft forceSpeed wingman_aircraft_speedLimit; 
			(vehicle player) setAirplaneThrottle 0.3;  
			(vehicle player) limitSpeed half_max_speed_veh_player;  
			sleep 0.5;
		}; 
	};
	[0, "BLACK", 0.5, 1] spawn BIS_fnc_fadeEffect;
	sleep 1;
	wingman_aircraft attachTo [(vehicle player), [_xformpos,(_yformpos + 18),_zformpos]];
	[1, "BLACK", 0.5, 1] spawn BIS_fnc_fadeEffect;
	
	_nul = [] execVM "fnc_RandomWingmanJoinTalk.sqf";
	
	if (_wingman_twinfire == 1 ) then{
		player addEventHandler ["FiredMan", { params ["", "_weapon", "", "_mode"]; 
					{ _x enableSimulation true; }forEach crew wingman_aircraft;	
					{ _x forceWeaponFire [_weapon,_mode]; }forEach crew wingman_aircraft;	
					{ _x enableSimulation false; }forEach crew wingman_aircraft;
			}
		];
	};
		
	wingman_aircraft addEventHandler [ "Killed", { player removeAction _wingmanoff; detach wingman_aircraft; { _x enableSimulation true; _x setDamage 1; }forEach crew wingman_aircraft; } ];
    driver wingman_aircraft addEventHandler [ "Killed", { player removeAction _wingmanoff; wingman_aircraft setDamage 1; detach wingman_aircraft; { _x enableSimulation true; _x setDamage 1; }forEach crew wingman_aircraft; } ];
	
	(vehicle player) limitSpeed -1;
	wingman_aircraft limitSpeed -1; 
	wingman_aircraft forceSpeed -1; 
	
	// to prevent wingman pilots fading in small distance, and to prevent wingmanpilots from floating in the cockpit when manouvering
	{ _x enableSimulation false}forEach crew wingman_aircraft;
	
	// Brute force make spawned wingmen, leave formation radius 80
	_wingmanoff = player addAction ["Wingman OFF", { 
		_nul = [] execVM "fnc_RandomWingmanLeaveTalk.sqf";
		[]spawn {
			private _list = nearestObjects [(vehicle player), [], 80]; 
			_list = _list - [vehicle player];
			_list = _list - [player];
			player removeAllEventHandlers "FiredMan";
			{detach _x, _x enableSimulation true, _x removeAllEventHandlers "HandleDamage",_x removeAllEventHandlers "Killed"} forEach _list; 
			sleep 16; 
			{deleteVehicleCrew _x, deleteVehicle _x } forEach _list; 
		};
		(_this select 0) removeaction (_this select 2);
		player addAction ["Wingman ON",{   
			wingman = [[24,-12,-12,1,0],"fnc_wingman.sqf"] remoteExec ["BIS_fnc_execVM",2];  
			(_this select 0) removeaction (_this select 2);   
		},nil,21,false,true,"", ""];
	
		}, [],21,false,true];	