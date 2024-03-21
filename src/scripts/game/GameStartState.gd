extends State

func _enter_state():
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	state_machine._change_state($"../Airborne")
	pass

func _state_physics_update(_delta: float):
	pass
