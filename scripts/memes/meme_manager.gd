extends VBoxContainer

var correct_meme: Meme

signal meme_selected(meme: Meme)

func _ready() -> void:
	for meme in get_children():
		if meme is Meme:
			meme.pressed.connect(_on_meme_pressed.bind(meme))

func reload_memes():
	var new_memes: Array[Enums.Meme]
	pass


func _on_meme_pressed(pressed_meme: Meme) -> void:
	print_debug(pressed_meme.meme_stats.code)
	meme_selected.emit(pressed_meme)
