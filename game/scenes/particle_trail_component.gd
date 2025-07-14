class_name VoidParticleTrailComponent extends CPUParticles2D

@onready var scan_timer: Timer = %ScanTimer
signal void_consume(entity: BaseEntity)

func _ready() -> void:
	scan_timer.wait_time = lifetime / amount
	scan_timer.timeout.connect(_scan_and_consume_bodies)


func _scan_and_consume_bodies():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = CircleShape2D.new()
	query.shape.radius = texture.get_size().x / 1.5 #Offset
	#query.collide_with_areas = true
	query.transform = Transform2D(0, global_position)
	query.collision_mask = LayerNames.PHYSICS_2D.ENTITIES_NUM
	
	var hit_bodies := space_state.intersect_shape(query)
	
	print("Hit bodies: ",  hit_bodies)
	for hit in hit_bodies.filter(func(h): return h.collider is BaseEntity):
		print("Hit Entities: ", hit)
		void_consume.emit(hit.collider)
		
