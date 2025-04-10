// This script will spawn immersive light sources near houses at a distance from X (for ex player position) according to params.
// Will light up at night hours, to bring the map locations to life.
// Suited to run at scenario init.
// ~800 light sources in a circle with radius of 4000 from a centre point results in realistic light source distibution throughout the map. 
// A village with houses (the script targets map houses) will not be jampacked with light sources using this distribution ratio. Works good as a generic starting point.
// Ie, about 200 light sources per km2 will yield good results on SOGPF maps.

// call example:
// _nul = [position player ,4000, 800, 5] execVM "fnc_randomStreetLights.sqf";

_centerpos = _this select 0;
_radius = _this select 1; 
_NrOfLights = _this select 2;
_rndDistanceFromHouse = _this select 3;

_roads = nearestTerrainObjects [_centerpos, ["House"], _radius];
for "_i" from 1 to _NrOfLights do {  
  
private _roadposition = getPos (selectRandom _roads); 
private _position = [[[_roadposition, _rndDistanceFromHouse]], []] call BIS_fnc_randomPos; 
private _lightSource = "#lightpoint" createVehicleLocal _position;  
_rndBrightness = [0.02,0.05] call BIS_fnc_randomNum; 

_lightSource setLightColor [216.75,50,0];  
_lightSource setLightAmbient [216.75,50,0];  
_lightSource setLightUseFlare true;  
_lightSource setLightFlareSize 0.5;  
_lightSource setLightFlareMaxDistance 500;  
_lightSource setLightBrightness _rndBrightness;  
_lightSource setLightDayLight false; 

 
};