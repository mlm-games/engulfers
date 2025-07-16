class_name VelocityComponent extends Node

# Leave the comments to the other repo

var velocity: Vector2

var _knockback_vector := Vector2.ZERO
var _knockback_timer := 0.0
var _is_knocked_back := false


func _physics_process(delta: float) -> void:
	var body: CharacterBody2D = get_parent()

	if _is_knocked_back:
		_knockback_timer -= delta
		if _knockback_timer <= 0.0:
			_is_knocked_back = false
			velocity = Vector2.ZERO
		else:
			body.velocity = _knockback_vector
			body.move_and_slide()
			self.velocity = body.velocity
			return

	body.velocity = velocity
	body.move_and_slide()
	self.velocity = body.velocity


func accelerate_to(direction: Vector2, speed: float = 100) -> void:
	var adjusted_speed = minf(speed, speed / (get_parent().size/100))
	velocity = frame_independent_lerp(velocity, direction.normalized() * adjusted_speed)

func stop() -> void:
	velocity = frame_independent_lerp(velocity, Vector2.ZERO)

func apply_knockback(force: Vector2, duration: float = 0.2) -> void:
	if force != Vector2.ZERO:
		_knockback_vector = force
		_knockback_timer = duration
		_is_knocked_back = true

func frame_independent_lerp(from_velocity: Vector2, to: Vector2, damp: float = 50) -> Vector2:
	return from_velocity.lerp(to, 1 - exp(-damp * get_physics_process_delta_time()))
