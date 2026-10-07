extends VBoxContainer
class_name MemeManager

var correct_meme_node: Meme

signal meme_selected(meme: Meme)

var leftover_memes: Array = Enums.Meme.values()
var memes_on_hand: Array[Enums.Meme] = []
var meme_nodes: Array[Meme] = []

var rng = RandomNumberGenerator.new()
var effected_meme: Meme = null
var is_effect_exist: bool = false
var existing_effect: Enums.Effect

func _ready() -> void:
	for meme in get_children():
		if meme is Meme:
			meme_nodes.append(meme)
			meme.pressed.connect(_on_meme_pressed.bind(meme))

func reload_memes(content_genre: Enums.Genre, emotion: Enums.Emo):
	print_debug("reloading memes for genre ", content_genre, " and emotion ", emotion)	
	leftover_memes = Enums.Meme.values()
	
	print(Enums.Emo.find_key(emotion), Enums.Genre.find_key(content_genre))
	#var correct_meme: Enums.Meme = Enums.meme_of_g_and_e[content_genre][emotion].pick_random()
	var correct_meme: Enums.Meme = Enums.meme_of_g_and_e[0][0].pick_random()
	print("correct meme is")
	
	leftover_memes.erase(correct_meme)
	memes_on_hand = [correct_meme]
	correct_meme_node = meme_nodes.pick_random()
	print("correct meme is ",correct_meme_node.name)
	for meme in meme_nodes:
		var new_meme_stats: MemeStats
		if meme == correct_meme_node:
			new_meme_stats = Enums.meme_resource[correct_meme]
		else:
			new_meme_stats = random_meme()
		meme.meme_stats = new_meme_stats
	
	add_random_effect()

func random_meme() -> MemeStats:
	var new_meme = leftover_memes.pick_random()
	leftover_memes.erase(new_meme)
	memes_on_hand.append(new_meme)
	var new_meme_stats: MemeStats = Enums.meme_resource[new_meme]
	return new_meme_stats

func generate_correct_meme(content_genre: Enums.Genre, emotion: Enums.Emo) -> Enums.Meme:
	var candidates: Array[Enums.Meme] = Enums.meme_of_g_and_e[content_genre][emotion]
	return candidates.pick_random()
	
func add_random_effect():
	if effected_meme != null:
		effected_meme.remove_effect()
	if 0 == (randi() % 2):
		is_effect_exist = false
		return
	is_effect_exist = true
	existing_effect = Enums.Effect.values().pick_random()
	existing_effect = Enums.Effect.ZERO_ENERGY
	effected_meme = meme_nodes.pick_random()
	effected_meme.prepaire_effect(texture_of_effect[existing_effect])
	
	
	
func _on_meme_pressed(pressed_meme: Meme) -> void:
	print_debug(pressed_meme.meme_stats.code)
	meme_selected.emit(pressed_meme)

var texture_of_effect: Dictionary[Enums.Effect, Texture2D] = {
	Enums.Effect.MORE_ENERGY: load("res://assets/temp_effect_sprite.tres"),
	Enums.Effect.ZERO_ENERGY : load("res://assets/temp_effect_sprite.tres"),
	Enums.Effect.TIME_STOP: load("res://assets/temp_effect_sprite.tres"),
	Enums.Effect.FINNISH_TASK: load("res://assets/temp_effect_sprite.tres"),
}
