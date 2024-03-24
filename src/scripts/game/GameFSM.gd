extends FiniteStateMachine

@export var max_temperature:float = 200

@export var max_lives:int
var current_lives:int

@export var bread_temperature_edible_spectrum = Vector2(30, 50)

@export var bread_size_coefficient:float

@export var temperature_decrease_per_second:float = 10 #Should be exported to Airborne

@export var bread:Node2D
@export var hand:Node2D
@export var toaster:Node2D
@export var music_manager:Node

func bread_is_edible () -> bool:
	if bread.temperature < bread_temperature_edible_spectrum.y and \
			bread.temperature > bread_temperature_edible_spectrum: 
		return true
	return false

func _ready():
	bread.bread_dropped.connect(on_bread_dropped)
	$Toasting.bread_started_heating.connect(on_bread_started_heating)
	$Airborne.bread_sent_airborne.connect(on_sent_bread)
	music_manager.start_playing()
	super._ready()

func on_bread_started_heating ():
	music_manager.switch_main_track(0)
	print("sent signal")

func on_sent_bread ():
	music_manager.switch_main_track(1)


func _change_temperature(delta_t):
	bread.temperature += delta_t
	bread.temperature = clampi(bread.temperature, 0, max_temperature)

func _process(delta):
	super._process(delta)

func on_bread_dropped():
	bread.temperature = 0
	if current_state == states[2]:
		current_state._on_bread_dropped()
	
