extends Resource
class_name Task_base

@export var Title:String
@export var Len:float
@export var Due:float
@export var cat:Category
@export var tag:Tags
@export var availability:GenTime

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

enum GenTime {
	ANY,
	MORNING,
	NOON,
	EVENING,
	NIGHT,
	M_NO,
	NO_E,
	E_NI,
	M_E
}
