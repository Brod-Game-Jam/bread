extends State
class_name GameAirborneState

@onready var insert 

func _enter_state():
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	if state_machine.temperature > 0:
		state_machine.temperature -= _delta
		if state_machine.temperature <= 0:
			state_machine.temperature = 0

func _state_physics_update(_delta: float):
	pass
