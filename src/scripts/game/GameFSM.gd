extends FiniteStateMachine

@export var max_heat:float = 200
var current_heat:float 

@export var max_lives:int
var current_lives:int

@export var bread_temperature_edible_spectrum = Vector2(30, 50)

@export var bread_size_coefficient:float

@export var temperature_decrease_per_second:float = 20 #Should be exported to Airborne

@export var bread:Node2D
@export var hand:Node2D
@export var toaster:Node2D

func bread_is_edible () -> bool:
	if current_heat < bread_temperature_edible_spectrum.y and \
			current_heat > bread_temperature_edible_spectrum: 
		return true
	return false

func _ready():
	super._ready()
	
	
