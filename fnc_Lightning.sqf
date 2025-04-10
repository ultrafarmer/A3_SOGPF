// This spawns a period of lightning strikes around player.
// Brightness 100 results in a realistic lightning flash regarding brightness
// call example:
// _nul = [30,5,100,100] execVM "fnc_Lightning.sqf";

_lightningTimeout = _this select 0;
_delay = _this select 1;
_distance = _this select 2;
_ligtningBrightness = _this select 3;

private _fncLightning = { 
_lightningcentre = player modelToWorld [0,_distance,0];
params [ 
	["_centre", _lightningcentre, [[]]], 
	["_radius", 300, [0]], 
	["_dir", random 360, [0]] 
]; 
private _pos = _centre getPos [_radius, _dir]; 
private _bolt = createVehicle ["LightningBolt", _pos, [], 0]; 
_bolt setPosATL _pos; 
_bolt setDamage 1; 
 
private _light = "#lightpoint" createVehiclelocal _pos; 
_light setPosATL (_pos vectorAdd [0,0,10]); 
_light setLightDayLight true; 
_light setLightBrightness _ligtningBrightness; 
_light setLightAmbient [0.05, 0.05, 0.1]; 
_light setlightcolor [1, 1, 2]; 

sleep 0.1; 
_light setLightBrightness 0; 
sleep (random 0.1); 

private _lightning = (selectRandom ["lightning1_F","lightning2_F"]) createVehiclelocal [100,100,100]; 
_lightning setdir _dir; 
_lightning setpos _pos; 

for "_i" from 0 to (1 + random 1) do { 
	private _time = time + 0.1; 
	_light setLightBrightness ((_ligtningBrightness / 2) + random (_ligtningBrightness / 2)); 
	waituntil { 
		time > _time 
	}; 
}; 

deletevehicle _lightning; 
deletevehicle _light; 
}; 
  
 
_timeOut = time + _lightningTimeout; 
while {time < _timeOut && lightningOn} do { 
	_intensity = 1 + round (random 1); 
	for "_i" from 1 to _intensity do { 
		[position player, (random 500) + 300] call _fncLightning; 
	}; 
	sleep (random _delay) + (random _delay); 
}; 