extends VoidKeeper

var mimic_buffer: Array[Vector2] = []
var mimicking: bool = false

func _physics_process(_delta: float) -> void:
	if mimicking:
		if mimic_buffer.size() > 0:
			target = mimic_buffer.pop_front()
		else:
			mimicking = false
	else:
		mimic_buffer.append(get_tree().get_first_node_in_group("player").global_position)
		if mimic_buffer.size() > 20: 
			mimicking = true
