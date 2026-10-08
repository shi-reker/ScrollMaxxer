extends Control
class_name ComboCounter

@export var fill_color_node: ColorRect
@export var line_color_node: ColorRect
@export var count_label: Label

func pop_up_score(combo:int, loc:Vector2):
	pass

func increase_animation(combo: int):
	pass
	
func decrease_animation(combo: int):
	pass

func update_counter(combo: int):
	print_debug("updating")
	if combo < 5:
		visible = false
		return

	visible = true
	count_label.text = str("x", combo)
	
	var hue: float = combo % 50 / 50.0
	var fill_color: Color = Color.from_hsv(hue, 0.3, 1.0, 1.0)
	var line_color: Color = Color.from_hsv(hue, 1.0, 1.0, 1.0)
	
	fill_color_node.color = fill_color
	line_color_node.color = line_color
