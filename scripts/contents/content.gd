extends Node
class_name Content

@export var sprite: Sprite2D
@export var content_stats: ContentStats
func _ready() -> void:
	# Safely apply the texture now that everything is initialized
	if content_stats and sprite:
		sprite.texture = content_stats.texture
