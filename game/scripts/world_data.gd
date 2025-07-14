class_name WorldData extends Node

var player : Player:
	get: return get_tree().get_first_node_in_group("player")

func get_player_pos():
	return player.global_position
