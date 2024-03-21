extends Node
var toaster_animator
var toaster_state
var bread

# Called when the node enters the scene tree for the first time.
func _ready():
	# Retrieve nodes
	toaster_animator = get_node("AnimationPlayer")
	toaster_state = get_node("../../FiniteStateMachine/Toasting")
	bread = get_node("../Bread")
	
	# Connect signals
	toaster_state.bread_heated.connect(_on_expulsion)
	bread.bread_dropped.connect(_on_bread_dropped)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("Temp_expulse"):
		toaster_animator.stop()
		toaster_animator.play("bread_launch")
	if Input.is_action_just_pressed("Temp_reset"):
		toaster_animator.stop()		
		toaster_animator.play("bread_consume")
	
func _on_expulsion():
	toaster_animator.stop()
	toaster_animator.play("bread_launch")
	
func _on_bread_dropped():
	toaster_animator.stop()		
	toaster_animator.play("bread_consume")
