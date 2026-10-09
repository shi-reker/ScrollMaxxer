extends TextureRect

@export var dateNtime:Label
@export var score:Label
@export var resumeButton:TextureButton
@export var optionsButton:TextureButton
@export var saveButton:TextureButton
@export var exitButton:TextureButton
@export var hoverSound:AudioStreamPlayer2D
@export var pressSound:AudioStreamPlayer2D

func _ready() -> void:
	var d = MenuChanges.dateNtime[0]
	var h = MenuChanges.dateNtime[1]
	var m = MenuChanges.dateNtime[2]
	var strMin:String = str(m)
	var strHR:String = str(h)
	if m < 10:
		strMin = "0" +str(m)
	if h < 10:
		strHR = "0" +str(h)
	
	dateNtime.text = "D" +str(d)+ " - " +strHR+ ":" +strMin
	score.text = "score: " +str(MenuChanges.playerScore)

func _on_resume_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	get_tree().paused = false
	queue_free()

func _on_options_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	MenuChanges.prevScene = "res://Scenes/pause_menu.tscn"
	var optionScene = load("res://Scenes/options_menu.tscn")
	get_parent().add_child(optionScene.instantiate())
	queue_free()

func _on_GameEnd_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	MenuChanges.prevScene = "res://Scenes/pause_menu.tscn"
	var endScene = load("res://Scenes/game_end.tscn")
	get_parent().add_child(endScene.instantiate())
	queue_free()

func _on_exit_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	queue_free()

func _on_resume_mouse_entered() -> void:
	hoverSound.play()

func _on_options_mouse_entered() -> void:
	hoverSound.play()

func _on_GameEnd_mouse_entered() -> void:
	hoverSound.play()

func _on_exit_mouse_entered() -> void:
	hoverSound.play()
