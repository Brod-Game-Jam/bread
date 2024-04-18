extends CanvasLayer

@onready var fsm = $"../../FiniteStateMachine"
@onready var heat = $Heat
@onready var animation = $AnimationPlayer
var child

# Called when the node enters the scene tree for the first time.
func _ready():
	heat.max_value = fsm.max_temperature
	animation.play("GUI")
	update_health(fsm.max_lives) # Connect with FSM for updates

# TODO: Connect signal when hurt
func hurt():
	animation.play("Hurt")
	update_health(fsm.current_lives)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	heat.value = fsm.get_temperature()

# Updates Health
func update_health(value):
	for i in 3:
		$Health.get_child(i).visible = value > i
