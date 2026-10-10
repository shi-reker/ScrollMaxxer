@tool
extends Control
class_name Comment

@export var comment_label: Label
@export var commenter_label: Label
@export var icon_rect: TextureRect

@export var comment_str: String:
@export var commenter_str: String:
@export var icon_tex: Texture2D


func _ready() -> void:
	if is_instance_valid(comment_label):
		comment_label.text = comment_str
	if is_instance_valid(commenter_label):
		commenter_label.text = commenter_str
