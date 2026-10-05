extends TextureRect

@export var container:VBoxContainer
@export var game:Main

var task = preload("res://Scenes/tasks.tscn")
var clock:float
var count:float = 0

func _process(delta: float) -> void:
	count +=delta
	if count >= 5:
		print_debug(count)
		var newTask = task.instantiate()
		newTask.on_do_task.connect(setTime)
		container.add_child(newTask)
		count = 0

func getTime():
	return game.hr

func setTime(minute):
	game.min += minute
