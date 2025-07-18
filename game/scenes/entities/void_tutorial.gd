class_name VoidTutorial extends BaseVoidEntity

@export var wander_speed: float = 50.0  # Slow movement
@export var wander_radius: float = 100.0  # Small wander area
@export var idle_time: float = 3.0  # Longer idle periods

func _ready() -> void:
	super()
	fsm.add_states(_idle_normal, _idle_enter, _idle_leave)
	fsm.add_states(_wander_normal, _wander_enter)
	fsm.set_initial_state(_wander_normal)
	
	## Voft void glow
	#var material = $VisualComponent/Sprite2D.material.duplicate()
	#material.set_shader_parameter("wave_amplitude", 5.0)
	#material.set_shader_parameter("water_tint", Color(0.3, 0.5, 0.7, 1.0))
	#$VisualComponent/Sprite2D.material = material

func _physics_process(_delta: float) -> void:
	fsm.update()


#region Wander State
func _wander_normal() -> void:
	if global_position.distance_to(target_pos) < 10.0:
		fsm.change_state(_idle_normal)
	velocity_comp.accelerate_to((target_pos - global_position).normalized(), wander_speed)

func _wander_enter() -> void:
	target_pos = global_position + Vector2(randf_range(-wander_radius, wander_radius), randf_range(-wander_radius, wander_radius))
#endregion

#region Idle State
func _idle_enter() -> void:
	velocity_comp.stop()
	await get_tree().create_timer(randf_range(1.0, idle_time)).timeout
	fsm.change_state(_wander_normal)
#endregion
