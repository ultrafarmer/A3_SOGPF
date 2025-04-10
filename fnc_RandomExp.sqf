// This script will spawn explosions and/or aircraft flybys at random positions near player, using randomization to simulate a realistic action (more chance for action during daytime etc)
// call example:
// _nul = [] execVM "fnc_RandomExp.sqf";
randomExp = [1, 39] call BIS_fnc_randomInt;

randomX = [-500, 500] call BIS_fnc_randomInt; 
randomY = [200, 600] call BIS_fnc_randomInt;
randomXshell = [-500, 500] call BIS_fnc_randomInt;       
randomYshell = [200, 600] call BIS_fnc_randomInt;
randomXcloseshell = [-200, 200] call BIS_fnc_randomInt;       
randomYcloseshell = [200, 300] call BIS_fnc_randomInt;
randomXnape = [-500, 500] call BIS_fnc_randomInt;       
randomYnape = [200, 600] call BIS_fnc_randomInt; 
randomYnapeClose = [150, 300] call BIS_fnc_randomInt;
randomZflyby = [75, 250] call BIS_fnc_randomInt;
randomZjetflyby = [75, 250] call BIS_fnc_randomInt;  
randomZheliflyby = [40, 120] call BIS_fnc_randomInt;  


_cas_accepted = false; 
_diceroll = 0; 
 
