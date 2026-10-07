extends Node
class_name EffectManager

var active_effects: Array[Enums.Effect] = []

func add_effect(new_effect: Enums.Effect, world: Main):
	match(new_effect):
		Enums.Effect.MORE_ENERGY:
			world.energy = world.energy + 50
		Enums.Effect.ZERO_ENERGY:
			var to_do_list: ToDoList = world.to_do_list
			for task in to_do_list.tasks:
				task.is_zero_energy = true
			to_do_list.detected_task_completed.connect(func(): _on_zero_energy_task_pressed(world, to_do_list))
			
		Enums.Effect.TIME_STOP:
			world.isTimeStopped = true
			world.to_do_list.enableGeneration = false
			world.to_do_list.toggle_progress.emit(false)
			world.clockCounter = 0

		Enums.Effect.INSTANT_FINNISH:
			var to_do_list: ToDoList = world.to_do_list
			print("discounting: ", to_do_list.tasks.size())
			for task in to_do_list.tasks:
				task.is_instant_finnish_task = true 
			to_do_list.detected_task_completed.connect(
				_on_instant_finnish_task_pressed.bind(to_do_list), CONNECT_ONE_SHOT
			)
		
func _on_zero_energy_task_pressed(world: Main, to_do_list: ToDoList):
	for task in to_do_list.tasks:
		task.is_zero_energy = false
	to_do_list.detected_task_completed.disconnect(func(): _on_zero_energy_task_pressed(world, to_do_list))
func _on_instant_finnish_task_pressed(_completed_task: Task, to_do_list: ToDoList):
	for task in to_do_list.tasks:
		task.is_instant_finnish_task = false
	to_do_list.detected_task_completed.disconnect(_on_instant_finnish_task_pressed)