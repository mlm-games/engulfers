class_name VoidProjectile extends Area2D

var travelled_dist := 0.0
var direction := Vector2.UP
var emitter : BaseEntity
var queued_free:= false

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
	%SubtractLight.energy = speed_dropoff_mult
	travelled_dist += speed * delta
	if travelled_dist > max_range:
		if not queued_free: animate_free()

func animate_free(anim_time:= 0.6) -> void:
	queued_free = true
	var consume_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	consume_tween.tween_property(%VisualCommponent, "modulate", Color.TRANSPARENT, anim_time)
	consume_tween.tween_property(%SubtractLight, "energy", 0, anim_time)
	consume_tween.tween_callback(queue_free)

func rotate_inf(loop_time:= 0.8):
	var rotate_tween = create_tween().set_loops()
	rotate_tween.tween_property(%VisualCommponent, "global_rotation_degrees", global_rotation_degrees+720, loop_time/2)
	
