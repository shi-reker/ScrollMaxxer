extends TextureRect
class_name Setting_slot

@export var settingTitle:Label
@export var settingSlider:HSlider
@export var hoverSound:AudioStreamPlayer2D

func _on_h_slider_mouse_entered() -> void:
	hoverSound.play()
