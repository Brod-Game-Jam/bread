extends FiniteStateMachine
class_name Hand_FSM

func _ready():
	super() # Run function from FiniteStateMachine
	
	# Set cursor to invisble when in game (move to FSM possibly)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _change_state(new_state: State):
	super(new_state)
	
	# TODO: Set cursor to visible when biting
	if current_state.get_name() == "Grabbed":
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if current_state.get_name() == "Active":
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	super(delta)
	
func _physics_process(delta):
	super(delta)
