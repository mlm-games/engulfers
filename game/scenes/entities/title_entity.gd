class_name TitleEntity extends BaseVoidEntity

#TODO: 5 levels, defeat each entity x times or reach a particular size to be able able to travel through the void. Use level manager from my previous game. 

func _init() -> void:
	super()
	fsm.add_states(_shoot_normal, _shoot_enter)
	fsm.set_initial_state(_idle_normal)
	
	A.tree.create_timer(1).timeout.connect(fsm.change_state.bind(_shoot_normal))

func _shoot_normal():
	pass

func _shoot_enter():
	Util.spawn_projectile(self, C.Projectiles.PlayerVoidProjectile, self.global_position, self.global_rotation)

func _void_transfer_enter() -> void:
	super()
	
	mv_tween.finished.connect(fsm.change_state.bind(_idle_normal), CONNECT_ONE_SHOT)
