class_name VoidProjectile extends Area2D

var travelled_dist := 0.0
var direction := Vector2.UP

@export var projectile_speed_dropoff_curve : Curve

@export var max_range := 1000
@export var speed := 400

func _ready() -> void:
		
	#set_collision_mask_value(collision_shape_mask, true)
	
	$LifespanTimer.timeout.connect(animate_free)
	rotate_inf()


func _physics_process(delta: float) -> void:
	var speed_dropoff_mult = projectile_speed_dropoff_curve.sample(travelled_dist/max_range)
	direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta * speed_dropoff_mult
	$PointLight2D.energy = speed_dropoff_mult
	travelled_dist += speed * delta
	if travelled_dist > max_range:
		animate_free()

func animate_free(anim_time:= 0.6) -> void:
	var consume_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	consume_tween.tween_property(self, "modulate", Color.TRANSPARENT, anim_time)
	consume_tween.tween_callback(queue_free)

func rotate_inf(loop_time:= 0.8):
	var rotate_tween = create_tween().set_loops()
	rotate_tween.tween_property($VisualCommponent, "global_rotation_degrees", global_rotation_degrees+720, loop_time/2)
	





















#region Constants and static parts

const Scene = preload("uid://bbt3a13kvykbv")

static func spawn_at_pos(global_pos: Vector2, emitter: BaseVoidEntity) -> VoidProjectile:
	var inst : VoidProjectile = Scene.instantiate()
	inst.global_position = global_pos
	inst.body_entered.connect(emitter.on_void_body_hit)
	Engine.get_main_loop().root.add_child(inst)
	return inst

#endregion
