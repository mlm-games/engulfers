extends Control

func _ready() -> void:
	%PlayButton.grab_focus()
	%PlayButton.pressed.connect(LevelManager.I.start_game)
	
	%CreditsButton.pressed.connect(STransitions.change_scene_with_transition.bind("uid://bq0gelfcjnqvg"))
	%QuitButton.pressed.connect(get_tree().quit)
	
	await STransitions.transition_player.animation_finished
	
	#Juice.pop_in(%TextureRect, 2.0)
	%SpawnTimer.timeout.connect(_spawn_title_entity)

func _spawn_title_entity():
	EnemyManager.I._spawn_enemy(C.Enemies.TitleEntity, %SpawnMarker2D.global_position)
