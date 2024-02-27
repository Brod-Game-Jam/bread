extends MarginContainer

@onready var labels = $Main
@onready var settings = $Settings

func _on_new_game_pressed():
	print("New Game")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_settings_pressed():
	labels.visible = false
	settings.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	labels.visible = true
	settings.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
