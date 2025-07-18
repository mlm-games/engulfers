class_name VoidWatcher extends BaseVoidEntity

@export var patrol_speed: float = 80.0
@export var sight_range: float = 150.0
@export var shoot_cooldown: float = 2.0

@onready var path_follow: PathFollow2D = $PathFollow2D 
var shoot_timer: Timer

func _ready() -> void:
	super()
	fsm.add_states(_patrol_normal)
	fsm.add_states(_attack_normal)
	fsm.set_initial_state(_patrol_normal)
	
	shoot_timer = Timer.new()
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.autostart = true
	shoot_timer.timeout.connect(_shoot_if_in_sight)
	add_child(shoot_timer)

func _physics_process(delta: float) -> void:
	super(delta)
	path_follow.progress += patrol_speed * delta
	global_position = path_follow.global_position

func _patrol_normal() -> void:
	if global_position.distance_to(Player.I.global_position) < sight_range:
		fsm.change_state(_attack_normal)

func _attack_normal() -> void:
	velocity_comp.stop()  # Stop to attack
	# Look at player
	look_at(Player.I.global_position)

func _shoot_if_in_sight() -> void:
	if fsm.current_state == _attack_normal:
		var proj = Util.spawn_at_pos(self)
		proj.global_rotation = (Player.I.global_position - global_position).angle()
