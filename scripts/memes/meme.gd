@tool
extends TextureButton
class_name Meme

@export var max_x: int = 160
@export var max_y: int = 160
@export var meme_sprite: TextureRect
@export var effect_sprite: TextureRect


@export var meme_stats: MemeStats:
	set(value):
		meme_stats = value
		_apply_stats()

func _ready() -> void:
	_apply_stats()
	effect_ready()

func _apply_stats(new_stats: MemeStats = null) -> void:
	if new_stats != null:
		meme_stats = new_stats 
	if meme_stats == null:
		return
	var tex := meme_stats.texture

	if meme_sprite and meme_sprite.texture != tex:
		meme_sprite.texture = tex
	_resize_sprite_to_fit()

func prepaire_effect(texture: Texture2D):
	effect_sprite.show()
	effect_sprite.texture = texture
func remove_effect():
	effect_sprite.hide()
func effect_ready():
	# effect animations
	pass

func _resize_sprite_to_fit() -> void:
	if not meme_sprite:
		return
	var texture_size: Vector2 = meme_sprite.texture.get_size()
	if texture_size.x == 0 or texture_size.y == 0:
		return
	var scale_factor_x: float = max_x / texture_size.x
	var scale_factor_y: float = max_y / texture_size.y
	var final_scale: float = min(scale_factor_x, scale_factor_y)
	if final_scale < 1.0:
		meme_sprite.scale = Vector2(final_scale, final_scale)
	else:
		meme_sprite.scale = Vector2.ONE # Reset to original size if it naturally fits
