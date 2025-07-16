@icon("GPUParticles3D")
class_name ParticleComponentData extends Resource

@export var process_material : ParticleProcessMaterial

# Basic emission settings
@export_group("Emission")
@export var emission_amount: int = 8
@export var emission_lifetime: float = 2.0

@export var texture: Texture2D
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
	
	particles.process_material = process_material
