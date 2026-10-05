extends Resource
class_name Task_base

@export var Title:String
@export var Len:float
@export var Due:float
@export var cat:Category
@export var tag:Tags

enum Category {
	SHORT,
	MEDIUM,
	LONG
}

enum Tags {
	CHORE,
	ROUTINE,
	ASSIGNMENT,
	RANDOM_EVENT,
	REST
}
