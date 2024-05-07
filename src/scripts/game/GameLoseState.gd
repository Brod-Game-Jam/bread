extends State
class_name GameLoseState

const end_screen = preload("res://scenes/end_screen.tscn")

func _enter_state():
	pass
	
	# End Screen, code test
	var game_over = end_screen.instantiate()
	add_child(game_over)
	game_over.set_win_title(false) # Set false if lose and true if win
	get_tree().paused = true

func _exit_state():
	pass

func _state_update(_delta: float):
	pass

func _state_physics_update(_delta: float):
	pass
