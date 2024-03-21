extends State

@onready var active_state:State = $"../Active"
var bread

func _enter_state():
	bread = get_node("../../../Bread")
	bread.grabbed_state = true

func _exit_state():
	pass

func _state_update(_delta: float):
	if (Input.is_action_just_released("Grab")):
		bread.grabbed_state = false
		state_machine._change_state(active_state)

func _state_physics_update(_delta: float):
	pass
