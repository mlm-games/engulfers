class_name VoidLiner extends BaseEntity

@export var throw_force: float = 500.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("perform_trigger_action"):
		_throw_void()


func _throw_void() -> void:
	var projectile = RigidBody2D.new()  # Simple void projectile
	var sprite = Polygon2D.new()  # Vector shape (e.g., circle from Inkscape)
	sprite.polygon = [Vector2(-5,-5), Vector2(5,-5), Vector2(5,5), Vector2(-5,5)]  # Simple quad
	sprite.color = Color(0,0,0)
	projectile.add_child(sprite)
	var collision = CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 5.0
	projectile.add_child(collision)
	projectile.global_position = global_position + Vector2(20, 0).rotated(rotation)  # Forward
	get_parent().add_child(projectile)
	projectile.apply_impulse(Vector2(throw_force, 0).rotated(rotation))  # Throw direction
	projectile.body_entered.connect(_on_void_hit)

func _on_void_hit(body: Node) -> void:
	if body is BaseEntity and body != self:
		body.apply_impulse(Vector2(throw_force / 2, 0).rotated(rotation))  # Knock toward your void

func consume():
	animate_free()
