extends Node2D

var score: int = 0
var emotion: Enums.Emo = Enums.Emo.LIKE

var score_add: int = 100

@export var cur_content: Content
@export var content_manager: ContentManager

func _on_meme_manager_meme_selected(meme: Meme) -> void:
	if meme.meme_stats.emo == emotion and meme.meme_stats.genre == cur_content.content_stats.genre:
		score += score_add
		print_debug("score is", score)
		correct_meme_animations()
	else:
		wrong_meme_animations()
	content_manager.next_content()

func update_score():
	score += score_add
	print("score is ", score)

func correct_meme_animations():
	pass

func wrong_meme_animations():
	pass

func _on_content_manager_scrolled(new_content: Content) -> void:
	pass # Replace with function body.
