extends TextureRect

@export var playButton:TextureButton
@export var optButton:TextureButton
@export var quitButton:TextureButton
@export var hoverSound:AudioStreamPlayer2D
@export var pressSound:AudioStreamPlayer2D

func _ready() -> void:
	BGM.play_music("res://assets/audio/BGMs/main menu BGM.mp3")

func _on_start_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_start_mouse_entered() -> void:
	hoverSound.play()

func _on_options_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	MenuChanges.prevScene = "res://Scenes/main_menu.tscn"
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
	#queue_free()

func _on_options_mouse_entered() -> void:
	hoverSound.play()

func _on_quit_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	hoverSound.play()



func _on_gallery_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	MenuChanges.prevScene = "res://Scenes/main_menu.tscn"
	get_tree().change_scene_to_file("res://Scenes/gallery_menu.tscn")
	#queue_free()
