extends CenterContainer

@onready var options = $Option
@onready var pause = $PauseMenu
@onready var effect = $Effect

func _input(event: InputEvent):
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused == true:
			set_visible(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			set_visible(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called when the node enters the scene tree for the first time.
func _ready():
	options.visible = false
	set_visible(false)

func _on_options_pressed():
	options.visible = true
	pause.visible = false

func _on_return_pressed():
	options.visible = false
	pause.visible = true
	
func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	get_tree().paused = false
	set_visible(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_title_screen_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_mouse_entered():
	effect.play(0.0)
