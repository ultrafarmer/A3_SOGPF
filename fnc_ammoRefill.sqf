// This adds 3 mags for players primary and secondary weapon, and handgun
// _nul = [] execVM "fnc_ammoRefill.sqf";

primWeaponMag = primaryWeaponMagazine player;
secWeaponMag = secondaryWeaponMagazine player;
handgunMag = handgunMagazine player;

if !(primWeaponMag isEqualTo []) then {
	player addMagazines [(primWeaponMag select 0), 3];
};

if !(secWeaponMag isEqualTo []) then {
	player addMagazines [(secWeaponMag select 0), 3];
};

if !(handgunMag isEqualTo []) then {
	player addMagazines [(handgunMag select 0), 3];
};