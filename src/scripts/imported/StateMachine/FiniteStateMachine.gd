extends Node
class_name FiniteStateMachine

@export var current_state: State
@export var states : Array[State]
@export var root: Node2D

func _ready():
	states.resize(get_child_count())
	var actual_size = 0
	for child in get_children():
		if not child is State:
			continue
		states[actual_size] = child
		actual_size += 1
		child._initialize_state(self, root)
	states.resize(actual_size)
	if not current_state:
		current_state = get_child(0)
		if not get_child(0):
			push_error("No children detected")
	_change_state(current_state)

func _change_state(new_state: State):
	if new_state == current_state:
		push_warning("Attempting to set state to current state.")
	if current_state is State:
		current_state._exit_state()
	new_state._enter_state()
	print(name + ": " + "Entering new state "+ new_state.name)
	current_state = new_state
	
func _process(delta):
	current_state._state_update(delta)
	
func _physics_process(delta):
	current_state._state_physics_update(delta)

