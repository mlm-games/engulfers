extends Control

func _ready() -> void:
	%PlayButton.grab_focus()
	%PlayButton.pressed.connect(LevelManager.I.start_game)
	
	await STransitions.transition_player.animation_finished
	
	#Juice.pop_in(%TextureRect, 2.0)
	
	
