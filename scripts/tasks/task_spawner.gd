extends TextureRect
class_name ToDoList

@export var container:VBoxContainer
@export var scoller:ScrollContainer
@export var game:Main

var tasks: Array[Task]
var task = preload("res://Scenes/tasks.tscn")
var count:float = 0
var enableGeneration:bool = true
var blacklist:Array[Task_base.Tags]

var tasksByTime:Dictionary[Task_base.GenTime, Array] = {
	Task_base.GenTime.ANY: [
		"res://resources/tasks/chore/Cleanup_res.tres", "res://resources/tasks/chore/Dishes_res.tres",
		"res://resources/tasks/routine/Goon_res.tres"
	],
	Task_base.GenTime.MORNING: [
		"res://resources/tasks/assignment/GroupP2_res.tres", "res://resources/tasks/routine/Breakfast_res.tres"
	],
	Task_base.GenTime.NOON: [
		"res://resources/tasks/rest/Nap_res.tres", "res://resources/tasks/assignment/GroupP1_res.tres"
	],
	Task_base.GenTime.EVENING: [
		"res://resources/tasks/random event/EatOut_res.tres", "res://resources/tasks/rest/Sunset_res.tres"
	],
	Task_base.GenTime.NIGHT: [
		"res://resources/tasks/random event/DrinkHangover_res.tres", "res://resources/tasks/random event/HorrorMovie_res.tres"
	],
	Task_base.GenTime.M_NO: [
		"res://resources/tasks/random event/Funeral_res.tres", "res://resources/tasks/assignment/GroupP3_res.tres",
		"res://resources/tasks/routine/Gotoclass_res.tres", "res://resources/tasks/assignment/GroupP4_res.tres"
	],
	Task_base.GenTime.NO_E: [
		"res://resources/tasks/random event/FriendInv1_res.tres", "res://resources/tasks/routine/Study_res.tres"
	],
	Task_base.GenTime.E_NI: [
		"res://resources/tasks/rest/Sleep_res.tres", "res://resources/tasks/random event/CNA_res.tres",
		"res://resources/tasks/random event/YTVidEssay_res.tres"
	],
	Task_base.GenTime.M_E: [
		"res://resources/tasks/routine/Shower_res.tres", "res://resources/tasks/random event/AuraFarm_res.tres",
		"res://resources/tasks/chore/Groceries_res.tres"
	],
}

var taskTagsByTime:Dictionary[Task_base.GenTime, Array] = {
	Task_base.GenTime.ANY: [
		Task_base.Tags.CHORE, Task_base.Tags.CHORE,
		Task_base.Tags.ROUTINE
	],
	Task_base.GenTime.MORNING: [
		Task_base.Tags.ASSIGNMENT, Task_base.Tags.ROUTINE
	],
	Task_base.GenTime.NOON: [
		Task_base.Tags.REST, Task_base.Tags.ASSIGNMENT
	],
	Task_base.GenTime.EVENING: [
		Task_base.Tags.RANDOM_EVENT, Task_base.Tags.REST
	],
	Task_base.GenTime.NIGHT: [
		Task_base.Tags.RANDOM_EVENT, Task_base.Tags.RANDOM_EVENT
	],
	Task_base.GenTime.M_NO: [
		Task_base.Tags.RANDOM_EVENT, Task_base.Tags.ASSIGNMENT,
		Task_base.Tags.ROUTINE, Task_base.Tags.ASSIGNMENT
	],
	Task_base.GenTime.NO_E: [
		Task_base.Tags.RANDOM_EVENT, Task_base.Tags.ROUTINE
	],
	Task_base.GenTime.E_NI: [
		Task_base.Tags.REST, Task_base.Tags.RANDOM_EVENT,
		Task_base.Tags.RANDOM_EVENT
	],
	Task_base.GenTime.M_E: [
		Task_base.Tags.ROUTINE, Task_base.Tags.RANDOM_EVENT,
		Task_base.Tags.CHORE
	],
}

var taskTagCounter:Dictionary[Task_base.Tags, int] = {
	Task_base.Tags.CHORE: 0,
	Task_base.Tags.ROUTINE: 0,
	Task_base.Tags.ASSIGNMENT: 0,
	Task_base.Tags.RANDOM_EVENT: 0,
	Task_base.Tags.REST: 0
}

signal give_resources(t:int, e:int)
signal tickdown_hr(h:int)
signal detected_task_completed(task: Task)
signal toggle_progress(state:bool)

