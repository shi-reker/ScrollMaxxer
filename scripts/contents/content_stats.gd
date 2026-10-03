extends Resource
class_name ContentStats

@export var code: Enums.Content = 0
var tempSprite: Sprite2D = preload("res://assets/template_sprite.tscn").instantiate() as Sprite2D
@export var texture: Texture2D = tempSprite.texture

func _on_scrolled():
	pass
