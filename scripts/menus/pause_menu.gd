extends TextureRect

@export var dateNtime:Label
@export var score:Label
@export var resumeButton:TextureButton
@export var optionsButton:TextureButton
@export var saveButton:TextureButton
@export var exitButton:TextureButton

func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_save_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	queue_free()
