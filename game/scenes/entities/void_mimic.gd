class_name VoidMimic extends VoidKeeper

var mimic_buffer: Array[Vector2] = []
var mimicking: bool = false
@export var buffer_size: int = 20  # Delay in mimicking

func _physics_process(_delta: float) -> void:
	if mimicking:
		if mimic_buffer.size() > 0:
			target_pos = mimic_buffer.pop_front()
			velocity_comp.accelerate_to((target_pos - global_position).normalized(), wander_speed)
		else:
			mimicking = false
			fsm.change_state(_wander_normal)
	else:
		mimic_buffer.append(Player.I.global_position)
		if mimic_buffer.size() > buffer_size:
			mimicking = true
