extends TextureRect
class_name Task

@export var taskTitle:Label
@export var taskDue:Label
@export var taskPBar:TextureProgressBar
@export var taskPNum:Label
@export var taskPDur:Label
@export var taskPCost:Label
@export var freeTex:TextureRect

var taskDetails:Task_base
var taskCategory:Task_base.Category
var taskType:Task_base.Tags
var energy:int
var time:int
var startTime:int
var currDay:int
var startDay:int

@onready var is_zero_energy: bool = false:
	set(value):
		is_zero_energy = value
		if value == true:
			freeTex.show()
		else :
			freeTex.hide()

signal req_resources()
signal on_do_task(tc:int, ec:int)
signal task_completed(task: Task)

func printDue(due):
	if due < 60:
		taskDue.text = "%.1f MINUTES" % (due)
	else:
		taskDue.text = "%.1f HR" % (due/60)

func GetResources(t:int, e:int, d:int):
	time = t
	energy = e
	currDay = d

func Setup(task:String):
	taskDetails = load(task)
	taskTitle.text = str(taskDetails.Title)
	printDue(taskDetails.Due)
	
	if taskDetails.Len <= 60:
		taskPDur.text = str(int(taskDetails.Len))+ "minutes"
		taskPCost.text = "5e"
		texture = load("res://assets/UI/task bg short.png")
	elif taskDetails.Len <= 240:
		taskPDur.text = "2hr"
		taskPCost.text = "15e"
		texture = load("res://assets/UI/task bg medium.png")
	else:
		taskPDur.text = "4hr"
		taskPCost.text = "25e"
		texture = load("res://assets/UI/tasks bg long.png")
	
	taskCategory = taskDetails.cat
	taskType = taskDetails.tag
	taskPBar.min_value = 0
	taskPBar.max_value = 100
	taskPBar.value = 0
	taskPNum.text = "0"
	req_resources.emit()
	startTime = time
	startDay = currDay
	#print_debug(startTime)
	#print_debug(taskDetails.Due)
	#print_debug((startTime+taskDetails.Due)/60)

func ResolveTaskShort():
	if energy < 5:
		return
	taskPBar.value += 100
	
	return [5, int(taskDetails.Len)]

func ResolveTaskMed():
	if energy < 15:
		return
	if taskType == taskDetails.Tags.ROUTINE or taskType == taskDetails.Tags.RANDOM_EVENT:
		taskPBar.value += 100
	else:
		taskPBar.value += randi_range(35, 70)
	
	return [15, 120]

func ResolveTaskLong():
	var tc
	
	if energy < 25:
		return
	if taskType == taskDetails.Tags.ROUTINE or taskType == taskDetails.Tags.RANDOM_EVENT:
		var randDur = randf_range(70, 90)
		tc = int((randDur/100)*taskDetails.Len)
		taskPBar.value += 100
	else:
		taskPBar.value += randi_range(15, 30)
		tc = 240
	
	return [25, tc]

func _on_progres_pressed() -> void:
	if is_zero_energy:
		complete_task()
	
	req_resources.emit()
	
	var timeConsumed:int
	var energyConsumed:int
	
	if taskType == taskDetails.Tags.REST:
		#print_debug("rest")
		match taskCategory:
			taskDetails.Category.MEDIUM:
				timeConsumed = 120
				energyConsumed = -25
				taskPBar.value += 100
			
			taskDetails.Category.LONG:
				var randDur = randf_range(70, 90)
				timeConsumed = int((randDur/100)*taskDetails.Len)
				energyConsumed = -75
				taskPBar.value += 100
	else:
		#print_debug("not rest")
		var consumption
		match taskCategory:
			taskDetails.Category.SHORT:
				consumption = ResolveTaskShort()
				#print_debug("short")
			
			taskDetails.Category.MEDIUM:
				consumption = ResolveTaskMed()
				#print_debug("med")
			
			taskDetails.Category.LONG:
				consumption = ResolveTaskLong()
				#print_debug("long")
		
		print_debug(energy)
		if !consumption:
			#print_debug("fuck")
			return
		energyConsumed = consumption[0]
		timeConsumed = consumption[1]
	
	on_do_task.emit(timeConsumed, energyConsumed)
	
	if taskPBar.value >= 100:
		complete_task()

func complete_task():
	task_completed.emit(self)
	complete_animation()
	queue_free()

func complete_animation():
	pass

func DueTimerTick(hr:int):
	#if taskDetails.Due > 1440:
	
	if startTime + taskDetails.Due <= hr:
		#print_debug(taskDetails.Title+": "+str(startTime)+", "+ str(taskDetails.Due) +", "+ str(hr))
		queue_free()
	else:
		
		printDue(((taskDetails.Due + startTime) - hr))
