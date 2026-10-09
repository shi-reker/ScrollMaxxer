@tool
extends VBoxContainer
class_name GalleryItem

@onready var tex: TextureRect = $TextureRect
@onready var label: Label = $Label

@export var res: Resource:
	set(value):
		res = value
		if is_node_ready():
			_update_display()

func _ready() -> void:
	_update_display()

func _update_display() -> void:
	if res is MemeStats:
		_set_display(res.texture, res.name)
	elif res is ContentStats:
		_set_display(res.texture, res.name)

func _set_display(texture: Texture2D, display_name: String) -> void:
	tex.texture = texture
	label.text = str("s", display_name)
