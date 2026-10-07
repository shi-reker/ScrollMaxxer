extends TextureRect

@export var dateNtime:Label
@export var score:Label
@export var resumeButton:TextureButton
@export var optionsButton:TextureButton
@export var saveButton:TextureButton
@export var exitButton:TextureButton

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
	get_tree().paused = false
	queue_free()

func _on_options_pressed() -> void:
	MenuChanges.prevScene = "res://Scenes/pause_menu.tscn"
	var optionScene = load("res://Scenes/options_menu.tscn")
	get_parent().add_child(optionScene.instantiate())
	queue_free()

func _on_save_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	queue_free()
