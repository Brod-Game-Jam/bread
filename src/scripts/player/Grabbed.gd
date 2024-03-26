extends State

signal unpinch
signal bite

@onready var active_state:State = $"../Active"
@onready var toasting_state = $"../../../../FiniteStateMachine/Toasting"
@onready var hand:Node2D = $"../../"
@onready var fsm = $"../../../../FiniteStateMachine"
@onready var bread = $"../../../Bread"

func _enter_state():
	bread.grabbed_state = true

func _exit_state():
	hand.visible = true

func _state_update(_delta: float):
	if (Input.is_action_just_released("Grab") || fsm.bread_is_too_cold()):
		release()
	elif (Input.is_action_just_pressed("Bite")):
		hand.visible = false
		emit_signal("bite")
		release()
		fsm._change_state(toasting_state)

func release():
		bread.grabbed_state = false
		emit_signal("unpinch")
		state_machine._change_state(active_state)

func _state_physics_update(_delta: float):
	pass
