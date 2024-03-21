extends State

signal strike

@onready var grabbed_state:State = $"../Grabbed"

var hand;
var hand_speed = 5000
var mouse_pos = Vector2(0,0)
var horizontal_slap_intensity = 500;
var vertical_slap_force = -100;

var bread;
var bread_near = false;

func _enter_state():
	bread = get_node("../../../Bread")
	hand = get_node("../../.")

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
			bread.linear_velocity = -bread.linear_velocity; 
	
		# apply impulse from slap
		var dir = (bread.position - hand.position).normalized()
		dir.x = dir.x * horizontal_slap_intensity;
		dir.y = vertical_slap_force; # constant vertical contribution
		bread.apply_impulse(dir)
		
		emit_signal("strike", dir)
		
	if (Input.is_action_just_pressed("Grab") && bread_near):
		state_machine._change_state(grabbed_state)

func _on_area_2d_body_entered(body):
	bread_near = true;

func _on_area_2d_body_exited(body):
	bread_near = false;
