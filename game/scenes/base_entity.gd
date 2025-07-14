class_name BaseEntity extends CharacterBody2D

var size := 100

var fsm: CallableStateMachine = CallableStateMachine.new()
@onready var velocity_comp: VelocityComponent = $VelocityComponent

var consume_tween : Tween

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier2D

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_entered.connect(add_to_group.bind("OnScreenEntities"))
	visible_on_screen_notifier_2d.screen_exited.connect(remove_from_group.bind("OnScreenEntities"))
	


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
