extends TextureRect

@export var step1:TextureRect
@export var step2:TextureRect
@export var step3:TextureRect
@export var step4:TextureRect
@export var hoverSound:AudioStreamPlayer2D
@export var pressSound:AudioStreamPlayer2D
var step:int = 1

func _on_texture_button_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	
	match step:
		1:
			step1.hide()
			step2.show()
		2:
			step2.hide()
			step3.show()
		3:
			step3.hide()
			step4.show()
		4:
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
	step += 1
func _on_next_mouse_entered() -> void:
	hoverSound.play()
