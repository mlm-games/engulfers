class_name VoidParticleComponent extends GPUParticles2D
#
#@export var particle_data: ParticleComponentData
#
#
#@onready var emitter: BaseEntity = get_parent()
#@onready var collision_area: Area2D
#signal void_consume(entity_position: Vector2)
#
#func _ready() -> void:
	#particle_data.apply_to_particles(self)
	#_setup_collision_area()
	#emitting = true
#
#func _setup_collision_area() -> void:
	#collision_area = Area2D.new()
	#add_child(collision_area)
	#
	## Create shape based on particle data
	#var shape = RectangleShape2D.new()
	#shape.size = particle_data.detection_area_size
	#
	#var collision_shape = CollisionShape2D.new()
	#collision_shape.shape = shape
	#collision_shape.position = particle_data.detection_area_offset
	#collision_area.add_child(collision_shape)
	#
	#collision_area.collision_layer = 0
	#collision_area.collision_mask = LayerNames.PHYSICS_2D.ENTITIES_NUM
	#
	#collision_area.body_entered.connect(_on_body_entered)
#
#func _on_body_entered(body: BaseVoidEntity) -> void:
	#if body is BaseEntity and body != emitter:
		#void_consume.emit(body.global_position)
		#if particle_data.consume_on_hit:
			#body.animate_free()
#
#func set_particle_data(data: ParticleComponentData) -> void:
	#particle_data = data
	#if is_inside_tree() and data:
		#data.apply_to_particles(self)
