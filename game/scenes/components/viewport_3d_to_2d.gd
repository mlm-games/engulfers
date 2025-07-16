@tool
class_name SubViewport3DTo2D extends SubViewport

func _init() -> void:
	transparent_bg = true
	gui_disable_input = true
	size = Vector2(250, 250)
