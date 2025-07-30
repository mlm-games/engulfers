class_name Player extends BaseVoidEntity  

static var I : Player #Global singelton (kinda)

func _init() -> void:
	I = self
	super()
	
	fsm.add_states(possess)
	fsm.add_states(player_controlled)

#var owned_body : BaseVoidEntity = null
var stamina : float = 100

@onready var player_input_controller: PlayerInputController = $PlayerInputController
@onready var velocity_component: VelocityComponent = $VelocityComponent

func _ready() -> void:
	super()
	player_input_controller.direction_changed.connect(func(dir):
		velocity_component.accelerate_to(dir)
		look_at(global_position+dir)
		)
	player_input_controller.trigger_shoot.connect(shoot)
	

func void_consume():
	animate_free()

func shoot():
	Util.spawn_projectile(self, C.Projectiles.PlayerVoidProjectile)


func _withdraw_entity_and_transition() -> void:
	var nearest := _find_on_screen_smaller_enemy()
	if nearest and size >= nearest.size:
		possess(nearest)
	else:
		print("Game over");
		get_tree().quit()


func _find_on_screen_smaller_enemy() -> BaseEntity:
	var enemies = get_tree().get_nodes_in_group("OnScreenEntities")
	var closest: BaseEntity = null
	var min_dist: float = INF
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = enemy
	return closest


#region State functions

func player_controlled():
	player_input_controller.enabled = true
	if collision_shape_2d.disabled: disable_collision(false)

func possess(new_host: BaseEntity, on_death := false) -> void:
	global_position = new_host.global_position
	new_host.fsm.change_state(new_host.player_controlled)
	if on_death: 
		size -= new_host.size / 2
	else:
		size += new_host.size / size

func _void_transfer_normal() -> void:
	player_input_controller.enabled = false
	if !mv_tween.is_running(): #NOTE: Not using fsm.update will not cause this to be ran at all...
		fsm.change_state(player_controlled)

#endregion
