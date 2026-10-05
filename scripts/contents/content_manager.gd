extends ScrollContainer
class_name ContentManager

@export var content1: Content
@export var content2: Content
@export var scroll_duration: float = 0.35

@onready var content_list: VBoxContainer = $ContentList
@onready var top_content: Content = content1
@onready var btm_content: Content = content2

var leftover_content: Array = Enums.Content.values()
var content_history: Dictionary[Enums.Content, bool] = {}

signal scrolled(new_content: Content)


var is_scrolling: bool = false

func _ready() -> void:
	add_new_content(content1)
	add_new_content(content2)

func next_content() -> void:
	if is_scrolling:
		return

	is_scrolling = true
	var incoming_content := btm_content
	var outgoing_content := top_content
	var scroll_distance := roundi(outgoing_content.size.y)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scroll_vertical", scroll_distance, scroll_duration)
	await tween.finished

	content_list.move_child(outgoing_content, 1)
	scroll_vertical = 0
	top_content = incoming_content
	btm_content = outgoing_content
	is_scrolling = false
	
	add_new_content(btm_content)
	
	scrolled.emit(btm_content)

func add_new_content(content_node: Content):
	var new_content: ContentStats = random_content()
	content_node.content_stats = new_content

func random_content() -> ContentStats:
	var new_content: Enums.Content = leftover_content.pick_random()
	leftover_content.erase(new_content)
	content_history[new_content] = true
	var content_stats: ContentStats = Enums.content_resource[new_content]
	return content_stats
