// for SOGPF and UNSUNG REDUX STABLE
// call example ("navy" planes)
// _nul = ["navy"] execVM "fnc_ambient_flyby_over_ground.sqf";

_theater = _this select 0;

randomXflyby = [-500, 500] call BIS_fnc_randomInt;       
randomYflyby = [1500, 2000] call BIS_fnc_randomInt;
randomZflyby = [250, 800] call BIS_fnc_randomInt; 
destPosX = [-1000, 1000] call BIS_fnc_randomInt;
destPosY = randomYflyby - (randomYflyby * 3);
wingmanXoffset = 25;
wingmanYoffset = 10;
wingmanZoffset = 15;
_speedMode = "FULL"; 
flybyplane = "";

flyby_accepted = false;

allFlyByPlanes = [
	"uns_A4B_skyhawk_CAS",
	"uns_A7N_CAS",
	"uns_ov10_navy_CAS",
	"uns_A1J_navy_CAS",
	"uns_a3avah2",
	"uns_c1a",
	"uns_c1a",
	"uns_c1a",
	"uns_C130_H_cargo",
	"uns_C130_H_cargo",
	"uns_C130_H_cargo",
	"uns_b52h_mb",
	"uns_b52h_lb2",
	"uns_b52h",
	"uns_b52h_bb",
	"vn_b_air_ah1g_04",
	"vn_b_air_oh6a_04",
	"vn_b_air_uh1c_02_02",
	"vn_b_air_uh1c_05_01",
	"vn_b_air_uh1e_02_04",
	"vn_b_air_ach47_01_01",
	"vn_b_air_ah1g_04",
	"vn_b_air_oh6a_04",
	"vn_b_air_uh1c_02_02",
	"vn_b_air_uh1c_05_01",
	"vn_b_air_uh1e_02_04",
	"uns_A7_CAS",
	"uns_f105D_CAS",
	"UNS_F111_BMB",
	"uns_A6_Intruder_USMC_CAS",
	"uns_A4E_skyhawk_USMC_CAS"
];

switch (_theater) do            
{
	case "navy": { randomXflyby = [-250, 250] call BIS_fnc_randomInt; flybyplane = selectRandom ["uns_A4B_skyhawk_CAS","vn_b_air_f4b_navy_cas","uns_A7N_CAS","uns_ov10_navy_CAS","uns_A1J_navy_CAS","uns_a3avah2"]; };
	case "aafb": { randomZflyby = [250, 800] call BIS_fnc_randomInt; flybyplane = selectRandom ["uns_c1a","uns_c1a","uns_c1a","vn_b_air_f4b_navy_at","vn_b_air_f4c_at","vn_b_air_f4b_usmc_at","uns_C130_H_cargo","uns_C130_H_cargo","uns_C130_H_cargo","uns_b52h_mb","uns_b52h_lb2","uns_b52h","uns_b52h_bb"]; };
	case "heli": { flybyplane = selectRandom ["vn_b_air_ach47_01_01","vn_b_air_ah1g_04","vn_b_air_oh6a_04","vn_b_air_uh1c_02_02","vn_b_air_uh1c_05_01","vn_b_air_uh1e_02_04","vn_b_air_ch34_04_02"]; };
	default { flybyplane = selectRandom allFlyByplanes; };
};

switch (true) do            
{
	case (flybyplane IN ["uns_c1a","uns_C130_H_cargo","uns_b52h_mb","uns_b52h_lb2","uns_b52h","uns_b52h_bb"]): {
		randomZflyby = [400, 800] call BIS_fnc_randomInt;
	};
	case (flybyplane IN ["vn_b_air_ach47_01_01","vn_b_air_ah1g_04","vn_b_air_oh6a_04","vn_b_air_uh1c_02_02","vn_b_air_uh1c_05_01","vn_b_air_uh1e_02_04","vn_b_air_ch34_04_02"]): {
		randomZflyby = [80, 300] call BIS_fnc_randomInt;
	};
	default { randomZflyby = [125, 550] call BIS_fnc_randomInt; };
};

	


if (flybyplane in ["uns_C130_H_cargo","UNS_F111_BMB","UNS_F111_CBU"]) then {
	wingmanXoffset = 60;
};

if (flybyplane in ["uns_b52h_siop1","uns_b52h_mb","uns_b52h_lb2","uns_b52h","uns_b52h_bare","uns_b52h_bb"]) then {
	wingmanXoffset = 100;
};

if (flybyplane in ["vn_b_air_ach47_01_01","vn_b_air_ah1g_04","vn_b_air_oh6a_04","vn_b_air_uh1c_02_02","vn_b_air_uh1c_05_01","vn_b_air_uh1e_02_04","vn_b_air_ch34_04_02"]) then {
	wingmanXoffset = 50;
};



if (flybyplane in ["uns_C130_H_cargo","uns_b52h_siop1","uns_b52h_mb","uns_b52h_lb2","uns_b52h","uns_b52h_bare","uns_b52h_bb"]) then {
	_speedMode = "NORMAL";
	randomZflyby = [300, 700] call BIS_fnc_randomInt; 
};

_rnddirection = [1, 2] call BIS_fnc_randomInt; 
switch (_rnddirection) do            
{    
	// fly from player instead of against
	case 1: { 
		randomXflyby = randomXflyby - (randomXflyby * 2);       
		randomYflyby = randomYflyby - (randomYflyby * 2);
		destPosX = destPosX - (destPosX * 2);
		destPosY = destPosY - (destPosY * 2);
	};
};
if (dayTime > 18 || dayTime < 6) then {
	_diceroll = [1,100] call BIS_fnc_randomInt;
	if (_diceroll > 79) then {
		flyby_accepted = true;
	};
} else {
	_diceroll = [1, 100] call BIS_fnc_randomInt;
	if (_diceroll > 35) then {
		flyby_accepted = true;
	};
};

if (flyby_accepted) then {
	[(player modelToWorld[randomXflyby,randomYflyby,randomZflyby]), (player modelToWorld[destPosX,destPosY,randomZflyby]), randomZflyby, _speedMode, flybyplane, west] call BIS_fnc_ambientFlyby;        
	_diceroll = [1,100] call BIS_fnc_randomInt;
	if (_diceroll > 15) then {
		[(player modelToWorld[(randomXflyby + wingmanXoffset),(randomYflyby - wingmanYoffset),(randomZflyby + wingmanZoffset)]), (player modelToWorld[(destPosX + wingmanXoffset),(destPosY - wingmanYoffset),(randomZflyby + wingmanZoffset)]), randomZflyby, _speedMode, flybyplane, west] call BIS_fnc_ambientFlyby;                
	}; 
};