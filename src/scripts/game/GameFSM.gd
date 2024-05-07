extends FiniteStateMachine

signal hurt

@export var max_temperature:float = 200

@export var max_lives:int = 3
var current_lives:int = 3

@export var bread_temperature_edible_spectrum = Vector2(30, 50)

@export var bread_size_coefficient:float

@export var temperature_decrease_per_second:float = 20 #Should be exported to Airborne

@export var bread:Node2D
@export var hand:Node2D
@export var toaster:Node2D
@export var music_manager:Node
@export var gui_manager:Node

func bread_is_edible () -> bool:
	if bread.temperature < bread_temperature_edible_spectrum.y and \
			bread.temperature > bread_temperature_edible_spectrum.x: 
		return true
	return false

func bread_is_too_hot () -> bool:
	if bread.temperature > bread_temperature_edible_spectrum.y:
		return true
	return false
		
func bread_is_too_cold () -> bool:
	if bread.temperature < bread_temperature_edible_spectrum.x: 
		return true
	return false

func _ready():
	current_lives = max_lives
	bread.bread_dropped.connect(on_bread_dropped)
	$Toasting.bread_started_heating.connect(on_bread_started_heating)
	$Airborne.bread_sent_airborne.connect(on_sent_bread)
	hurt.connect(gui_manager._hurt)
	music_manager.start_playing()
	bread.bread_bit.connect(on_bread_bit)
	super._ready()

func on_bread_bit():
	music_manager.increase_pitch(0.04)
	if bread._get_bread_size() == 0:
		_change_state($Win)

func on_bread_started_heating ():
	music_manager.switch_main_track(0)
	print("sent signal")

func on_sent_bread ():
	music_manager.switch_main_track(1)

func get_temperature():
	return bread.temperature

func _change_temperature(delta_t):
	bread.temperature += delta_t
	bread.temperature = clampi(bread.temperature, 0, max_temperature)

func _process(delta):
	super._process(delta)

func on_bread_dropped():
	bread.temperature = 0
	if current_lives == 0:
		_change_state($Lose)
		bread.visible = false
		return
	if current_state == states[2]:
		current_state._on_bread_dropped()
		current_lives -= 1
		hurt.emit()
	
