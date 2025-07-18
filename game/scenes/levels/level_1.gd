class_name NonTutorialLevel extends BaseLevel


func _ready() -> void:
	
	super()
	
	Player.I.fsm.state_changed.connect(func(s): 
		if s == Player.I._void_transfer_normal:
			await get_tree().create_timer(2).timeout
			if %EntityNode.get_children().is_empty():
				complete_level()
	)

func complete_level():
	var cam_t := GameFeel.animate_to_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 2.5)
	await cam_t.finished
	super()
	

	#var editor_icons = Engine.get_singleton(&"EditorInterface").get_editor_theme.get_icon_list(get_icon_)
