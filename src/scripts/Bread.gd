extends RigidBody2D
var hand
var toaster
var hand_grabbed
var toaster_constraints
var bread_body
var bread_sprite

var reset_state = false
var grabbed_state = false
var temperature:float = -1
var toaster_constraints_instance

var bread_chunks = ["left", "top_left", "top", "top_right",
					"right", "bottom_right", "bottom", 
					"bottom_left"]

signal bread_dropped

# Called when the node enters the scene tree for the first time.
func _ready():
	# Retrieve nodes
	hand = get_node("../Hand")
	toaster = get_node("../Toaster")
	hand_grabbed = get_node("../Hand/FiniteStateMachine/Grabbed")
	bread_sprite = get_node_or_null("BreadSprite") as Node2D
	
	
	# Connect signals
	hand_grabbed.bite.connect(bite)
	
func bite():
	
	# Bite a random chunk
	if(bread_chunks.size() > 0):
		var index = randi_range(0,bread_chunks.size()-1)
		var dir = bread_chunks[index]
		bread_chunks.remove_at(index)
		bread_sprite.bite(dir)
	
func _reset_bread():
	reset_state = true
	
# Launch bread out of toaster
func _toaster_expulsion():
	reset_state = false 
	apply_impulse(Vector2(0,-1000))
	
# Is run every physics update (?)
func _integrate_forces(state):
	# Checks for reset of bread
	if reset_state:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		state.transform = Transform2D(0.0,toaster.position)
	
	# Checks for dropped bread
	if position.y > get_viewport_rect().size.y + 500:
		emit_signal("bread_dropped")
		
	if grabbed_state:
		# Reset velocities
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		# Move bread in relation to pinching hand
		state.transform = Transform2D(0.0, Vector2(hand.position.x-60, hand.position.y+45))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Temporary features for debugging
	if Input.is_action_just_pressed("Temp_expulse"):
		_toaster_expulsion()
	if Input.is_action_just_pressed("Temp_reset"):
		reset_state = true

