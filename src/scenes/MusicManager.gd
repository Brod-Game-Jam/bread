extends Node

@export var main_tracks : Array[AudioStreamPlayer2D]
@export var sub_tracks : Array[AudioStreamPlayer2D]

@export var active_main_track:int = -1
@export var active_sub_track:int = -1

@export var volume_change_delta = 60
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_playing():
	for track in main_tracks:
		track.play()
	for track in sub_tracks:
		track.play()

func switch_main_track(track:int):
	active_main_track = track

func switch_sub_track(track:int):
	active_sub_track = track

func _physics_process(delta):
	_adjust_volumes(delta, main_tracks, active_main_track)
	_adjust_volumes(delta, sub_tracks, active_sub_track)

func _adjust_volumes(delta, collection, active_track):
	var n = 0
	for track in collection:
		if n != active_track and track.volume_db > -20:
			track.volume_db -= delta*volume_change_delta
		elif n == active_track:
			track.volume_db = min(0, track.volume_db + delta*volume_change_delta)
		n+=1
