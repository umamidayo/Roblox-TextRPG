local module = {}

module.Attributes = {
	["Descriptive"] = {
		["Inanimate"] = {
			"Abandoned",
			"Dark",
			"Broken",
			"Bright",
			"Pretty",
			"Beautiful",
			"Cute",
		},
		
		["Animate"] = {
			"Cute",
			"Beautiful",
			"Pretty",
			"Dead",
			"Wounded",
			"Enraged",
			"Sick",
			"Happy",
		},
		
	},
	
	["Fill"] = {
		"Water",
		"Coffee",
		"Blood",
		"Trash",
	},
}

module.Encounter = {
	["Location"] = {
		["Unnatural"] = {
			"House",
			"Camp",
			"Town",
			"Hut",
			"Farm",
			"Shack",
		},
		
		["Natural"] = {
			"Plains",
			"Woods",
			"Forest",
			"Cave",
			"Lake",
			"Pond",
			"Sea",
			"Ocean",
		},
	},
	
	["Friendly"] = {
		["General"] = {
			"Doctor",
			"Civilian",
			"Cat",
			"Dog",
			"Horse",
		}
	},
	
	["Enemy"] = {
		["General"] = {
			"Murderer",
			"Killer",
			"Thief",
			"Robber",
			"Mugger",
			"Psychopath",
		},
		
		["Fantasy"] = {
			"Bandit",
			"Rogue",
			"Pirate",
		},
		
		["Future"] = {
			"Marauder",
			"Alien",
			"Parasite",
		},
	},
	
	["Objects"] = {
		["Weapon"] = {
			"Sword",
			"Katana",
			"Stick",
			"Dagger",
			"Mace",
			"Axe",
			"Hammer",
			"Bow",
			"M110",
			"M4A1",
			"M249",
			"Revolver",
			"Glock-19",
		},

		["Fillable"] = {
			"Bottle",
			"Mug",
			"Bag",
		}
	}
}

module.Perform = {
	["Actions"] = {
		"Pick up",
		"Drop",
		"Equip",
		"Unequip",
		"Crouch",
		"Lay down",
		"Talk",
		"Walk",
		"Crawl",
		"Move",
		"Run",
		"Sprint",
	},
	
	["Ranged"] = {
		"Reload",
		"Shoot",
		"Spray",
		"Fire",
		"Aim",
	},
	
	["Melee"] = {
		"Swing",
		"Attack",
		"Hit",
		"Stab",
	},
}

return module
