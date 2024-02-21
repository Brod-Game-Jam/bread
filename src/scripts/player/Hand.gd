extends Node2D

var mouse_pos = Vector2(0,0)
var speed = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_pos = get_viewport().get_mouse_position()
	position = mouse_pos #position.move_toward(mouse_pos, delta * speed)
