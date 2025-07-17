extends Node2D

var text1_shown := false

func _ready() -> void:
	
	GameFeel.animate_from_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 2.5)
	
	Player.I.player_input_controller.direction_changed.connect(func(d): 
		if d != Vector2.ZERO and !text1_shown : 
			$TutorialLabel.set_text("Nice now capture the body using space");
			UIEffects.typewriter_effect($TutorialLabel)
			text1_shown = true)
	
	Player.I.fsm.state_changed.connect(func(s): 
		if s == Player.I._void_transfer_normal:
			UIEffects.typewriter_effect($TutorialLabel)
			$TutorialLabel.text = "Good, now move offscreen to end the level")
	
	Player.I.visible_on_screen_notifier_2d.screen_exited.connect(func():
		GameFeel.animate_to_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 2.5)
	 #TODO Level 1 enter
	)



	#var editor_icons = Engine.get_singleton(&"EditorInterface").get_editor_theme.get_icon_list(get_icon_)
