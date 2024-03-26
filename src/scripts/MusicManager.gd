extends Node

@export var main_tracks : Array[AudioStreamPlayer2DPercentage]
@export var sub_tracks : Array[AudioStreamPlayer2DPercentage]

@export var active_main_track:int = -1
@export var active_sub_track:int = -1

var sub_max_volume = 3
var main_max_volume = 1

@export var volume_change_delta = 10
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
	_adjust_volumes(delta, main_tracks, active_main_track, main_max_volume, volume_change_delta)
	_adjust_volumes(delta, sub_tracks, active_sub_track, sub_max_volume, volume_change_delta)

func _adjust_volumes(delta, collection, active_track, max_volume, change_delta):
	var n = 0
	for track in collection:
		if n != active_track and track.volume_percentage > 0:
			track.volume_percentage = max(track.volume_percentage - delta*change_delta, 0)
			track.set_volume_percentage(track.volume_percentage)
		elif n == active_track:
			track.volume_percentage = min(max_volume, track.volume_percentage + delta*change_delta)
			track.set_volume_percentage(track.volume_percentage)
		n+=1
