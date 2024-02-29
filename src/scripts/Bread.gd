extends RigidBody2D
var toaster
var reset_state = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Retrieve nodes
	var state_toasting = get_node("../../FiniteStateMachine/Toasting")
	var state_airborne = get_node("../../FiniteStateMachine/Airborne")
	toaster = get_node("../Toaster")
	
	# Connect signals
	state_toasting.connect("state_entered",reset_bread)
	state_airborne.connect("state_entered",toaster_expulsion)
	
func reset_bread():
	var reset_state = true
	
# Launch bread out of toaster
func toaster_expulsion():
	apply_impulse(Vector2(0,-1000))
	pass
	
# Is run every physics update (?)
func _integrate_forces(state):
	# Checks for reset of bread
	if reset_state:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		state.transform = Transform2D(0.0,toaster.position)
		reset_state = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Temporary features for debugging
	if Input.is_action_just_pressed("Temp_expulse"):
		toaster_expulsion()
	if Input.is_action_just_pressed("Temp_reset"):
		reset_state = true


