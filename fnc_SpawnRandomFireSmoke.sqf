// To spawn fire and smoke (and optional burned ground decals) in a combat area defined by a radius related to a given position
// Examples:
// _nul = ["spawn",position player,3,100,{"yes"}|{"no"}{"random"}] execVM "fnc_SpawnRandomFireSmoke.sqf";
// _nul = ["delete",position player,3,100,{"yes"}|{"no"}{"random"}] execVM "fnc_SpawnRandomFireSmoke.sqf";


_action = _this select 0;
_spawnPos = _this select 1;
_nrOfEffects = _this select 2;
_radius = _this select 3;
_addBurnedGroundDecals = _this select 4;

_effectTypesSmoke = [
	"Particle_BigFire_F"
];

_effectTypesSmokeAndFire = [
	"Particle_BigFire_F"
];

_effectTypesFire = [
	"Particle_BigFire_BurnPit_F",
	"Particle_BigFire_NoSmoke_F"
];

_effectType = "";

switch (_action) do            
{            
	case "spawn": {
		for "_i" from 1 to _nrOfEffects do { 
			private _location = _spawnPos;  
			private _RanPosx = (sin (random 360)) * (random _radius); 
			private _RanPosy = (cos (random 360)) * (random _radius); 
			_rndEffectType = [1, 60] call BIS_fnc_randomInt;
			switch (true) do            
			{            
				case (_rndEffectType < 21 && _rndEffectType > 0): { _effectType = selectRandom _effectTypesSmoke; };
				case (_rndEffectType < 41 && _rndEffectType > 20): { _effectType = selectRandom _effectTypesSmokeAndFire; };
				case (_rndEffectType > 40): { _effectType = selectRandom _effectTypesFire; };
			};
			private _object = createVehicle [_effectType, _location, [], 0, "CAN_COLLIDE"];
			_object setPosASL ([(_location select 0) + _RanPosx,(_location select 1)+_RanPosy,(getTerrainHeightASL[(_location select 0) + _RanPosx,(_location select 1)+_RanPosy])]); 
			switch (_addBurnedGroundDecals) do            
			{
				case "yes":{
					private _burnedGround = createVehicle ["vn_ground_burned_01", getPos _object, [], 0, "CAN_COLLIDE"];
					private _burnedGroundEmbers = createVehicle ["vn_ground_embers_01", getPos _object, [], 0, "CAN_COLLIDE"];
				};
				case "random":{
					_rndGroundDecal = [1, 20] call BIS_fnc_randomInt;
					switch (true) do            
					{
						case (_rndGroundDecal > 10 && _effectType In ["Particle_MediumFire_F","Particle_SmallFire_F","Particle_BigFire_F","Particle_SmallFire_NoSmoke_F","Particle_MediumFire_NoSmoke_F","Particle_BigFire_NoSmoke_F"]): {
							private _burnedGround = createVehicle ["vn_ground_burned_01", getPos _object, [], 0, "CAN_COLLIDE"];
							private _burnedGroundEmbers = createVehicle ["vn_ground_embers_01", getPos _object, [], 0, "CAN_COLLIDE"];
						};
					};
				};
			};

		};
	};
	case "delete": {
		_rawlist = nearestObjects [_spawnPos,["vn_ground_embers_01","vn_ground_burned_01","Particle_MediumSmoke_F","Particle_WreckSmokeSmall_F","Particle_SmallSmoke_F","Particle_BigSmoke_F","Particle_MediumFire_F","Particle_SmallFire_F","Particle_BigFire_F","Particle_SmallFire_NoSmoke_F","Particle_MediumFire_NoSmoke_F","Particle_BigFire_NoSmoke_F"],_radius];
		_deletelist = _rawlist - (nearestTerrainObjects [_spawnPos, [], _radius]);
		{ deleteVehicle _x } foreach _deletelist;
	};
};

	
 
