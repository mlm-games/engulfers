class_name Util

static var game_root = Engine.get_main_loop().root

static func get_enum_key_as_string(key: Variant) -> StringName:
	return C.Groups.keys()[key].capitalize()

static func get_group_string(key: C.Groups) -> StringName:
	return get_enum_key_as_string(key)
	
#region Constants and static parts

static func spawn_projectile(emitter: BaseVoidEntity, scene := C.Projectiles.PlayerVoidProjectile, global_pos: Vector2 = emitter.global_position, global_rot: float = emitter.global_rotation) -> VoidProjectile:
	var inst : VoidProjectile = load(scene).instantiate()
	inst.global_position = global_pos
	inst.global_rotation = global_rot
	inst.emitter = emitter
	inst.body_entered.connect(emitter.on_void_body_hit)
	Engine.get_main_loop().root.add_child(inst)
	return inst

#endregion
