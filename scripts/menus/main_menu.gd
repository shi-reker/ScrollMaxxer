extends TextureRect

@export var playButton:TextureButton
@export var optButton:TextureButton
@export var quitButton:TextureButton

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_options_pressed() -> void:
	MenuChanges.prevScene = "res://Scenes/main_menu.tscn"
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
	#queue_free()

func _on_quit_pressed() -> void:
	get_tree().quit()
