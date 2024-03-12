extends RigidBody2D
var toaster
var toaster_constraints
var bread_body

var reset_state = false

var toaster_constraints_instance

signal bread_dropped

# Called when the node enters the scene tree for the first time.
func _ready():
	# COMMENT: Dessa functioner verkar kallas direkt från state machine nuförtiden så de behöver inte vara kopplade till signaler
	#var state_toasting = get_node("../../FiniteStateMachine/Toasting")
	#var state_airborne = get_node("../../FiniteStateMachine/Airborne")
	# state_toasting.connect("state_entered",_reset_bread)
	# state_airborne.connect("state_entered",_toaster_expulsion)
	
	# Retrieve nodes
	toaster = get_node("../Toaster")
	
	# Place bread in toaster
	transform = Transform2D(0.0,toaster.position)
	freeze = true

func _reset_bread():
	reset_state = true
	
# Launch bread out of toaster
func _toaster_expulsion():
	reset_state = false # WHY WHO IS FREEZING MY BREAD???
	freeze = false
	apply_impulse(Vector2(0,-1000))
	pass
	
# Is run every physics update (?)
func _integrate_forces(state):
	# Checks for reset of bread
	if reset_state:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		state.transform = Transform2D(0.0,toaster.position)
		freeze = true
		reset_state = false
		
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

