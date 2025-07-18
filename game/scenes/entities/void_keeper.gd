class_name VoidKeeper extends VoidTutorial

#@export var dash_speed: float = 200.0
#@export var dash_cooldown: float = 5.0
@export var projectile_lifetime: float = 5.0
@export var projectile_spawn_time_range := Vector2.ONE * 0.3 

var projectile_timer: RandOneShotTimer #this is self (from C++?)

func _ready() -> void:
	projectile_timer = RandOneShotTimer.new(projectile_spawn_time_range, self)
	projectile_timer.timeout.connect(_spawn_projectile)
	
	super()
	


func _wander_enter() -> void:
	super()
	projectile_timer.rand_start()

func _wander_leave() -> void:
	projectile_timer.stop()

func _spawn_projectile() -> void:
	Util.spawn_at_pos(self, C.Projectiles.VoidKeeperProjectile)
	

#Cut for scope creep, can add later
#func _on_dash_timer_timeout() or _dash_normal -> void:
	#speed = dash_speed
	#await get_tree().create_timer(0.3).timeout
	#speed = base_speed or speed / 2
