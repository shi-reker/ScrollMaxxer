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

func _on_progres_pressed() -> void:
	if isInstant:
		taskPBar.value += 100
	elif taskCategory == taskDetails.Category.MEDIUM:
		if taskType == taskDetails.Tags.ROUTINE:
			taskPBar.value += 100
		else:
			taskPBar.value += randi_range(30, 60)
	else:
		if taskType == taskDetails.Tags.ROUTINE:
			var randDur = randf_range(60, 90)
			var timeConsumed = (randDur/100)*taskDetails.Len
			print_debug(timeConsumed)
			taskPBar.value += 100
		else:
			taskPBar.value += randi_range(15, 30)
	
	if taskPBar.value >= 100:
		queue_free()
