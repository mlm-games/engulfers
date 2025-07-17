class_name Intro extends Control

var intro_tween : Tween

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	intro_tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	intro_tween.tween_interval(0.5)
	intro_tween.tween_property(%Logo, "modulate", Color.WHITE, 0.75)
	intro_tween.tween_interval(1.25)
	intro_tween.tween_property(%Logo, "modulate", Color.TRANSPARENT, 0.75)
	
	intro_tween.tween_callback(transition_to_menu_scene)

func _process(_delta: float) -> void:
	if Input.is_anything_pressed():
		if intro_tween.is_running():
			intro_tween.set_speed_scale(5)

static func transition_to_menu_scene():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#DisplayServer.cursor_set_shape(DisplayServer.CURSOR_CROSS) #NOTE: Changes when scene changes?
	STransitions.change_scene_with_transition(C.SCENE_PATHS.MENU)
