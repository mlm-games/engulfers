extends VoidKeeper

@onready var path_follow: PathFollow2D = $PathFollow2D

func _physics_process(delta: float) -> void:
	path_follow.progress += speed * delta
	global_position = path_follow.global_position
