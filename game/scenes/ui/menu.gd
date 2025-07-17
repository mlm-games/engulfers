extends Control

func _ready() -> void:
	%PlayButton.pressed.connect(STransitions.change_scene_with_transition.bind(C.SCENE_PATHS.TUTORIAL_LEVEL))
