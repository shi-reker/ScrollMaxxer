extends Node

@export var sprite: Sprite2D
@export var meme_stats: ContentStats
func _ready() -> void:
	# Safely apply the texture now that everything is initialized
	if meme_stats and sprite:
		sprite.texture = meme_stats.texture
