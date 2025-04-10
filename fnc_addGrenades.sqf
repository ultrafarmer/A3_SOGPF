// https://github.com/ConnorAU/A3UserInputMenus/wiki
// add a3userinputmenus to mission, then:

// _nul = [] execVM "fnc_addGrenades.sqf";


_classNames = [
	"vn_rdg2_mag",
	"vn_molotov_grenade_mag",
	"vn_f1_grenade_mag",
	"vn_rg42_grenade_mag",
	"vn_rgd5_grenade_mag",
	"vn_rgd33_grenade_mag",
	"vn_rkg3_grenade_mag",
	"vn_t67_grenade_mag",
	"vn_chicom_grenade_mag",
	"vn_m18_purple_mag",
	"vn_m18_red_mag",
	"vn_m18_yellow_mag",
	"vn_m18_white_mag",
	"vn_m18_green_mag",
	"vn_m34_grenade_mag",
	"vn_m14_grenade_mag",
	"vn_m14_early_grenade_mag",
	"vn_m7_grenade_mag",
	"vn_m61_grenade_mag",
	"vn_v40_grenade_mag",
	"vn_m67_grenade_mag",
	"vn_satchelcharge_02_throw_mag"
];

_classNames sort true; 

private _vehicles = _classNames apply {
	[
		[getText(configFile >> "CfgMagazines" >> _x >> "displayNameShort")],
		[],
		[getText(configFile >> "CfgMagazines" >> _x >> "picture")],
		[getText(configFile >> "CfgMagazines" >> _x >> ""),[random 1,random 1,random 1,1]],
		str _x,
		_x,
		getNumber(configFile >> "CfgMagazines" >> _x >> "scope")
	]
};

[
	[
		_vehicles,
		0, // Selects the first by default
		false // Multi select disabled
	],
	"Add grenades",
	{
		if _confirmed then {
			grenadeTypeChosen = _data;	
			for "_i" from 0 to 2 do { player addItem grenadeTypeChosen};
		},
	},
	"", // reverts to default
	""  // reverts to default, disable cancel option
] call CAU_UserInputMenus_fnc_listbox;