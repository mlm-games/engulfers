# By firebelley's github gist (slightly modified)
class_name CallableStateMachine

var state_dictionary : Dictionary[Callable, Dictionary] = {}
var current_state: Callable

func add_states(
	normal_state_callable: Callable,
	enter_state_callable: Callable = Callable(),
	leave_state_callable: Callable = Callable()
):
	state_dictionary[normal_state_callable] = {
		&"normal": normal_state_callable,
		&"enter": enter_state_callable,
		&"leave": leave_state_callable
	}
	

func set_initial_state(state_callable: Callable):
	if state_dictionary.has(state_callable):
		_set_state(state_callable)
	else:
		push_warning("No state with name ", state_callable)

func update():
	if current_state != null and state_dictionary.has(current_state):
		var normal : Callable = state_dictionary[current_state].normal
		if normal.is_valid():
			normal.call()
		else:
			push_warning("Nonexistent normal callable for state: ", current_state)

func change_state(state_callable: Callable):
	if state_dictionary.has(state_callable):
		_set_state.call_deferred(state_callable)
	else:
		push_warning("No state with name ", state_callable)

func _set_state(state_callable: Callable):
	if current_state and state_dictionary.has(current_state):
		var leave_callable : Callable = state_dictionary[current_state].leave
		if leave_callable.is_valid(): leave_callable.call()
	
	current_state = state_callable
	
	var enter_callable = state_dictionary[current_state].enter
	if enter_callable.is_valid(): enter_callable.call()
