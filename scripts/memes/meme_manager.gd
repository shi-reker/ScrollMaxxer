extends VBoxContainer
class_name MemeManager

var correct_meme: Meme

signal meme_selected(meme: Meme)

var leftover_memes: Array = Enums.Meme.values()
var memes_on_hand: Array[Enums.Meme] = []

func _ready() -> void:
	for meme in get_children():
		if meme is Meme:
			meme.pressed.connect(_on_meme_pressed.bind(meme))

func reload_memes(content_genre: Enums.Genre, emotion: Enums.Emo):
	print_debug("reloading memes for genre ", content_genre, " and emotion ", emotion)
	leftover_memes = Enums.Meme.values()
	memes_on_hand = []
	for meme in get_children():
		if meme is Meme:
			var new_meme_stats: MemeStats = random_meme()
			meme.meme_stats = new_meme_stats

func random_meme() -> MemeStats:
	var new_meme = leftover_memes.pick_random()
	leftover_memes.erase(new_meme)
	memes_on_hand.append(new_meme)
	var new_meme_stats: MemeStats = Enums.meme_resource[new_meme]
	return new_meme_stats
	

func _on_meme_pressed(pressed_meme: Meme) -> void:
	print_debug(pressed_meme.meme_stats.code)
	meme_selected.emit(pressed_meme)
