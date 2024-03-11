extends RigidBody2D
var toaster
var reset_state = false

signal bread_dropped

# Called when the node enters the scene tree for the first time.
func _ready():
	# Retrieve nodes
	var state_toasting = get_node("../../FiniteStateMachine/Toasting")
	var state_airborne = get_node("../../FiniteStateMachine/Airborne")
	toaster = get_node("../Toaster")
	
	# Connect signals
	state_toasting.connect("state_entered",_reset_bread)
	state_airborne.connect("state_entered",_toaster_expulsion)
	
func _reset_bread():
	reset_state = true
	
# Launch bread out of toaster
func _toaster_expulsion():
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
		# TODO enable bread prison
		
	# Checks for dropped bread
	if position.y > get_viewport_rect().size.y:
		bread_dropped.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Temporary features for debugging
	if Input.is_action_just_pressed("Temp_expulse"):
		_toaster_expulsion()
	if Input.is_action_just_pressed("Temp_reset"):
		reset_state = true


