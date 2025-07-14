class_name ParticleComponentData extends Resource

@export var process_material : ParticleProcessMaterial

# Basic emission settings
@export_group("Emission")
@export var emission_amount: int = 8
@export var emission_lifetime: float = 2.0
@export var emission_shape: ParticleProcessMaterial.EmissionShape = ParticleProcessMaterial.EMISSION_SHAPE_POINT
@export var emission_sphere_radius: float = 10.0
@export var emission_rect_extents: Vector2 = Vector2(10, 10)

# Movement settings
@export_group("Movement")
@export var direction: Vector2 = Vector2(0, -1)
@export var spread: float = 0.0
@export var initial_velocity_min: float = 300.0
@export var initial_velocity_max: float = 300.0
@export var angular_velocity_min: float = -180.0
@export var angular_velocity_max: float = 180.0
@export var gravity: Vector2 = Vector2.ZERO
@export var linear_accel_min: float = 0.0
@export var linear_accel_max: float = 0.0
@export var radial_accel_min: float = 0.0
@export var radial_accel_max: float = 0.0
@export var tangential_accel_min: float = 0.0
@export var tangential_accel_max: float = 0.0
@export var damping_min: float = 0.0
@export var damping_max: float = 0.0

# Visual settings
@export_group("Visual")
@export var texture: Texture2D
@export var scale_min: float = 1.0
@export var scale_max: float = 1.0
@export var scale_curve: Curve
@export var color_ramp: Gradient
@export var color_initial_ramp: Gradient
@export var hue_variation_min: float = 0.0
@export var hue_variation_max: float = 0.0

# Collision settings
@export_group("Collision")
@export var collision_enabled: bool = true
@export var collision_mode: ParticleProcessMaterial.CollisionMode = ParticleProcessMaterial.COLLISION_RIGID
@export var collision_friction: float = 0.0
@export var collision_bounce: float = 0.0
@export var collision_use_scale: bool = true

# Detection settings (for our custom detection)
@export_group("Detection")
@export var detection_radius: float = 8.0
@export var detection_interval: float = 0.1
@export var consume_on_hit: bool = true
@export var detection_area_size: Vector2 = Vector2(100, 400)
@export var detection_area_offset: Vector2 = Vector2(0, -200)

func apply_to_particles(particles: GPUParticles2D) -> void:
	particles.amount = emission_amount
	particles.lifetime = emission_lifetime
	particles.texture = texture
	
	var process_mat = particles.process_material as ParticleProcessMaterial
	if not process_mat:
		process_mat = ParticleProcessMaterial.new()
		particles.process_material = process_mat
	
	# Apply emission settings
	process_mat.emission_shape = emission_shape
	process_mat.emission_sphere_radius = emission_sphere_radius
	process_mat.emission_box_extents = Vector3(emission_rect_extents.x, emission_rect_extents.y, 0)
	
	# Apply movement settings
	process_mat.direction = Vector3(direction.x, direction.y, 0)
	process_mat.spread = spread
	process_mat.initial_velocity_min = initial_velocity_min
	process_mat.initial_velocity_max = initial_velocity_max
	process_mat.angular_velocity_min = angular_velocity_min
	process_mat.angular_velocity_max = angular_velocity_max
	process_mat.gravity = Vector3(gravity.x, gravity.y, 0)
	process_mat.linear_accel_min = linear_accel_min
	process_mat.linear_accel_max = linear_accel_max
	process_mat.radial_accel_min = radial_accel_min
	process_mat.radial_accel_max = radial_accel_max
	process_mat.tangential_accel_min = tangential_accel_min
	process_mat.tangential_accel_max = tangential_accel_max
	process_mat.damping_min = damping_min
	process_mat.damping_max = damping_max
	
	# Apply visual settings
	process_mat.scale_min = scale_min
	process_mat.scale_max = scale_max
	if scale_curve:
		process_mat.scale_curve = scale_curve
	if color_ramp:
		process_mat.color_ramp = color_ramp
	if color_initial_ramp:
		process_mat.color_initial_ramp = color_initial_ramp
	process_mat.hue_variation_min = hue_variation_min
	process_mat.hue_variation_max = hue_variation_max
	
	# Apply collision settings
	if collision_enabled:
		process_mat.collision_mode = collision_mode
		process_mat.collision_friction = collision_friction
		process_mat.collision_bounce = collision_bounce
		process_mat.collision_use_scale = collision_use_scale
