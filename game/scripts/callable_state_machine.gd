# By firebelley's github gist (slightly modified)
class_name CallableStateMachine

var state_dictionary : Dictionary[StringName, Dictionary] = {}
var current_state: StringName

func add_states(
	normal_state_callable: Callable,
	enter_state_callable: Callable = Callable(),
	leave_state_callable: Callable = Callable()
):
	var state_name = normal_state_callable.get_method()
	state_dictionary[state_name] = {
		"normal": normal_state_callable,
		"enter": enter_state_callable,
		"leave": leave_state_callable
	}
	

func set_initial_state(state_callable: Callable):
	var state_name = state_callable.get_method()
	if state_dictionary.has(state_name):
		_set_state(state_callable)
	else:
		push_warning("No state with name " + state_name)

func update():
	if current_state != null and state_dictionary.has(current_state):
		var normal : Callable = state_dictionary[current_state].normal
		if not normal.is_null():
			normal.call()
		else:
			push_warning("Null normal callable for state: " + current_state)

func change_state(state_callable: Callable):
	if state_dictionary.has(state_callable.get_method()):
		_set_state.call_deferred(state_callable)
	else:
		push_warning("No state with name " + state_callable.get_method())

func _set_state(state_name: Callable):
	if current_state and state_dictionary.has(current_state):
		var leave_callable : Callable = state_dictionary[current_state].leave
		if not leave_callable.is_null():
			leave_callable.call()
	
	current_state = state_name.get_method()
	var enter_callable = state_dictionary[current_state].enter
	if not enter_callable.is_null():
		enter_callable.call()
