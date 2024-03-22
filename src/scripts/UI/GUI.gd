extends CanvasLayer

@export var heart_file:Texture2D
var fsm
var child

# Called when the node enters the scene tree for the first time.
func _ready():
	fsm = get_node("../../FiniteStateMachine")
	
	$Heat.max_value = fsm.max_temperature
	$AnimationPlayer.play("Bite")
	update_health(fsm.current_lives) # Connect with FSM for updates

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Heat.value = fsm.temperature

func update_health(value):
	for i in fsm.max_lives:
		$Health.get_child(i).visible = value > i
