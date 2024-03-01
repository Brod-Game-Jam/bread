extends Node
var toaster_animator

# Called when the node enters the scene tree for the first time.
func _ready():
	toaster_animator = get_node("AnimationPlayer")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("Temp_expulse"):
		toaster_animator.stop()
		toaster_animator.play("bread_launch")
	if Input.is_action_just_pressed("Temp_reset"):
		toaster_animator.stop()		
		toaster_animator.play("bread_consume")
	
