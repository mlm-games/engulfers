class_name NonTutorialLevel extends BaseLevel

var win_timer : Timer:
	get: 
		if is_instance_valid(win_timer): 
			if !win_timer.is_stopped(): return win_timer
			else: win_timer.start(0.5); return win_timer
		
		var val = Timer.new()
		val.autostart = false
		add_child(val)
		val.start(0.5)
		return val #Its almost the same as Randtimer.new but whatever

func _ready() -> void:
	
	super()
	
	Player.I.fsm.state_changed.connect(func(s): 
		if s == Player.I._void_transfer_normal:
			await win_timer.timeout
			if %EntityNode.get_children().is_empty():
				complete_level()
	)

func complete_level():
	var cam_t := GameFeel.animate_to_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 2.5)
	await cam_t.finished
	super()
	

	#var editor_icons = Engine.get_singleton(&"EditorInterface").get_editor_theme.get_icon_list(get_icon_)
