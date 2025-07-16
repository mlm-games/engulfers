class_name BaseVoidEntity extends BaseEntity

#TODO: 5 levels, defeat each entity x times or reach a particular size to be able able to travel through the void. Use level manager from my previous game. 

func _init() -> void:
	fsm.add_states(_void_transfer_normal, _void_transfer_enter, _void_transfer_exit)

@onready var animation_player: AnimationPlayer = %AnimationPlayer

var target_pos : Vector2
var mv_tween : Tween

@export var particle_configuration: ParticleComponentData




func _ready() -> void:
	super()
	
	

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

func _idle_normal() -> void:
	velocity_comp.stop()

func _idle_enter() -> void:
	pass

func _idle_leave() -> void:
	pass

func animate_free(anim_time:= 0.2):
	%VoidConsume3D.emit_oneshot_particles()
		
	consume_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	consume_tween.tween_property(self, "scale", Vector2.ZERO, anim_time)
	consume_tween.parallel().tween_property(self, "rotation", 0, anim_time)
	consume_tween.tween_callback(queue_free)

func animate_to_pos() -> Tween:
	%VoidTransfer3D.emit_oneshot_particles()
	mv_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	mv_tween.tween_property(visual_component, "scale", Vector2.ONE * 0.27, 0.2)
	mv_tween.tween_property(self, "global_position", target_pos, 0.3)
	mv_tween.tween_property(visual_component, "scale", Vector2.ONE, 0.2)
	return mv_tween
