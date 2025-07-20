class_name VoidMaster extends BaseVoidEntity

@export var phase_health_thresholds = [0.75, 0.5, 0.25]
@export var transform_cooldown: float = 5.0

var consumed_forms: Array[String] = []
var current_form: String = "void_master"
var current_phase: int = 0
var can_transform: bool = true
var health: float = 1000.0  # Boss health
var max_health: float = 1000.0

signal boss_defeated()

func _ready() -> void:
	super()
	size = 300
	fsm.add_states(_boss_idle_normal)
	fsm.add_states(_transform_normal, _transform_enter)
	fsm.add_states(_attack_pattern_normal)
	fsm.set_initial_state(_boss_idle_normal)

func _boss_idle_normal() -> void:
	if can_transform and consumed_forms.size() > 0 and randf() < 0.3:
		fsm.change_state(_transform_normal)
		return
	fsm.change_state(_attack_pattern_normal)

func _attack_pattern_normal() -> void:
	# Phase-based attacks (e.g., shoot, dash)
	match current_phase:
		0: _basic_attack()
		#1: _enhanced_attack()
		#2: _frenzy_attack()
	await get_tree().create_timer(1.0).timeout
	fsm.change_state(_boss_idle_normal)

func _basic_attack() -> void:
	# e.g., Shoot projectile
	pass

#TODO: ... (implement enhanced/frenzy), all of this was scrapped, can add it when im expanding

func _transform_normal() -> void:
	pass

func _transform_enter() -> void:
	can_transform = false
	var new_form = consumed_forms[randi() % consumed_forms.size()]
	# Visuals...
	await get_tree().create_timer(1.0).timeout
	#_copy_enemy_abilities(new_form)
	await get_tree().create_timer(transform_cooldown).timeout
	can_transform = true
	fsm.change_state(_boss_idle_normal)

# Existing _copy_enemy_abilities, consume_enemy, take_damage from your code

func take_damage(amount: float) -> void:
	health -= amount
	var health_percent = health / max_health
	for i in range(phase_health_thresholds.size()):
		if health_percent <= phase_health_thresholds[i] and current_phase == i:
			current_phase += 1
			#_enter_new_phase()
			break
	if health <= 0:
		boss_defeated.emit()
		animate_free()
