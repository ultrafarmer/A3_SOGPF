// AI units have an affinity to throw smoke grenades, which destroys both fps and immersion.
// This script removes all SOGPF smoke grenades from the target units.
// usage group:
// {_nul = [_x] execVM "fnc_removeSmokeGrenades.sqf";} forEach units (group player);
// usage unit:
// _nul = [player] execVM "fnc_removeSmokeGrenades.sqf";
// usage near men < 200m from player:
// _nearMen = nearestObjects [player, ["Man"], 200];
// {_nul = [_x] execVM "fnc_removeSmokeGrenades.sqf";} forEach _nearMen;

_unit = _this select 0;
_mags = magazines _unit;

{if ((_x == "vn_m18_red_mag") || (_x == "vn_m18_yellow_mag") || (_x == "vn_m18_green_mag") || (_x == "vn_m18_white_mag") || (_x == "vn_m18_purple_mag") || (_x == "vn_v_rdg2_mag") || (_x == "vn_rdg2_mag")) then
	{
		_unit removeMagazines _x;
	};
} forEach _mags;