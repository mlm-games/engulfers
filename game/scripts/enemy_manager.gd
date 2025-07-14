class_name EnemyManager extends Node

@export var keeper_particle_data: ParticleComponentData
@export var liner_particle_data: ParticleComponentData
@export var hunter_particle_data: ParticleComponentData

func _ready() -> void:
	var tween = create_tween()
	tween.tween_callback(_spawn_enemy.bind("res://game/scenes/void_keeper.tscn", Vector2(100, 100))).set_delay(1)
	tween.tween_callback(_spawn_enemy.bind("res://game/scenes/void_liner.tscn", Vector2(150, 100))).set_delay(1)
	tween.tween_callback(_spawn_enemy.bind("res://game/scenes/void_keeper.tscn", Vector2(300, 100))).set_delay(1)
	tween.tween_callback(_spawn_enemy.bind("res://game/scenes/void_liner.tscn", Vector2(450, 100))).set_delay(1)

func _spawn_enemy(scene_path: String, pos: Vector2) -> void:
	var spawn_tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	var enemy = load(scene_path).instantiate()
	spawn_tween.tween_property(enemy, "scale", Vector2.ONE, 0.2).from(Vector2.ZERO)
	enemy.global_position = pos
	spawn_tween.tween_callback(add_child.bind(enemy))
