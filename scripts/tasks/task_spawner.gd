extends TextureRect

@export var container:VBoxContainer
@export var game:Main

var task = preload("res://Scenes/tasks.tscn")
var clock:float
var count:float = 0

signal give_resources(t:int, e:int)

func _process(delta: float) -> void:
	count +=delta
	if count >= 5:
		var newTask = task.instantiate()
		newTask.on_do_task.connect(setTime)
		newTask.req_resources.connect(fillRequest)
		give_resources.connect(newTask.getResources)
		container.add_child(newTask)
		count = 0

func fillRequest():
	give_resources.emit(game.hr, game.energy)
	print_debug(game.hr, game.energy)

func setTime(minute, energy):
	game.min += minute
	game.energy += energy
	game.update_clock_and_energy()
