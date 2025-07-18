class_name RandOneShotTimer extends Timer

var wait_time_range : Vector2:
	set(val):
		wait_time_range = val.max(Vector2.ZERO)

func _init(time_range: Vector2 = Vector2.ONE, parent : Node = A) -> void:
	wait_time_range = time_range
	one_shot = true
	
	parent.add_child(self)

func rand_start() -> void:
	super.start(randf_range(wait_time_range.x, wait_time_range.y))