func _ready() -> void:
	scoller.clip_contents = true
	game.hourhand.connect(HourTick)

func _process(delta: float) -> void:
	if enableGeneration:
		count +=delta
		if count >= 5:
			GenerateTask()
			count = 0

func FillRequest():
	give_resources.emit((game.hr*60)+game.min, game.energy)

func SetTime(minute, energy):
	game.min += minute
	game.energy -= energy
	game.update_clock_and_energy()
	TaskBlacklistCheck()

func GenerateTask():
	if blacklist.size() >= Task_base.Tags.size():
		return
	
	var taskType
	var selection
	var a = 0
	
	if game.hr < 6 or game.hr >= 20:
		selection = [Task_base.GenTime.ANY, Task_base.GenTime.NIGHT, Task_base.GenTime.E_NI]
	elif game.hr < 11:
		selection = [Task_base.GenTime.ANY, Task_base.GenTime.MORNING, Task_base.GenTime.M_NO, Task_base.GenTime.M_E]
	elif game.hr < 16:
		selection = [Task_base.GenTime.ANY, Task_base.GenTime.NOON, Task_base.GenTime.M_NO, Task_base.GenTime.NO_E]
	else:
		selection = [Task_base.GenTime.ANY, Task_base.GenTime.EVENING, Task_base.GenTime.E_NI]
	
	while a == 0:
		var selected = selection.pick_random()
		var timeFrame:Array = tasksByTime[selected]
		if !timeFrame.is_empty():
			taskType = timeFrame.pick_random()
			var idx = timeFrame.find(taskType)
			if !blacklist.has(taskTagsByTime[selected][idx]):
				a = 1
	
	#print_debug(taskType)
	var newTask: Task = task.instantiate() as Task
	
	newTask.on_do_task.connect(SetTime)
	newTask.req_resources.connect(FillRequest)
	newTask.task_completed.connect(_on_task_completed)
	newTask.task_expired.connect(_on_task_expire)
	newTask.tree_exiting.connect(_on_task_exiting.bind(newTask))
	
	give_resources.connect(newTask.GetResources)
	tickdown_hr.connect(newTask.DueTimerTick)
	toggle_progress.connect(newTask.toggle_progressabilty)
	
	newTask.Setup(taskType)
	container.add_child(newTask)
	tasks.append(newTask)
	taskTagCounter[newTask.taskType] += 1
	TaskBlacklistCheck()

func TaskBlacklistCheck():
	blacklist.clear()
	
	if game.energy <= 10:
		blacklist.append(Task_base.Tags.CHORE)
		blacklist.append(Task_base.Tags.ROUTINE)
		blacklist.append(Task_base.Tags.ASSIGNMENT)
		blacklist.append(Task_base.Tags.RANDOM_EVENT)
		
		if taskTagCounter[Task_base.Tags.REST] > 2:
			blacklist.append(Task_base.Tags.REST)
		
		return
	
	if taskTagCounter[Task_base.Tags.REST] > 2:
		blacklist.append(Task_base.Tags.REST)
	else:
		blacklist.erase(Task_base.Tags.REST)
	
	if taskTagCounter[Task_base.Tags.CHORE] > 3:
		blacklist.append(Task_base.Tags.CHORE)
	else:
		blacklist.erase(Task_base.Tags.CHORE)
	
	if taskTagCounter[Task_base.Tags.ASSIGNMENT] > 5:
		blacklist.append(Task_base.Tags.ASSIGNMENT)
	else:
		blacklist.erase(Task_base.Tags.ASSIGNMENT)
	
	if taskTagCounter[Task_base.Tags.RANDOM_EVENT] > 5:
		blacklist.append(Task_base.Tags.RANDOM_EVENT)
	else:
		blacklist.erase(Task_base.Tags.RANDOM_EVENT)
	
	if taskTagCounter[Task_base.Tags.ROUTINE] > 3:
		blacklist.append(Task_base.Tags.ROUTINE)
	else:
		blacklist.erase(Task_base.Tags.ROUTINE)

func _on_task_completed(completedTask: Task):
	game.score += int(completedTask.taskDetails.Len)
	game.combo /=2
	detected_task_completed.emit(completedTask)

func _on_task_expire(expiredTask:Task):
	game.score -= int(expiredTask.taskDetails.Len)
	game.combo /=2

func _on_task_exiting(exiting_task: Task):
	tasks.erase(exiting_task)
	taskTagCounter[exiting_task.taskType] -= 1

func HourTick(h:int):
	tickdown_hr.emit(h)
