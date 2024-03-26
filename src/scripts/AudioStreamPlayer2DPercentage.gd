extends AudioStreamPlayer2D
class_name AudioStreamPlayer2DPercentage

var volume_percentage = 1

func set_volume_percentage (percentage:float):
	volume_percentage = percentage
	volume_db = 10*log(volume_percentage)
	


