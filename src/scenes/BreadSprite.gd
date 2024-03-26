extends Sprite2D
var final_image

# Called when the node enters the scene tree for the first time.
func _ready():
	# Store the original as the staring point of the bread eating
	var original = Image.load_from_file("res://visual/sprites/bread/bread.png")
	original.save_png("res://visual/sprites/bread/temporary_bread.png")
	
	# Create transparent img with the correct format
	final_image = Image.load_from_file("res://visual/sprites/bread/bread.png")
	final_image.fill(Color(0,0,0,0))

func bite(dir):
	
	# Load images
	var mask = Image.load_from_file("res://visual/sprites/bread/bite_" + dir + ".png")
	var source = Image.load_from_file("res://visual/sprites/bread/temporary_bread.png")
	final_image.fill(Color(0,0,0,0))
	
	# Mask
	final_image.blit_rect_mask(source,mask, Rect2(Vector2.ZERO, Vector2(663, 656)),Vector2(0,0))
	
	# Save and update texture
	final_image.save_png("res://visual/sprites/bread/temporary_bread.png")
	texture = ImageTexture.create_from_image(final_image)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
