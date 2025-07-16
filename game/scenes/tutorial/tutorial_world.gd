extends Node2D

func _ready() -> void:
	GameFeel.animate_from_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 2.5)
