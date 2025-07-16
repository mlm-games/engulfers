class_name UI extends CanvasLayer

static var I : UI

func _init() -> void:
	I = self

@onready var tutorial_label: RichTextLabel = $"../TutorialLabel"


func _show_tutorial_text():
	#tutorial_label.text = 
	UIEffects.typewriter_effect(tutorial_label)

func _highlight_step(pos: Vector2):
	print("Highlight pos: ", pos)
