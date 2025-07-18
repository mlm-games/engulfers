class_name VoidTutorial extends BaseVoidEntity

func _init() -> void:
	super()
	
	fsm.add_states(_idle_normal, _idle_enter, _idle_leave)
	fsm.add_states(_wander_normal, _wander_enter)

@export var wander_speed: float = 50.0  
@export var wander_radius: float = 100.0
@export var idle_time_range: Vector2 = Vector2.ONE * 3.0  # Longer idle periods (to reduce for keeper)

var idle_timer: RandOneShotTimer

func _ready() -> void:
	super()
	
	idle_timer = RandOneShotTimer.new(idle_time_range, self)
	fsm.set_initial_state(_wander_normal)
	
	idle_timer.timeout.connect(fsm.change_state.bind(_wander_normal))
	
	## Voft void glow
	#var material = $VisualComponent/Sprite2D.material.duplicate()
	#material.set_shader_parameter("wave_amplitude", 5.0)
	#material.set_shader_parameter("water_tint", Color(0.3, 0.5, 0.7, 1.0))
	#$VisualComponent/Sprite2D.material = material

#region Wander State
func _wander_normal() -> void:
	if abs(global_position.distance_to(target_pos)) < 10.0: #NOTE #FIXME Adding a timer to proceed if colliding with wwalls DOES NOT WORK... But is it too late?
		fsm.change_state(_idle_normal)
	velocity_comp.accelerate_to((target_pos - global_position).normalized(), wander_speed)
	look_at(-target_pos)

func _wander_enter() -> void:
	target_pos = global_position + Vector2(randf_range(-wander_radius, wander_radius), randf_range(-wander_radius, wander_radius))
#endregion

#region Idle State
func _idle_enter() -> void:
	idle_timer.rand_start()

	
#endregion

func _void_transfer_normal():
	if !mv_tween.is_running():
		fsm.change_state(_wander_normal)
