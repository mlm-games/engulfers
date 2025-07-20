extends Control

func _ready() -> void:
	%PlayButton.grab_focus()
	%PlayButton.pressed.connect(LevelManager.I.start_game)
	
	#%CreditsButton.pressed.connect(STransitions.change_scene_with_transition.bind("uid://bq0gelfcjnqvg"))
	
	
	%TimeLabel.text = "[wave]Time taken: " + str(A.elapsed_time) + " secs"
	
	
	#Juice.pop_in(%TextureRect, 2.0)
	


func _exit_tree() -> void:
	A.timer_reset()
