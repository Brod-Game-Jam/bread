extends VolumeSlider

@export var sound_file: AudioStream

# Declare an AudioStreamPlayer node as a class member
var sound_player := AudioStreamPlayer.new()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	# Add the AudioStreamPlayer as a child to the player node
	super()
	add_child(sound_player)

func _on_drag_ended(value_changed):
	sound_player.bus = bus_name
	sound_player.stream = sound_file
	sound_player.play()
