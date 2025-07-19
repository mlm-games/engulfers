class_name C extends Node

enum Audio {
	Consume,
	Transfer,
	Dash,
	Click,
	Hover,
	HunterSpawn,
	PoliceSpawn,
	MasterSpawn,
	Win,
	Lose
}

const Particles = { # For static typing and exporting of enums, use "" for ones with no particles, Could probably do this for CharacterStats if we want to add icons and stuff
	Consume = preload("uid://bl3j3ma1mkw32"),
	Transfer = preload("uid://cv00hcj82e3vi")
}

const LoadedAudio = { #All sfx
	Audio.Consume: preload("uid://c5uvopnlu5ibd"),
	Audio.Transfer: preload("uid://c5uvopnlu5ibd"),
	Audio.Dash: preload("uid://c5uvopnlu5ibd"),
	Audio.Click: preload("uid://c5uvopnlu5ibd"),
	Audio.Hover: preload("uid://c5uvopnlu5ibd"),
	Audio.HunterSpawn: preload("uid://c5uvopnlu5ibd"),
	Audio.PoliceSpawn: preload("uid://c5uvopnlu5ibd"),
	Audio.MasterSpawn: preload("uid://c5uvopnlu5ibd"),
	Audio.Win: preload("uid://c5uvopnlu5ibd"),
	Audio.Lose: preload("uid://c5uvopnlu5ibd")
}

const Enemies = {
	VoidKeeper = preload("uid://dabg8sulcosd5"),
	#VoidLiner = preload("res://game/scenes/void_liner.tscn"),
}

const Projectiles = {
	PlayerVoidProjectile = "uid://bbt3a13kvykbv",
	VoidKeeperProjectile = "uid://6gqwjut13rcg",
	VoidLinerProjectile = "uid://ccapqmsd0lvuq"
}

enum Groups {
	ENTITIES
}

const SCENE_PATHS = { #NOTE: To prevent cyclic inheritance error
	MENU = "uid://cgcvpk7q28k7p",
	WORLD = "uid://d1dgb8mfo8xtw",
	SETTINGS = "uid://dp42fom7cc3n0",
	TUTORIAL_LEVEL = "uid://2vnoaw7gtgkd",
	END_SCREEN = ""
}

const Levels : Dictionary[StringName, PackedScene] = {
	Level0 = preload("uid://2vnoaw7gtgkd"),
	Level1 = preload("uid://c8p2hg2wy36d3"),
	Level2 = preload("uid://vcl6nui72ku6"),
	Level3 = preload("uid://ct8eig6nd0i6c"),
	Level4 = preload("uid://bylq1pysrncfo"),
	Level5 = preload("uid://cbe687v1s1nj4"),
	Level6 = preload("uid://u46m6v14i6dj")
}
