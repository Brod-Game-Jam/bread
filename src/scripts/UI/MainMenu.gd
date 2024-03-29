extends CanvasLayer

@onready var labels = $Main
@onready var settings = $Settings
@onready var bread = $Main/Container/Bread
@onready var toaster_player = $Toaster/AnimationPlayer
@onready var effect = $Effect

func _on_return_pressed():
	labels.visible = true
	settings.visible = false

func _on_play_pressed():
	bread.freeze = false
	await get_tree().create_timer(0.8).timeout
	toaster_player.play("bread_consume")
	await get_tree().create_timer(0.2).timeout
	
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")

func _on_settings_pressed():
	settings.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	settings.visible = false

func _on_quit_pressed():
	get_tree().quit()

func _on_mouse_entered():
	effect.play(0.0)
