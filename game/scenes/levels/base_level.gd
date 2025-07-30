class_name BaseLevel extends Node2D

static var I : BaseLevel #Current instance on screen
var cam_t : Tween

func _init() -> void:
	I = self

@onready var retry_label: RichTextLabel = %RetryLabel if %RetryLabel else null # Only for tutorial level
@onready var level_id = name.to_upper() 
@onready var camera_2d: Camera2D = %Camera2D

func _ready() -> void:
	cam_t = GameFeel.animate_from_offscreen(%Camera2D, Vector2(0, DisplayServer.screen_get_size().y * 3.25), 1.5)


func complete_level():
	print("Level completed: " + str(level_id))
	
	LevelManager.I.advance_to_next_level()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and event.is_pressed():
		if !cam_t.is_running():
			cam_t = GameFeel.animate_to_offscreen(%Camera2D, Vector2(0, -DisplayServer.screen_get_size().y * 3.25), 2.5)
			await cam_t.finished
			get_tree().reload_current_scene()
