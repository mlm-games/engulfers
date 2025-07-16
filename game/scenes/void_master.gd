class_name VoidMaster extends BaseVoidEntity

@export var phase_health_thresholds = [0.75, 0.5, 0.25]
@export var transform_cooldown: float = 5.0

var consumed_forms: Array[String] = []
var current_form: String = "void_master"
var current_phase: int = 0
var can_transform: bool = true

signal boss_defeated()

func _ready() -> void:
	super()
	size = 300
	fsm.add_states(_boss_idle_normal)
	fsm.add_states(_transform_normal, _transform_enter)
	fsm.add_states(_attack_pattern_normal)
	
	fsm.set_initial_state(_boss_idle_normal)

func _boss_idle_normal() -> void:
	# Choose action based on phase
	if can_transform and consumed_forms.size() > 0:
		if randf() < 0.3:  # 30% chance to transform
			fsm.change_state(_transform_normal)
			return
	
	# Otherwise attack
	fsm.change_state(_attack_pattern_normal)

func _attack_pattern_normal():
	fsm.change_state(_boss_idle_normal)

func _transform_normal() -> void:
	pass

func _transform_enter() -> void:
	can_transform = false
	
	# Choose random consumed form
	var new_form = consumed_forms[randi() % consumed_forms.size()]
	
	# Visual transformation effect
	ScreenEffects.void_transform(visual_component)
	
	# Copy abilities from that enemy type
	await get_tree().create_timer(1.0).timeout
	_copy_enemy_abilities(new_form)
	
	# Cooldown
	await get_tree().create_timer(transform_cooldown).timeout
	can_transform = true
	
	fsm.change_state(_boss_idle_normal)

func _copy_enemy_abilities(enemy_type: String) -> void:
	current_form = enemy_type
	
	match enemy_type:
		"void_hunter":
			speed *= 1.5
		"void_liner":
			# Enable projectile shooting
			_enable_projectiles()
		"void_police":
			# Enable stunning ability
			_enable_stun_wave()

func consume_enemy(enemy: BaseEntity) -> void:
	var enemy_type = enemy.get_class()
	if not enemy_type in consumed_forms:
		consumed_forms.append(enemy_type)
	
	# Grow stronger
	size += enemy.size * 0.1

func take_damage(amount: float) -> void:
	health -= amount
	
	# Check phase transitions
	var health_percent = health / max_health
	for i in range(phase_health_thresholds.size()):
		if health_percent <= phase_health_thresholds[i] and current_phase == i:
			current_phase += 1
			_enter_new_phase()
			break
	
	if health <= 0:
		boss_defeated.emit()
		animate_free()

func _enter_new_phase() -> void:
	match current_phase:
		1:
			transform_cooldown *= 0.8
			speed *= 1.2
		2:
			transform_cooldown *= 0.6
			speed *= 1.3
		3:
			# constant transformations
			transform_cooldown = 2.0
			speed *= 1.5
