class_name EnemyManager extends Node

static var I : EnemyManager

func _init() -> void:
	I = self

var tutorial_enemy : BaseVoidEntity

@export var keeper_particle_data: ParticleComponentData
@export var liner_particle_data: ParticleComponentData
@export var hunter_particle_data: ParticleComponentData

func _ready() -> void:
	var tween = create_tween()
	tween.tween_callback(_spawn_enemy.bind(C.Enemies.VoidKeeper, Vector2(100, 100))).set_delay(1)
	tween.tween_callback(_spawn_enemy.bind(C.Enemies.VoidKeeper, Vector2(150, 100))).set_delay(1)
	tween.tween_callback(_spawn_enemy.bind(C.Enemies.VoidKeeper, Vector2(300, 100))).set_delay(1)
	tween.tween_callback(_spawn_enemy.bind(C.Enemies.VoidKeeper, Vector2(450, 100))).set_delay(1)

func _spawn_enemy(enemy_scene_const: PackedScene, pos: Vector2) -> Array:
	var spawn_tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	var enemy : BaseVoidEntity = enemy_scene_const.instantiate()
	spawn_tween.tween_property(enemy, "scale", Vector2.ONE, 0.2).from(Vector2.ZERO)
	enemy.global_position = pos
	spawn_tween.tween_callback(add_child.bind(enemy))
	add_to_group(Util.get_enum_key_as_string(C.Groups.ENTITIES))
	return [spawn_tween, enemy]


func _spawn_tutorial_enemy(pos: Vector2 = Vector2(250, 250)) -> void:
	var _t = _spawn_enemy(C.Enemies.VoidKeeper, pos)
