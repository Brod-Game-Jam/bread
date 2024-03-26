extends State

signal unpinch
signal bite

@onready var active_state:State = $"../Active"
@onready var hand:Node2D = $"../../"
var bread

func _enter_state():
	bread = get_node("../../../Bread")
	bread.grabbed_state = true

func _exit_state():
	hand.visible = true

func _state_update(_delta: float):
	if (Input.is_action_just_released("Grab")):
		bread.grabbed_state = false
		emit_signal("unpinch")
		state_machine._change_state(active_state)
	if (Input.is_action_just_pressed("Bite")):
		hand.visible = false
		emit_signal("bite")

func _state_physics_update(_delta: float):
	pass
