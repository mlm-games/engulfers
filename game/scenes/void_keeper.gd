class_name VoidKeeper extends BaseVoidEntity

#@export var dash_speed: float = 200.0
#@export var dash_cooldown: float = 5.0
@export var speed: float = 100.0
@export var wander_radius: float = 200.0
@export var idle_time: float = 2.0

@onready var particle_component: VoidParticleComponent = $ParticleTrail

func _ready() -> void:
	super()
	fsm.add_states(_idle_normal, _idle_enter, _idle_leave)
	fsm.add_states(_wander_normal, _wander_enter, _wander_leave)
	
	fsm.set_initial_state(_wander_normal)
	
	particle_component.set_particle_data(particle_configuration)
	
	particle_component.void_consume.connect(func(gp): target_pos = gp; fsm.change_state(_void_transfer_normal))

func _physics_process(_delta: float) -> void: 
	fsm.update()

func _void_transfer_normal() -> void:
	if not mv_tween.is_running():
		fsm.change_state(_wander_normal)

func _wander_normal() -> void:
	if global_position.distance_to(target_pos) < 10.0:
		fsm.change_state(_idle_normal)
	velocity_comp.accelerate_to((target_pos - global_position).normalized(), speed)

func _wander_enter() -> void:
	target_pos = global_position + Vector2(randf_range(-wander_radius, wander_radius), randf_range(-wander_radius, wander_radius))

func _wander_leave() -> void:
	pass

func _idle_enter() -> void:
	await get_tree().create_timer(randf_range(1.0, idle_time)).timeout
	fsm.change_state(_wander_normal)



#Cut for scope creep, can add later
#func _on_dash_timer_timeout() or _dash_normal -> void:
	#speed = dash_speed
	#await get_tree().create_timer(0.3).timeout
	#speed = base_speed or speed / 2
