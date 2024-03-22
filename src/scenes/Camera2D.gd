extends Camera2D

@export var random_strength:float = 20.0
@export var fade:float = 5.0

var rng = RandomNumberGenerator.new()
var pos:Vector2 = offset
var shake_strength = 0.0

func apply_shake():
	shake_strength = random_strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Bite"):
		apply_shake()
		print("There's a snake in my boots!")
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,fade*delta)
		offset = pos + Vector2(rng.randf_range(-shake_strength,shake_strength), rng.randf_range(-shake_strength,shake_strength))
