extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# ... floating bread
	move_and_collide(Vector2(10, 0) * delta)
	
	# TODO collision between bread and hand
