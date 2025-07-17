class_name TutorialManager extends Node

signal tutorial_completed()

var tutorial_steps = [
	{
		"text": "You are a void symbiote. Move with WASD or Arrow keys.",
		"condition": "player_moved",
		"highlight": Player.I
	},
	{
		"text": "Your void particles automatically consume smaller entities.",
		"condition": "enemy_consumed",
		"highlight": EnemyManager.I.tutorial_enemy
	},
	{
		"text": "You grow larger with each consumption. Size is power!",
		"condition": "size_increased",
		"show_size_indicator": true
	},
	{
		"text": "Warning: If all enemies are larger than you, quickly find a new host!",
		"condition": "understand_danger",
		"spawn_large_enemy": true
	},
	{
		"text": "Excellent! You're ready to face the void.",
		"condition": "tutorial_complete"
	}
]

var current_step: int = 0
var step_completed: bool = false

func start_tutorial() -> void:
	_show_current_step()

func _show_current_step() -> void:
	var step = tutorial_steps[current_step]
	
	UI.I.show_tutorial_text(step.text)
	
	if step.has("highlight"):
		UI.I._highlight_element(step.highlight)
	
	if step.has("spawn_large_enemy"):
		EnemyManager.I._spawn_tutorial_enemy()
	
	_wait_for_condition(step.condition)

func _wait_for_condition(condition: String) -> void:
	match condition:
		"player_moved":
			await Player.I.moved
		"enemy_consumed":
			await Player.I.consumed_enemy
		"size_increased":
			await Player.I.size_changed
		"understand_danger":
			await get_tree().create_timer(3.0).timeout
		"tutorial_complete":
			tutorial_completed.emit()
			return
	
	_next_step()

func _next_step() -> void:
	current_step += 1
	if current_step < tutorial_steps.size():
		_show_current_step()
	else:
		tutorial_completed.emit()
