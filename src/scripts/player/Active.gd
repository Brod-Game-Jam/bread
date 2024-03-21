extends State

signal strike

@onready var grabbed_state:State = $"../Grabbed"

var bread;
var bread_near = false;

var hand;
var slap_intensity = 1000;
var hand_speed = 5000
var mouse_pos = Vector2(0,0)

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
		var dir = (bread.position - state_machine.root.position).normalized()
		dir.x = dir.x*0.5
		bread.apply_impulse(dir*slap_intensity)	
		emit_signal("strike", dir)
		
	if (Input.is_action_just_pressed("Grab") && bread_near):
		state_machine._change_state(grabbed_state)

func _on_area_2d_body_entered(body):
	bread_near = true;

func _on_area_2d_body_exited(body):
	bread_near = false;
