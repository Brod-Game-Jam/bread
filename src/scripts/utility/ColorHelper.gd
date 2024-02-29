extends Node
class_name ColorHelper

static func lerp_color(from:Color, to:Color, coefficent:float) -> Color:
	var r = from.r + (to.r - from.r)*coefficent
	var g = from.g + (to.g - from.g)*coefficent
	var b = from.b + (to.b - from.b)*coefficent
	var a = from.a + (to.a - from.a)*coefficent
	var newColor = Color(r,g,b,a)
	return newColor
