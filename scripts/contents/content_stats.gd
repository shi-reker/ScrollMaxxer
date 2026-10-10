extends Resource
class_name ContentStats

@export var code: Enums.Content
@export var genre: Enums.Genre
@export var name: String = ""
@export var creator: String = "" 

@export var texture: Texture2D = preload("res://assets/temp_content_sprite.tres")

func _on_scrolled():
	pass
