class_name VoidHunter extends VoidKeeper

@export var chase_range: float = 200.0
@export var dash_interval: float = 3.0

var dash_timer: Timer

func _ready() -> void:
	super()
	fsm.add_states(_chase_normal)
	fsm.set_initial_state(_wander_normal)  # From parent
	
	dash_timer = Timer.new()
	dash_timer.wait_time = dash_interval
	dash_timer.autostart = true
	dash_timer.timeout.connect(_dash)
	add_child(dash_timer)

func _chase_normal() -> void:
	base_chase_normal(chase_range, wander_speed)

func _dash() -> void:
	if fsm.current_state == _chase_normal:
		velocity_comp.apply_knockback((Player.I.global_position - global_position).normalized() * 300, 0.3)
