extends FiniteStateMachine

# Load the custom images for the mouse cursor.
var bread = load("res://visual/legacy/bread_32.png")
var bite = load("res://visual/legacy/bite_bread_32.png")

func _ready():
	super() # Run function from FiniteStateMachine

func _change_state(new_state: State):
	super(new_state)
	
	# TODO: Set cursor to visible when biting and visible when active
	if new_state.get_name() == "Grabbed":
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.set_custom_mouse_cursor(bite)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_custom_mouse_cursor(bread)
	
func _process(delta):
	super(delta)
	
func _physics_process(delta):
	super(delta)

