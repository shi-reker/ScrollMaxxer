extends TextureRect
class_name Task

@export var taskTitle:Label
@export var taskDue:Label
@export var taskPBar:TextureProgressBar
@export var taskPNum:Label
@export var taskPDur:Label
@export var taskPCost:Label
var taskDetails:Task_base
var taskCategory:Task_base.Category
var taskType:Task_base.Tags
var isInstant:bool = false
var energy:int
var time:int

signal req_resources()
signal on_do_task(time:int, energy:int)

func _ready() -> void:
	taskDetails = load("res://resources/tasks/Sleep_res.tres")
	taskTitle.text = str(taskDetails.Title)
	if taskDetails.Due < 60:
		taskDue.text = str(taskDetails.Due)+ "MINUTES"
	else:
		taskDue.text = str(taskDetails.Due/60)+ "HR"
	
	if taskDetails.Len < 60:
		taskPDur.text = str(taskDetails.Len)+ "minutes"
		taskPCost.text = "5e"
		isInstant = true
	elif taskDetails.Len < 240:
		taskPDur.text = "2hr"
		taskPCost.text = "15e"
	else:
		taskPDur.text = "4hr"
		taskPCost.text = "25e"
	
	taskCategory = taskDetails.cat
	taskType = taskDetails.tag
	taskPBar.min_value = 0
	taskPBar.max_value = 100
	taskPBar.value = 0
	taskPNum.text = "0"

func getResources(t:int, e:int):
	time = t
	energy = e

func _on_progres_pressed() -> void:
	req_resources.emit()
	if energy < 5:
		return
	
	var timeConsumed:int
	var energyConsumed:int
	
	if isInstant:
		taskPBar.value += 100
		timeConsumed = int(taskDetails.Len)
		energyConsumed = 5
	elif taskCategory == taskDetails.Category.MEDIUM:
		if energy < 15:
			return
		if taskType == taskDetails.Tags.ROUTINE:
			taskPBar.value += 100
		else:
			taskPBar.value += randi_range(30, 60)
		timeConsumed = 120
		energyConsumed = 15
	else:
		if energy < 25:
			return
		if taskType == taskDetails.Tags.ROUTINE:
			var randDur = randf_range(70, 90)
			timeConsumed = int((randDur/100)*taskDetails.Len)
			taskPBar.value += 100
		else:
			taskPBar.value += randi_range(15, 30)
			timeConsumed = 4
		energyConsumed = 25
	
	on_do_task.emit(timeConsumed, energyConsumed)
	
	if taskPBar.value >= 100:
		queue_free()
