extends State

signal strike

var bread;
var bread_near = false;
var slap_intensity = 1000;

func _initialize_state(state_machine_node:FiniteStateMachine, root_node:Node2D):
	state_machine = state_machine_node
	root = root_node
	bread = get_node("../../../Bread")

func _enter_state():
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	pass
		
func _state_physics_update(_delta: float):
	if (Input.is_action_just_pressed("Strike") && bread_near):
		var dir = (bread.position - state_machine.root.position).normalized()
		dir.x = dir.x*0.5
		bread.apply_impulse(dir*slap_intensity)	
		emit_signal("strike", dir)
		
	elif (Input.is_action_just_pressed("Strike")):
		print("Not in bread area :(")


func _on_area_2d_body_entered(body):
	print("Bread area entered")
	bread_near = true;
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	print("Bread area exited")
	bread_near = false;
	pass # Replace with function body.
