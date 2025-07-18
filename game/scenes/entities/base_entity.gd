class_name BaseEntity extends CharacterBody2D

func _init() -> void:
	fsm.add_states(_idle_normal, _idle_enter, _idle_leave)

@export var size := 100

var fsm: CallableStateMachine = CallableStateMachine.new()
var consume_tween : Tween

@onready var velocity_comp: VelocityComponent = $VelocityComponent
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var visual_component: CanvasGroup = %VisualComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier2D
@onready var base_size := size

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_entered.connect(add_to_group.bind("OnScreenEntities"))
	visible_on_screen_notifier_2d.screen_exited.connect(remove_from_group.bind("OnScreenEntities"))
	
	visual_component.material = visual_component.material.duplicate()

func _physics_process(_delta: float) -> void:
	fsm.update()

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

func disable_collision(disable := true):
	collision_shape_2d.set_deferred("disabled", disable)
