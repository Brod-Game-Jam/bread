extends FiniteStateMachine

@export var max_temperature:float = 200
var temperature:float 

@export var max_lives:int
var current_lives:int

@export var bread_temperature_edible_spectrum = Vector2(30, 50)

@export var bread_size_coefficient:float

@export var temperature_decrease_per_second:float = 10 #Should be exported to Airborne

@export var bread:Node2D
@export var hand:Node2D
@export var toaster:Node2D

func bread_is_edible () -> bool:
	if temperature < bread_temperature_edible_spectrum.y and \
			temperature > bread_temperature_edible_spectrum: 
		return true
	return false

func _ready():
	super._ready()
	bread.bread_dropped.connect(on_bread_dropped)
	
func _process(delta):
	super._process(delta)

func on_bread_dropped():
	temperature = 0
	if current_state == states[2]:
		current_state._on_bread_dropped()
	
