class_name PlayerInputController extends Node2D

signal direction_changed(direction: Vector2)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	direction_changed.emit(direction)
