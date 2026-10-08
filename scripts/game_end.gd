extends TextureRect

@export var cong1:Label
@export var stats1:Label
@export var stats2:Label
@export var score:Label
@export var closing:Label
@export var returnToMain:TextureButton
@export var hoverSound:AudioStreamPlayer2D
@export var pressSound:AudioStreamPlayer2D

func _ready() -> void:
	modulate.a = 0.0
	
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	
	await tween.finished

func _on_return_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	queue_free()

func _on_return_mouse_entered() -> void:
	hoverSound.play()
