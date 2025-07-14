class_name Player extends BaseEntity 

#TODO: MAke 

var owned_body : BaseEntity = null

var stamina : float = 100
@onready var player_input_controller: PlayerInputController = $PlayerInputController
@onready var velocity_component: VelocityComponent = $VelocityComponent

func _ready() -> void:
	player_input_controller.direction_changed.connect(velocity_component.accelerate_to)
	
	fsm.add_states(possess)

func consume():
	animate_free()

func _withdraw_entity_and_transition() -> void:
	var nearest := _find_on_screen_smaller_enemy()
	if nearest and size >= nearest.size:
		possess(nearest)
	else:
		print("Game over");
		get_tree().quit()

func possess(new_host: BaseEntity, on_death := false) -> void:
	global_position = new_host.global_position
	new_host.fsm.change_state(new_host.player_controlled)
	if on_death: 
		size -= new_host.size / 2
	else:
		size += new_host.size / size
	

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
