extends State
class_name GameToastingState

signal bread_heated
signal bread_started_heating

@onready var airborne_state:State = $"../Airborne"
@export var temperature_rise_per_second:float = 200/10.64

func _enter_state():
	state_machine.bread._reset_bread()
	bread_started_heating.emit()

func _exit_state():
	pass

func _state_update(_delta: float):
	state_machine.bread.freeze = true
	if state_machine.bread.temperature <= state_machine.max_temperature:
		state_machine.bread.temperature += _delta*temperature_rise_per_second
		var bread_temperature_ratio = (state_machine.bread.temperature/state_machine.max_temperature)
		var sub_number = bread_temperature_ratio*4.0-0.5
		print(round(sub_number))
		state_machine.music_manager.switch_sub_track(round(sub_number))
		if state_machine.bread.temperature >= state_machine.max_temperature:
			state_machine.bread.temperature = state_machine.max_temperature
			bread_heated.emit()
			state_machine._change_state(airborne_state)
			state_machine.bread.freeze = false
			state_machine.bread._toaster_expulsion()
			state_machine.music_manager.switch_sub_track(-1)


func _state_physics_update(_delta: float):
	pass
