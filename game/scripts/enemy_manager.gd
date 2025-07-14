class_name EnemyManager extends Node

func _ready() -> void:
	_spawn_enemy("res://game/scenes/void_keeper.tscn", Vector2(100, 100))
	_spawn_enemy("res://game/scenes/void_liner.tscn", Vector2(150, 100))

func _spawn_enemy(scene_path: String, pos: Vector2) -> void:
	var enemy = load(scene_path).instantiate()
	enemy.global_position = pos
	add_child(enemy)
