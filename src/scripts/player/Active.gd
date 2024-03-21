extends State

signal strike
signal pinch

@onready var grabbed_state:State = $"../Grabbed"

var bread;
var bread_near = false;
var slap_intensity = 1000;

func _enter_state():
	bread = get_node("../../../Bread")

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
		
	if (Input.is_action_just_pressed("Grab") && bread_near):
		emit_signal("pinch")
		state_machine._change_state(grabbed_state)

func _on_area_2d_body_entered(body):
	bread_near = true;

func _on_area_2d_body_exited(body):
	bread_near = false;
