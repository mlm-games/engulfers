class_name VoidHunter extends VoidKeeper

@export var chase_range := 200

func _ready() -> void:
	fsm.add_states(_chase_normal, _chase_enter, _chase_leave)
	fsm.set_initial_state(_chase_normal)


func _chase_normal() -> void:
	var player_pos = WorldDataA.get_player_pos()
	if global_position.distance_to(player_pos) > chase_range:
		fsm.change_state(_wander_normal)
	velocity_comp.accelerate_to((player_pos - global_position).normalized(), speed)

func _chase_enter() -> void:
	print("Hunter chasing player!")

func _chase_leave() -> void:
	pass
