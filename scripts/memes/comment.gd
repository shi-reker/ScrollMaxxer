@tool
extends Control
class_name Comment

@export var comment_label: Label
@export var commenter_label: Label
@export var icon_rect: TextureRect

@export var comment_str: String:
	set(value):
		comment_str = value
		if is_instance_valid(comment_label):
			comment_label.text = value
@export var commenter_str: String:
	set(value):
		commenter_str = value
		if is_instance_valid(commenter_label):
			commenter_label.text = value
		randomize_icon_hue()
@export var icon_tex: Texture2D


func _ready() -> void:
	if is_instance_valid(comment_label):
		comment_label.text = comment_str
	if is_instance_valid(commenter_label):
		commenter_label.text = commenter_str
	randomize_icon_hue()


func randomize_icon_hue():
	if is_instance_valid(icon_rect) and icon_rect.texture is GradientTexture2D:
		var texture = icon_rect.texture as GradientTexture2D
		if texture.gradient:
			texture.gradient = texture.gradient.duplicate()
			var random_hue: float = randf()
			for i in range(texture.gradient.get_point_count()):
				var original_color: Color = texture.gradient.get_color(i)
				var new_color: Color = Color.from_hsv(
					fmod(original_color.h + random_hue, 1.0),
					original_color.s,
					original_color.v,
					original_color.a # Keep original transparency
				)
				
				texture.gradient.set_color(i, new_color)
