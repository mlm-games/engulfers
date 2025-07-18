class_name BaseLevel extends Node2D

@onready var level_id = name.to_upper() 

func _ready() -> void:
	GameFeel.animate_from_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 1.5)


func complete_level():
	print("Level completed: " + str(level_id))
	
	LevelManager.I.advance_to_next_level()
