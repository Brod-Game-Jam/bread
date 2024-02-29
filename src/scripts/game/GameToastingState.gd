extends State
class_name GameToastingState

signal bread_heated

@onready var airborne_state:State = $"../Airborne"
@export var temperature_rise_per_second:float = 10

func _enter_state():
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	if state_machine.temperature <= state_machine.max_temperature:
		state_machine.temperature += _delta
		if state_machine.temperature >= state_machine.max_temperature:
			state_machine.temperature = state_machine.max_temperature
			bread_heated.emit()
			state_machine._change_state(airborne_state)

func _state_physics_update(_delta: float):
	pass
