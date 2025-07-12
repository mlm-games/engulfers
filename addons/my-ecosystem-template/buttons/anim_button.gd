@tool
class_name AnimButton extends Button

#NOTE: the hover and click audio is configured from UiAudioM

var tween: Tween

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	pressed.connect(_on_pressed)
	
	#set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	#size_flags_vertical = Control.SIZE_SHRINK_CENTER
	
	pivot_offset = size/2
	resized.connect(func(): pivot_offset = size/2)
	
	# get_tree().get_root().add_child.call_deferred(click_stream_player)
	

func _on_mouse_entered() -> void:
	reset_tween()
	tween.tween_property(self, "scale", Vector2(1.075, 1.075), 0.15)
	if !Engine.is_editor_hint():
		UiAudioM.play_hover_sound()

func _on_mouse_exited() -> void:
	reset_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.15)

func _on_button_down() -> void:
	reset_tween()
	tween.tween_property(self, "scale", Vector2(0.95, 0.95), 0.1)

func _on_button_up() -> void:
	reset_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)


func _on_pressed() -> void:
	if !Engine.is_editor_hint():
		UiAudioM.play_click_sound()

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CUBIC)
