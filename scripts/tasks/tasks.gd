extends TextureRect
class_name Task

@export var taskTitle:Label
@export var taskDue:Label
@export var taskPBar:TextureProgressBar
@export var taskPNum:Label
@export var taskPDur:Label
@export var taskPCost:Label
#@export var taskPButton:TextureButton
var taskDetails:Task_base
var isInstant:bool = true

func _ready() -> void:
	taskDetails = load("res://resources/tasks/Sleep_res.tres")
	var tt = taskDetails.taskTitle
	var tl = str(taskDetails.taskLen/60)
	taskTitle.text = tt + " [" + tl +"hr]"
	taskDue.text = str(taskDetails.taskDue)
	taskPNum.text = "0"
	if taskDetails.taskLen < 60:
		taskPDur.text = "1hr"
	else:
		taskPDur.text = "1-2hr"
		isInstant = false
	taskPCost.text = "5e"
	taskPBar.min_value = 0
	taskPBar.max_value = 100
	taskPBar.value = 0

func _on_progres_pressed() -> void:
	if isInstant:
		taskPBar.value += 100
	else:
		var randDur = randi_range(60, 120)
		taskPBar.value += 100 - (((taskDetails.taskLen - randDur)/taskDetails.taskLen)*100)
	
	if taskPBar.value == 100:
		queue_free()
