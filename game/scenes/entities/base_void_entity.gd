class_name BaseVoidEntity extends BaseEntity

#TODO: 5 levels, defeat each entity x times or reach a particular size to be able able to travel through the void. Use level manager from my previous game. 

func _init() -> void:
	super()
	fsm.add_states(_void_transfer_normal, _void_transfer_enter, _void_transfer_exit)
	fsm.state_changed.connect(printt)

@onready var animation_player: AnimationPlayer = %AnimationPlayer

var target_pos : Vector2
var mv_tween : Tween

func _void_transfer_normal() -> void:
	pass #Override

func _void_transfer_enter() -> void:
	ScreenEffects.flash_white(visual_component, 1)
	animate_to_pos()
	disable_collision()

func _void_transfer_exit() -> void:
	if mv_tween.is_running():
		await mv_tween.finished
	disable_collision(false)

func animate_free(anim_time:= 0.2):
	%VoidConsume3D.emit_oneshot_particles()
	var burst : BurstParticles2D = C.burst_particles.instantiate()
	burst.global_position = global_position
	burst.z_index = 50
	A.add_child(burst)
	disable_collision()
	
	consume_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	consume_tween.tween_property(self, "scale", Vector2.ZERO, anim_time)
	consume_tween.parallel().tween_property(self, "rotation", 0, anim_time)
	consume_tween.tween_callback(queue_free)

func animate_to_pos() -> void:
	%VoidTransfer3D.emit_oneshot_particles()
	mv_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	mv_tween.tween_property(visual_component, "scale", Vector2.ONE * 0.27, 0.2)
	mv_tween.tween_property(self, "global_position", target_pos, 0.3)
	mv_tween.tween_property(visual_component, "scale", Vector2.ONE, 0.2)

func on_void_body_hit(body: BaseVoidEntity) -> void:
	##If your collision mask is right, then you wouldn't need the "is body" condn
	if body != self: #HACK: removed ->  body.size <= size and 
		target_pos = body.global_position
		fsm.change_state(_void_transfer_normal)
		if body is Player:
			BaseLevel.I.retry_label.show()
			UIEffects.typewriter_effect(BaseLevel.I.retry_label)
		body.animate_free()
		


#region Reusable Enemy States 

func base_chase_normal(chase_range, speed) -> void:
	if Player.I:
		var player_pos = Player.I.global_position
		if global_position.distance_to(player_pos) > chase_range:
			Player.I.animate_free()
		velocity_comp.accelerate_to((player_pos - global_position).normalized(), speed)





#endregion
