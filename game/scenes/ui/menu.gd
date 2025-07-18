extends Control

func _ready() -> void:
	%PlayButton.pressed.connect(LevelManager.I.start_game)
