@tool
extends TextureButton
class_name Meme

@export var max_x: int = 160
@export var max_y: int = 160
@export var sprite: TextureRect

@export var meme_stats: MemeStats:
	set(value):
		meme_stats = value
		_apply_stats()

func _ready() -> void:
	_apply_stats()

func _apply_stats(new_stats: MemeStats = null) -> void:
	if new_stats != null:
		meme_stats = new_stats 
	if meme_stats == null:
		return
	var tex := meme_stats.texture

	if sprite and sprite.texture != tex:
		sprite.texture = tex
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
