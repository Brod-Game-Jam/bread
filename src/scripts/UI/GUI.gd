extends CanvasLayer

var fsm

# Called when the node enters the scene tree for the first time.
func _ready():
	fsm = get_node("../../FiniteStateMachine")
	$Heat.max_value = fsm.max_temperature
	$AnimationPlayer.play("Bite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Heat.value = fsm.temperature
