extends ScrollContainer

@onready var content1: Content = $VBoxContainer/Content
@onready var top_content: Content = content1
@onready var content2: Content = $VBoxContainer/Content2
@onready var btm_content: Content = content2

signal scrolled(new_content: Content)

func next_content():
	
	# btm_content is moved up

	var temp_content_ptr = btm_content
	btm_content = top_content
	top_content = temp_content_ptr
	
	#btm_content gets new resource
	
	scrolled.emit(btm_content)

func scroll_animation():
	pass

func switch_content(content_node: Content):
	pass
