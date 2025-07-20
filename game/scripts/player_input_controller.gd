class_name PlayerInputController extends Node2D

signal direction_changed(direction: Vector2)
signal trigger_shoot()

var enabled := true

func _physics_process(_delta: float) -> void:
	if enabled:
		var direction := Input.get_vector("left", "right", "up", "down")
		
		direction_changed.emit(direction)

func  _input(event: InputEvent) -> void:
	if enabled:
		if event.is_action_pressed("ui_accept") and event.is_pressed():
			trigger_shoot.emit()
