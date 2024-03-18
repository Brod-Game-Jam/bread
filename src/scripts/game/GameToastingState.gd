extends State
class_name GameToastingState

signal bread_heated

@onready var airborne_state:State = $"../Airborne"
@export var temperature_rise_per_second:float = 100#30

func _enter_state():
	state_machine.bread._reset_bread()
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	state_machine.bread.freeze = true
	if state_machine.temperature <= state_machine.max_temperature:
		state_machine.temperature += _delta*temperature_rise_per_second
		if state_machine.temperature >= state_machine.max_temperature:
			state_machine.temperature = state_machine.max_temperature
			bread_heated.emit()
			state_machine._change_state(airborne_state)
			state_machine.bread.freeze = false
			state_machine.bread._toaster_expulsion()


func _state_physics_update(_delta: float):
	pass
