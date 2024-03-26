extends State

signal strike
signal pinch

@onready var grabbed_state:State = $"../Grabbed"

var hand;
var hand_speed = 5000
var mouse_pos = Vector2(0,0)
var horizontal_slap_intensity = 500;
var vertical_slap_force = -100;

var bread;
var bread_near = false;

var fsm

func _enter_state():
	bread = get_node("../../../Bread")
	hand = get_node("../../.")
	fsm = get_node("../../../../FiniteStateMachine")

func _exit_state():
	pass

func _state_update(_delta: float):
	pass
		
func _state_physics_update(_delta: float):
	# move hand
	mouse_pos = get_viewport().get_mouse_position()
	hand.position = hand.position.move_toward(mouse_pos, _delta * hand_speed)
	
	if (Input.is_action_just_pressed("Strike") && bread_near):
		# invert old velocity if going down
		if (bread.linear_velocity.y > 0): 
			bread.linear_velocity.y = -bread.linear_velocity.y; 
	
		# degrade old velocity
		bread.linear_velocity.x = 0.5*bread.linear_velocity.x;
	
		# apply impulse from slap
		var dir = (bread.position - hand.position).normalized()
		dir.x = dir.x * horizontal_slap_intensity;
		dir.y = vertical_slap_force; # constant vertical contribution
		bread.apply_impulse(dir)
		
		emit_signal("strike", dir)
		
	if (Input.is_action_just_pressed("Grab") && bread_near):
		if(fsm.bread_is_edible()):
			emit_signal("pinch")
			state_machine._change_state(grabbed_state)
		elif (fsm.bread_is_too_hot()):
			#play ouch anim
			pass
		elif (fsm.bread_is_too_cold()):
			#something?
			pass

func _on_area_2d_body_entered(body):
	bread_near = true;

func _on_area_2d_body_exited(body):
	bread_near = false;
