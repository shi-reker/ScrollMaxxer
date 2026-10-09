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
	setCongratsText()
	setStatsText()
	setStats2Text()
	setScoreText()
	#setClosingText()
	
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	
	await tween.finished

func setCongratsText():
	if MenuChanges.prevScene == "res://Scenes/pause_menu.tscn":
		var d
		if MenuChanges.dateNtime[0] < 2:
			d = "day"
		else:
			d = "days"
		cong1.text = "congratulations! you’ve just completed "+str(MenuChanges.dateNtime[0])+" "+d+" of being a bum
			(or at least that’s what you were supposed to do)"
	else:
		cong1.text = "congratulations! you’ve just completed 2 whole weeks of being a bum
			(or at least that’s what you were supposed to do)"

func setStatsText():
	stats1.text = "this month you’ve scrolled "+str(MenuChanges.reelsScrolled)+" times and done "+str(MenuChanges.tasksDone)+" tasks"

func setStats2Text():
	stats2.text = "while skipping "+str(MenuChanges.tasksIgnored)+" tasks"

func setScoreText():
	score.text = "you racked up a grand total of "+str(MenuChanges.playerScore)+" points"

#func setClosingText():
	#closing.text = ""

func _on_return_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	BGM.play_music("res://assets/audio/BGMs/main menu BGM.mp3")
	queue_free()

func _on_return_mouse_entered() -> void:
	hoverSound.play()
