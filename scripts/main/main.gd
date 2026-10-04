extends Node2D

var score: int = 0
var emotion: Enums.Emo = Enums.Emo.LIKE

var score_add: int = 100

@onready var cur_content: Content = $"BG layer/UI layer/ContentManager/VBoxContainer/Content"

func _on_meme_manager_meme_selected(meme: Meme) -> void:
	if meme.meme_stats.emo == emotion and  meme.meme_stats.genre == cur_content.content_stats.genre:
		score += score_add
		print_debug("score is", score)
		correct_meme_animations()
	else:
		wrong_meme_animations()
func correct_meme_animations():
	pass

func wrong_meme_animations():
	pass
