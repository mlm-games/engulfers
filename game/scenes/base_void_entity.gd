class_name BaseVoidEntity extends BaseEntity

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _ready() -> void:
	fsm.add_states(_void_transfer_normal, collision_shape_2d.set_disabled.bind(true))
	

func _void_transfer_normal():
	transform

func _idle_normal() -> void:
	velocity_comp.stop()

func _idle_enter() -> void:
	pass

func _idle_leave() -> void:
	pass

func animate_free(anim_time:= 0.2):
	if consume_tween:
		consume_tween.kill()
		
	consume_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	consume_tween.tween_property(self, "scale", Vector2.ZERO, anim_time)
	consume_tween.parallel().tween_property(self, "rotation", 0, anim_time)
	consume_tween.tween_callback(queue_free)
