extends TextureRect

@export var container:VBoxContainer

var task = preload("res://Scenes/tasks.tscn")
var count:float = 0

func _process(delta: float) -> void:
	count +=delta
	if count >= 5:
		print_debug(count)
		var newTask = task.instantiate()
		container.add_child(newTask)
		count = 0
