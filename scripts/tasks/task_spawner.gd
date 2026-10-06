extends TextureRect

@export var container:VBoxContainer
@export var scoller:ScrollContainer
@export var game:Main

var task = preload("res://Scenes/tasks.tscn")
var count:float = 0

signal give_resources(t:int, e:int)

var taskVariants:Dictionary[Task_base.Tags, Array] = {
	Task_base.Tags.CHORE: [
		"res://resources/tasks/chore/Cleanup_res.tres", "res://resources/tasks/chore/Dishes_res.tres"
	],
	Task_base.Tags.ROUTINE: [
		"res://resources/tasks/routine/Gotoclass_res.tres", "res://resources/tasks/routine/Shower_res.tres"
	],
	Task_base.Tags.ASSIGNMENT: [
		"res://resources/tasks/assignment/GroupP1_res.tres", "res://resources/tasks/assignment/GroupP2_res.tres", 
		"res://resources/tasks/assignment/GroupP3_res.tres", "res://resources/tasks/assignment/GroupP4_res.tres"
	],
	Task_base.Tags.RANDOM_EVENT: [
		"res://resources/tasks/random event/FriendInv1_res.tres", "res://resources/tasks/random event/Funeral_res.tres"
	],
	Task_base.Tags.REST: [
		"res://resources/tasks/rest/Sleep_res.tres", "res://resources/tasks/rest/Nap_res.tres"
	]
}

func _ready() -> void:
	scoller.clip_contents = true

func _process(delta: float) -> void:
	count +=delta
	if count >= 5:
		GenerateTask()
		count = 0

func FillRequest():
	give_resources.emit(game.hr, game.energy)

func SetTime(minute, energy):
	game.min += minute
	game.energy -= energy
	game.update_clock_and_energy()

func GenerateTask():
	var taskType
	var selection
	if game.hr < 6 or game.hr >= 18:
		print_debug(1)
		selection = [0, 2, 4]
		taskType = taskVariants[selection.pick_random()].pick_random()
	elif game.hr < 12:
		print_debug(2)
		taskType = taskVariants[randi_range(0, 3)].pick_random()
	elif game.hr < 18:
		print_debug(3)
		taskType = taskVariants[randi_range(0, 4)].pick_random()
	
	print_debug(taskType)
	var newTask = task.instantiate()
	newTask.Setup(taskType)
	newTask.on_do_task.connect(SetTime)
	newTask.req_resources.connect(FillRequest)
	give_resources.connect(newTask.GetResources)
	container.add_child(newTask)
