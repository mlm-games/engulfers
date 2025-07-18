class_name VoidLiner extends VoidKeeper

@export var shoot_interval: float = 3.0      # Random shot every 3s
@export var provoked_shoot_interval: float = 1.0  # Faster when provoked
@export var chase_speed_multiplier: float = 1.5   # Faster chase speed

var shoot_timer: Timer
var provoked_timer: Timer
var is_provoked: bool = false
var attacker: Node2D = null  # Entity that shot at us


func _ready() -> void:
	super()
	
	shoot_timer = Timer.new()
	shoot_timer.wait_time = shoot_interval
	shoot_timer.autostart = true
	shoot_timer.timeout.connect(_shoot_random_target)
	add_child(shoot_timer)
	
	provoked_timer = Timer.new()
	provoked_timer.wait_time = 2.0 
	provoked_timer.one_shot = true
	provoked_timer.timeout.connect(_trigger_provoked_state)
	add_child(provoked_timer)
	
	%MissedProjectileDetectionArea2D.area_entered.connect(_on_missed_shot)

func _shoot_random_target() -> void:
	if not is_provoked:
		var targets = get_tree().get_nodes_in_group("OnScreenEntities")
		if targets.empty(): return
		var target = targets[randi() % targets.size()]
		_shoot_at(target)

func _shoot_at(target: Node2D) -> void:
	var projectile = Util.spawn_at_pos(self, C.Projectiles.VoidLinerProjectile)
	projectile.direction = (target.global_position - global_position).normalized()
	#AudioM.play_sound(C.Audio.Dash)

#region Provoked state


func _on_missed_shot(body: Node2D) -> void:
	if body is VoidProjectile and body.emitter != self:
		attacker = body.emitter
		# Reset provoked timer (extend if already running)
		if provoked_timer.is_running(): provoked_timer.stop()
		provoked_timer.start()
		$AnimationPlayer.play("provoked_warning")  # Flashes red
		print(get_class(), "Missed shot detected!")

func _trigger_provoked_state() -> void:
	is_provoked = true
	shoot_timer.wait_time = provoked_shoot_interval
	shoot_timer.timeout.disconnect(_shoot_random_target)
	shoot_timer.timeout.connect(_shoot_at_attacker)
	fsm.change_state(_provoked_chase_normal)
	print("Provoked!")

func _provoked_chase_normal() -> void:
	if attacker:
		velocity_comp.accelerate_to((attacker.global_position - global_position).normalized(), wander_speed * chase_speed_multiplier)
		# Stop chasing if attacker is out of range
		if global_position.distance_to(attacker.global_position) > 500:
			_exit_provoked_state()

func _shoot_at_attacker() -> void:
	if attacker: _shoot_at(attacker)

func _exit_provoked_state() -> void:
	is_provoked = false
	attacker = null
	shoot_timer.wait_time = shoot_interval
	shoot_timer.timeout.disconnect(_shoot_at_attacker)
	shoot_timer.timeout.connect(_shoot_random_target)
	fsm.change_state(_wander_normal)

#endregion
