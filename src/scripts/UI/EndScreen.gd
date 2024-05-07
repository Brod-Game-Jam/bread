extends CanvasLayer

var bread = load("res://visual/legacy/bread_32.png")
@onready var title = $PanelContainer/MarginContainer/VBoxContainer/Title

func _ready():
	Input.set_custom_mouse_cursor(bread)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_win_title(win:bool):
	if win:
		title.text = "You Win"
	else:
		title.text = "You Lose"

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_main_menu_pressed():
	print("hello")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
