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
	VoidKeeper = preload("res://game/scenes/void_keeper.tscn"),
	#VoidLiner = preload("res://game/scenes/void_liner.tscn"),
}

enum Groups {
	ENTITIES
}

const SCENE_PATHS = {
	MENU = "uid://cgcvpk7q28k7p",
	WORLD = "uid://d1dgb8mfo8xtw",
	SETTINGS = "uid://dp42fom7cc3n0",
}
