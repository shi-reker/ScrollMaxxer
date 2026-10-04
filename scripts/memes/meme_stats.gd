extends Resource
class_name MemeStats

@export var code: Enums.Meme = 0
var tempSprite: Sprite2D = preload("res://assets/template_sprite.tscn").instantiate() as Sprite2D
@export var texture: Texture2D = tempSprite.texture
