extends State
class_name GameAirborneState

signal bread_sent_airborne

@onready var insert 
@onready var toaster_state:State = $"../Toasting"
@export var hot_bread_color:Color
@export var cool_bread_color:Color
@export var color_change_window:float = 5
var color_offset = 0
var current_color = Color.WHITE
var flashSpeed:float = 0.01
var bread_too_hot = false

func _enter_state():
	state_machine.bread.temperature = state_machine.max_temperature
	bread_too_hot = true
	bread_sent_airborne.emit()

func _exit_state():
	pass

func _state_update(_delta: float):
	_do_color_check(_delta)
	if state_machine.bread.temperature > 0:
		state_machine.bread.temperature -= _delta*state_machine.temperature_decrease_per_second
		if state_machine.bread.temperature <= 0:
			state_machine.bread.temperature = 0
		if state_machine.bread.temperature < state_machine.bread_temperature_edible_spectrum.y:
			bread_too_hot = false

func _do_color_check(_delta: float):
	var temp = state_machine.bread.temperature
	var low_bound = state_machine.bread_temperature_edible_spectrum.x - color_change_window
	var hi_bound = state_machine.bread_temperature_edible_spectrum.y + color_change_window
	var midpoint = (low_bound+hi_bound)/2
	var width = (hi_bound-low_bound)
	
	if temp > midpoint:
		current_color = hot_bread_color
	elif temp < midpoint:
		current_color = cool_bread_color
		
	var dist = abs(temp-midpoint)-width/2
	var lerpvalue = clamp(dist/color_change_window, 0, 1)
	current_color = ColorHelper.lerp_color(Color.WHITE, current_color, lerpvalue)
	
	var actual_color = current_color
	#var sin_lerp = sin(Time.get_ticks_msec()/1000 * flashSpeed)
	#actual_color = ColorHelper.lerp_color(Color.WHITE, current_color, sin_lerp)
	state_machine.bread.modulate = actual_color
		
func _state_physics_update(_delta: float):
	pass
	
func _on_bread_dropped():
	# TODO check if game over
	state_machine._change_state(toaster_state)
