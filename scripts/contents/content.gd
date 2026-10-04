@tool
extends Node
class_name Content

@export var sprite: TextureRect
@export var max_x: int = 320
@export var max_y: int = 560
@export var content_stats: ContentStats:
	set(value):
		content_stats = value
		if sprite and value:
			sprite.texture = value.texture
			_resize_sprite_to_fit()
		
func _ready() -> void:
	# Safely apply the texture now that everything is initialized
	if content_stats and sprite:
		sprite.texture = content_stats.texture
		_resize_sprite_to_fit()

func _resize_sprite_to_fit() -> void:
	if not sprite:
		return
	var texture_size: Vector2 = sprite.texture.get_size()
	if texture_size.x == 0 or texture_size.y == 0:
		return
	var scale_factor_x: float = max_x / texture_size.x
	var scale_factor_y: float = max_y / texture_size.y
	var final_scale: float = min(scale_factor_x, scale_factor_y)
	if final_scale < 1.0:
		sprite.scale = Vector2(final_scale, final_scale)
	else:
		sprite.scale = Vector2.ONE # Reset to original size if it naturally fits
