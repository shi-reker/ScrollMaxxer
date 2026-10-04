extends TextureRect

@export var container:VBoxContainer

var task = preload("res://Scenes/tasks.tscn")
var count:float = 0

func _process(delta: float) -> void:
	count +=delta
	print_debug(count)
	if count >= 5:
		var newTask = task.instantiate()
		container.add_child(newTask)
		count = 0
