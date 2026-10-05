extends Resource
class_name ContentStats

@export var code: Enums.Content = 0
@export var genre: Enums.Genre = 0

@export var texture: Texture2D = preload("res://assets/temp_content_sprite.tres")

func _on_scrolled():
	pass
