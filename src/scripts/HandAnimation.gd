extends AnimationPlayer

func _ready():
	pass
	## RETRIEVE SIGNAL ORIGIN 
	var active = get_node("../FiniteStateMachine/Active")
	var grabbed = get_node("../FiniteStateMachine/Grabbed")
	active.connect("strike",play_strike)
	active.connect("pinch", play_pinch)
	active.connect("ouch", play_ouch)
	grabbed.connect("unpinch", play_unpinch)

func play_ouch():
	stop()
	set_current_animation ("ouch")

func play_pinch():
	stop()
	set_current_animation ("pinch")

func play_unpinch():
	stop()
	set_current_animation ("unpinch")
	
func play_strike(slap_vector):
	stop()
	var slap_angle = slap_vector.angle()
	if slap_angle < 0:
		slap_angle = (2*PI) + slap_angle
	if(slap_angle > ((7*PI)/4) || slap_angle <= (PI/4)):
		#print("right at:")
		set_current_animation ("slap_right")
	elif(slap_angle <= ((3*PI)/4)):
		#print("down at:")
		set_current_animation ("slap_down")
	elif(slap_angle <= ((5*PI)/4)):
		#print("left at:")
		set_current_animation ("slap_left")
	elif(slap_angle <= ((7*PI)/4)):
		#print("up at:")
		set_current_animation ("slap_up")
	#print(str(slap_angle))
	#print(str(slap_vector.x) + " " + str(slap_vector.y))
	
	
