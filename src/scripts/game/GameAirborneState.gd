extends State
class_name GameAirborneState

@onready var insert 
@export var hot_bread_color:Color
@export var cool_bread_color:Color
@export var color_change_window:float = 5
var color_offset = 0
var current_color = Color.WHITE
var flashSpeed:float = 0.01

func _enter_state():
	state_machine.temperature = state_machine.max_temperature
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	_do_color_check(_delta)
	if state_machine.temperature > 0:
		state_machine.temperature -= _delta*state_machine.temperature_decrease_per_second
		if state_machine.temperature <= 0:
			state_machine.temperature = 0

func _do_color_check(_delta: float):
	var temp = state_machine.temperature
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
