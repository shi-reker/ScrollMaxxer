extends GridContainer
class_name MemeManager

var correct_meme_node: Meme

signal meme_selected(meme: Meme, is_correct: bool)

var leftover_memes: Array = Enums.Meme.values()
var memes_on_hand: Array[Enums.Meme] = []
var meme_nodes: Array[Meme] = []

var rng = RandomNumberGenerator.new()
var effected_meme: Meme = null
var is_effect_exist: bool = false
var existing_effect: Enums.Effect

@export var reaction:TextureRect
@export var correctSound:AudioStreamPlayer2D
@export var incorrectSound:AudioStreamPlayer2D

func _ready() -> void:
	for meme in get_children():
		if meme is Meme:
			meme_nodes.append(meme)
			meme.pressed.connect(_on_meme_pressed.bind(meme))
	reaction.hide()

func reload_memes(content_genre: Enums.Genre, emotion: Enums.Emo):
	if meme_nodes.is_empty():
		push_error("MemeManager has no Meme children to reload.")
		return
	
	reaction.show()
	reaction.texture = emotionsTextures[emotion]
	
	leftover_memes = Enums.Meme.values()
	
	#var correct_meme: Enums.Meme = Enums.meme_of_g_and_e[content_genre][emotion].pick_random()
	var correct_meme: Enums.Meme = Enums.meme_of_g_and_e[0][0].pick_random()
	
	leftover_memes.erase(correct_meme)
	memes_on_hand = [correct_meme]
	correct_meme_node = meme_nodes.pick_random()

	for meme in meme_nodes:
		var new_meme_stats: MemeStats
		meme.hint.visible = meme == correct_meme_node
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
	existing_effect = Enums.Effect.INSTANT_FINNISH
	effected_meme = meme_nodes.pick_random()
	effected_meme.prepaire_effect(texture_of_effect[existing_effect])

func _on_meme_pressed(pressed_meme: Meme) -> void:
	meme_selected.emit(pressed_meme, pressed_meme.name == correct_meme_node.name)

var texture_of_effect: Dictionary[Enums.Effect, Texture2D] = {
	Enums.Effect.MORE_ENERGY: load("res://assets/meme effects/more energy.png"),
	Enums.Effect.ZERO_ENERGY : load("res://assets/meme effects/free energy.png"),
	Enums.Effect.TIME_STOP: load("res://assets/meme effects/time stop.png"),
	Enums.Effect.INSTANT_FINNISH: load("res://assets/meme effects/Instant Finish.png"),
}

var emotionsTextures:Dictionary[Enums.Emo, Texture2D] = {
	Enums.Emo.PLEASED: load("res://assets/temp emos/pleased temp.png"),
	Enums.Emo.FUNNY: load("res://assets/temp emos/funny temp.png"),
	Enums.Emo.SUS: load("res://assets/temp emos/sus temp.png"),
	Enums.Emo.DISGUSTED: load("res://assets/temp emos/disgusted temp.png"),
	Enums.Emo.BEWILDERED: load("res://assets/temp emos/bewildered temp.png")
}
