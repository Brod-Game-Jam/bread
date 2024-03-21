extends MarginContainer

@onready var labels = $Main
@onready var settings = $Settings

func _on_return_pressed():
	labels.visible = true
	settings.visible = false

func _on_new_game_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_settings_pressed():
	labels.visible = false
	settings.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	labels.visible = true
	settings.visible = false