if (dayTime > 18 || dayTime < 6) then {
	_diceroll = [1, 100] call BIS_fnc_randomInt;
	if (_diceroll > 79 || randomExp > 24 ) then {
		_cas_accepted = true;
	};
} else {
	_diceroll = [1, 100] call BIS_fnc_randomInt;
	if (_diceroll > 19) then {
		_cas_accepted = true;
	};
};

 
switch (randomExp) do            
    {            
        case 1: { 
		   rndShell = selectRandom ["Sh_82mm_AMOS","Sh_155mm_AMOS"]; 
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
				_reactDelay = [8, 12] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};
		};           
        case 2: {
			rndShell = selectRandom ["Sh_82mm_AMOS"];
			_exprandomtarget = (player modelToWorld[randomXcloseshell,randomYcloseshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then { 
				firesupport = [_exprandomtarget,rndShell,100,([1, 3] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
				_reactDelay = [8, 12] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};
		};       
        case 3: {
			rndShell = selectRandom ["Sh_82mm_AMOS"];
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then { 
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual; 
				_reactDelay = [8, 12] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";				
			};
		};       
        case 4: { 
			_exprandomtarget = (player modelToWorld[randomXnape,randomYnape,1]);
			cas_plane = "vn_b_air_f100d_cas";
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;     
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2]; 
			};
		};       
        case 5: { 
			randomYflyby = [1000, 2000] call BIS_fnc_randomInt;
			randomZflyby = [75, 250] call BIS_fnc_randomInt; 
			flybyplane = selectRandom ["vn_b_air_f100d_cap","vn_b_air_f4c_cas","vn_b_air_f4c_cap","vn_b_air_f4c_bmb","vn_b_air_f100d_hbmb","vn_b_air_f100d_bmb"];
			destPosX = [-800, 800] call BIS_fnc_randomInt;
			destPosY = -3000;  
     
		   [(player modelToWorld[randomX,randomYflyby,randomZjetflyby]), (player modelToWorld[destPosX,destPosY,randomZjetflyby]), randomZjetflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
		   randomWingmanFlyby = [1, 2] call BIS_fnc_randomInt;     
		   switch (randomWingmanFlyby) do            
		   {     
				case 2: { 
					randomWingmanXFlyby = [25, 100] call BIS_fnc_randomInt;
					randomWingmanYFlyby = [25, 100] call BIS_fnc_randomInt;
					[(player modelToWorld[(randomX + randomWingmanXFlyby),(randomYflyby - randomWingmanYFlyby),randomZjetflyby]), (player modelToWorld[(destPosX + randomWingmanXFlyby),(destPosY + randomWingmanYFlyby),randomZjetflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};     
				default {};            
		   };        
		};       
        case 6: { 		
			flybyplane = selectRandom ["vn_b_air_ah1g_09","vn_b_air_oh6a_05","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01"];     
			[(player modelToWorld[randomX,1000,randomZheliflyby]), (player modelToWorld[0,-1000,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
			randomWingmanFlyby = [1, 8] call BIS_fnc_randomInt;     
			switch (randomWingmanFlyby) do            
			{     
				case 2: {      
					[(player modelToWorld[(randomX + 25),950,randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 3: {      
					[(player modelToWorld[(randomX + 50),900,randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 4: {
					[(player modelToWorld[(randomX + 45),950,randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 70),900,randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				}; 
				case 5: { 
					[(player modelToWorld[(randomX + 65),950,randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 90),900,randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};   				
				default {};
			};
		};        
        
		case 7: {
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = selectRandom ["Bo_Mk82","Bo_GBU12_LGB_MI10","vn_bomb_500_mk82_he_ammo","Bo_GBU12_LGB_MI10","vn_bomb_750_m117_he_ammo","vn_bomb_1000_mk83_he_ammo","vn_bomb_2000_mk84_he_ammo","vn_bomb_2000_mk84_he_ammo","vn_bomb_500_mk20_cb_ammo"];        
				bmb = rndBomb createVehicle _exprandomtarget;        
			};
		}; 
		case 8: {
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = selectRandom ["Bo_Mk82","Bo_GBU12_LGB_MI10","vn_bomb_500_mk82_he_ammo","Bo_GBU12_LGB_MI10","vn_bomb_750_m117_he_ammo","vn_bomb_1000_mk83_he_ammo","vn_bomb_500_mk20_cb_ammo"];        
				bmb = rndBomb createVehicle _exprandomtarget;        
			};
		};     
        
        case 9: { 
			randomYflyby = [-2000, -1000] call BIS_fnc_randomInt;      
			flybyplane = selectRandom ["vn_b_air_f100d_cap","vn_b_air_f4c_cas","vn_b_air_f4c_cap","vn_b_air_f4c_bmb","vn_b_air_f100d_hbmb","vn_b_air_f100d_bmb"];
			destPosX = [-800, 800] call BIS_fnc_randomInt;
			destPosY = 3000;  
     
			[(player modelToWorld[randomX,randomYflyby,randomZjetflyby]), (player modelToWorld[destPosX,destPosY,randomZjetflyby]), randomZjetflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
			randomWingmanFlyby = [1, 2] call BIS_fnc_randomInt;     
			switch (randomWingmanFlyby) do            
			{     
			case 2: { 
				randomWingmanXFlyby = [25, 100] call BIS_fnc_randomInt;
				randomWingmanYFlyby = [25, 100] call BIS_fnc_randomInt;
				[(player modelToWorld[(randomX + randomWingmanXFlyby),(randomYflyby - randomWingmanYFlyby),randomZjetflyby]), (player modelToWorld[(destPosX + randomWingmanXFlyby),(destPosY - randomWingmanYFlyby),randomZjetflyby]), randomZjetflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
			};     
			default {};            
			};         
		};
        case 10: { 	
			flybyplane = selectRandom ["vn_b_air_ah1g_09","vn_b_air_ch47_04_01","vn_b_air_oh6a_05","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01","vn_b_air_oh6a_05","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01"];     
			randomYflyby = [1500, 1000] call BIS_fnc_randomInt;
			[(player modelToWorld[randomX,randomYflyby,randomZheliflyby]), (player modelToWorld[0,-1000,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
			randomWingmanFlyby = [1, 11] call BIS_fnc_randomInt; 
			switch (randomWingmanFlyby) do            
			{     
				case 1: {  
					if !(flybyplane == "vn_b_air_ch47_04_01") then {
						[(player modelToWorld[(randomX + 35),(randomYflyby - 75),randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;
					};				      
				};
				case 2: {  
					if !(flybyplane == "vn_b_air_ch47_04_01") then {
						[(player modelToWorld[(randomX + 25),(randomYflyby - 50),randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;
					};				      
				};
				case 3: {
					if !(flybyplane == "vn_b_air_ch47_04_01") then {				
						[(player modelToWorld[(randomX + 50),(randomYflyby - 100),randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
					};
				};
				case 4: {
					if !(flybyplane == "vn_b_air_ch47_04_01") then {
						[(player modelToWorld[(randomX + 45),(randomYflyby - 50),randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
						[(player modelToWorld[(randomX + 70),(randomYflyby - 100),randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
					};
				}; 
				case 5: {
					if !(flybyplane == "vn_b_air_ch47_04_01") then {
						[(player modelToWorld[(randomX + 65),(randomYflyby - 50),randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
						[(player modelToWorld[(randomX + 90),(randomYflyby - 100),randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
					};
				}; 
				case 6: {  
					if !(flybyplane == "vn_b_air_ch47_04_01") then {
						[(player modelToWorld[(randomX + 15),(randomYflyby - 25),randomZheliflyby]), (player modelToWorld[0,-1050,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;
					};				      
				};
				case 7: {
					if !(flybyplane == "vn_b_air_ch47_04_01") then {				
						[(player modelToWorld[(randomX + 30),(randomYflyby - 150),randomZheliflyby]), (player modelToWorld[0,-1100,randomZheliflyby]), randomZheliflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
					};
				}; 				
				default {};
			};

		}; 
        case 11: {      
			cas_plane = "vn_b_air_f100d_cas";
			_exprandomtarget = (player modelToWorld[randomXnape,randomXnape,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 12: {      
			cas_plane = "vn_b_air_f100d_cas";
			_exprandomtarget = (player modelToWorld[randomXnape,randomXnape,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 13: {      
			cas_plane = "vn_b_air_f100d_cas";
			_exprandomtarget = (player modelToWorld[randomXnape,randomYnapeClose,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 14: {      
			cas_plane = "vn_b_air_f100d_cas";
			_exprandomtarget = (player modelToWorld[randomXnape,randomYnapeClose,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 15: {      
			cas_plane = "vn_b_air_f100d_cas";
			_exprandomtarget = (player modelToWorld[randomXnape,randomYnapeClose,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};		
        case 16: {
			rndShell = selectRandom ["Sh_82mm_AMOS"];        
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
				_reactDelay = [5, 12] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};      
       
		};
        case 17: {
			rndShell = selectRandom ["Sh_82mm_AMOS","Sh_155mm_AMOS"];        
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
			};      
       
		};
		case 18: {
			rndShell = selectRandom ["Sh_82mm_AMOS"];        
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 2] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
			};      
       
		};	
		case 19: {
			rndShell = selectRandom ["Sh_82mm_AMOS"];        
			_exprandomtarget = (player modelToWorld[randomXcloseshell,randomYcloseshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
				_reactDelay = [5, 12] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};      
       
		};	
		case 20: {
			rndShell = selectRandom ["Sh_82mm_AMOS","Sh_155mm_AMOS"];        
			_exprandomtarget = (player modelToWorld[randomXshell,randomYshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 3] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
			};      
       
		};	
		case 21: {
			rndShell = selectRandom ["Sh_82mm_AMOS"];        
			_exprandomtarget = (player modelToWorld[randomXcloseshell,randomYcloseshell,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				firesupport = [_exprandomtarget,rndShell,100,([1, 5] call BIS_fnc_randomInt),([1, 2] call BIS_fnc_randomNum)] spawn BIS_fnc_fireSupportVirtual;
				_reactDelay = [5, 12] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};      
       
		};
        case 22: { 		
			flybyplane = selectRandom ["vn_b_air_ah1g_09","vn_b_air_oh6a_05","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01"];     
			[(player modelToWorld[randomX,1000,randomZflyby]), (player modelToWorld[0,-1000,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
			randomWingmanFlyby = [1, 10] call BIS_fnc_randomInt;     
			switch (randomWingmanFlyby) do            
			{     
				case 2: {      
					[(player modelToWorld[(randomX + 25),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 3: {      
					[(player modelToWorld[(randomX + 50),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 4: {
					[(player modelToWorld[(randomX + 45),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 70),900,1]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				}; 
				case 5: { 
					[(player modelToWorld[(randomX + 65),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 90),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};   				
				default {};
			};
		};        
        
        case 23: { 		
			flybyplane = selectRandom ["vn_b_air_ah1g_09","vn_b_air_oh6a_05","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01"];     
			[(player modelToWorld[randomX,1000,randomZflyby]), (player modelToWorld[0,-1000,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
			randomWingmanFlyby = [1, 10] call BIS_fnc_randomInt;     
			switch (randomWingmanFlyby) do            
			{     
				case 2: {      
					[(player modelToWorld[(randomX + 25),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 3: {      
					[(player modelToWorld[(randomX + 50),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 4: {
					[(player modelToWorld[(randomX + 45),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 70),900,1]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				}; 
				case 5: { 
					[(player modelToWorld[(randomX + 65),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 90),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};   				
				default {};
			};
		};        

        case 24: { 		
			flybyplane = selectRandom ["vn_b_air_ah1g_09","vn_b_air_oh6a_05","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01","vn_b_air_uh1b_01_01","vn_b_air_uh1c_01_01"];     
			[(player modelToWorld[randomX,1000,randomZflyby]), (player modelToWorld[0,-1000,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;        
			randomWingmanFlyby = [1, 10] call BIS_fnc_randomInt;     
			switch (randomWingmanFlyby) do            
			{     
				case 2: {      
					[(player modelToWorld[(randomX + 25),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 3: {      
					[(player modelToWorld[(randomX + 50),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};
				case 4: {
					[(player modelToWorld[(randomX + 45),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 70),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				}; 
				case 5: { 
					[(player modelToWorld[(randomX + 65),950,randomZflyby]), (player modelToWorld[0,-1050,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      			
					[(player modelToWorld[(randomX + 90),900,randomZflyby]), (player modelToWorld[0,-1100,randomZflyby]), randomZflyby, "FULL", flybyplane, west] call BIS_fnc_ambientFlyby;      
				};   				
				default {};
			};
		};
		// b-52 arc light
		case 25: {
			randomXshell = [-800, 800] call BIS_fnc_randomInt;       
			randomYshell = [800, 400] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);
			
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				_carpet_offset = [500, 1000] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [(_exprandomtarget select 0) - _i, (_exprandomtarget select 1), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};
				_reactDelay = [6, 10] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nul_react = [] execVM "fnc_arc_light_react.sqf";	   
			};
		};
		case 26: {
			randomXshell = [-800, 800] call BIS_fnc_randomInt;       
			randomYshell = [800, 400] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				_carpet_offset = [500, 1000] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [(_exprandomtarget select 0) + _i, (_exprandomtarget select 1), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};
				_reactDelay = [6, 10] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nul_react = [] execVM "fnc_arc_light_react.sqf";     
			};
		};
		case 27: {
			randomXshell = [300, 700] call BIS_fnc_randomInt;       
			randomYshell = [-800, 800] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [(_exprandomtarget select 0), ((_exprandomtarget select 1)  + _i), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};   
			};
		};
		case 28: {
			randomXshell = [-700, -300] call BIS_fnc_randomInt;       
			randomYshell = [-800, 800] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [(_exprandomtarget select 0), ((_exprandomtarget select 1)  - _i), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};      
			};
		};
		case 29: {
			randomXshell = [150, 300] call BIS_fnc_randomInt;       
			randomYshell = [300, 800] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [((_exprandomtarget select 0) - _i), ((_exprandomtarget select 1)  + _i), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};
				_reactDelay = [6, 10] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nul_react = [] execVM "fnc_arc_light_react.sqf";      
			};
		};
		case 30: {
			randomXshell = [-800, -300] call BIS_fnc_randomInt;       
			randomYshell = [-100, 250] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [((_exprandomtarget select 0) + _i), ((_exprandomtarget select 1)  + _i), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};   
			};
		};
		case 31: {
			randomXshell = [100, 300] call BIS_fnc_randomInt;       
			randomYshell = [600, 1000] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [((_exprandomtarget select 0) - _i), ((_exprandomtarget select 1)  - _i), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};
				_reactDelay = [6, 10] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nul_react = [] execVM "fnc_arc_light_react.sqf";      
			};
		};
		case 32: {
			randomXshell = [-100, 200] call BIS_fnc_randomInt;       
			randomYshell = [600, 1000] call BIS_fnc_randomInt;
			_exprandomtarget = ([(getPos player select 0) + randomXshell,(getPos player select 1) + randomYshell,1]);

			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				rndBomb = "vn_bomb_750_m117_he_ammo";
				_carpet_length = [810, 1600] call BIS_fnc_randomInt; 
				for "_i" from 10 to _carpet_length step 20 do {
					_bmbtarget = [((_exprandomtarget select 0) + _i), ((_exprandomtarget select 1)  - _i), 1];
					bmb = rndBomb createVehicle _bmbtarget; 
					_i = _i + 20;
					_delaybetweenbombs = [0.16, 0.5] call BIS_fnc_randomNum;
					sleep _delaybetweenbombs;
				};
				_reactDelay = [6, 10] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nul_react = [] execVM "fnc_arc_light_react.sqf";      
			};
		};
        case 33: {      
			cas_plane = "vn_b_air_f100d_bmb";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 34: {      
			cas_plane = "vn_b_air_f100d_cap";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 1;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 35: {      
			cas_plane = "vn_b_air_f100d_sead";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 2;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 36: {      
			cas_plane = "vn_b_air_f100d_cap";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 1;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
        case 37: {      
			cas_plane = "vn_b_air_f100d_hbmb";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 3;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
				_reactDelay = [15, 20] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};
		};
        case 38: {      
			cas_plane = "vn_b_air_f4c_cas";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 1;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
				_reactDelay = [15, 20] call BIS_fnc_randomInt;
				sleep _reactDelay; 
				_nulartyreact = [] execVM "fnc_arty_react.sqf";
			};
		};
		case 39: {      
			cas_plane = "vn_b_air_f4c_ucas";
			randomXtarget = [-400, 400] call BIS_fnc_randomInt;       
			randomYtarget = [300, 800] call BIS_fnc_randomInt;   
			_exprandomtarget = (player modelToWorld[randomXtarget,randomYtarget,1]);
			if ((_exprandomtarget distance (getMarkerPos "marker_target") > 200) && _cas_accepted) then {
				cas_plane_mode = 1;    
				cas = [[_exprandomtarget,([0, 359] call BIS_fnc_randomInt),cas_plane,cas_plane_mode],"MIL_CAS.sqf"] remoteExec ["BIS_fnc_execVM",2];
			};
		};
		default {};
		
	};