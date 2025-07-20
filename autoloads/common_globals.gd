extends Node

var cam_event_running:= false

func _input(event):
	if OS.get_name() in ["Windows", "macOS", "Linux"] and not OS.has_feature("web"):
		if event is InputEventKey:
			if event.keycode == KEY_F11 and event.pressed:
				if DisplayServer.window_get_mode() in [DisplayServer.WINDOW_MODE_WINDOWED, DisplayServer.WINDOW_MODE_MAXIMIZED]:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
				elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
			if event.is_action_pressed("restart") and event.pressed and !cam_event_running and is_instance_valid(BaseLevel.I):
				cam_event_running = true
				var cam_t := GameFeel.animate_to_offscreen(BaseLevel.I.camera_2d, Vector2(0, DisplayServer.screen_get_size().y * -3.25), 1.5)
				cam_t.tween_callback(func(): 
					A.tree.reload_current_scene()
					cam_event_running = false
					)
				
			if OS.is_debug_build():
				if event.keycode == KEY_EQUAL and event.pressed: #KEY_PLUS doesnt work for some reason
					Engine.time_scale += 1
				if event.keycode == KEY_MINUS and event.pressed:
					Engine.time_scale -= 1
