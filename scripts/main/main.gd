extends Node2D
class_name Main

var min:int = 0
var hr:int = 23
var day:int = 1
var clockCounter:float = 0
var score: int = 0
var energy:int = 100:
	set(value):
		value = clamp(value, 0, 100)
		energy = value
		energyBar.update_energy_counter(value)

@onready var emotion: Enums.Emo = Enums.Emo.values().pick_random()

var score_add: int = 100

@export var cur_content: Content
@export var content_manager: ContentManager
@export var meme_manager: MemeManager
@export var clock:Label
@export var energyBar:EnergyBar

func _process(delta: float) -> void:
	if clockCounter >= 0.5:
		min+=1
		update_clock_and_energy()
		clockCounter = 0
	clockCounter += delta

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

func update_clock_and_energy():
	while min >= 60:
		hr+=1
		min -= 60
	while hr >= 24:
		day +=1
		hr -= 24
	var strMin:String = str(min)
	var strHR:String = str(hr)
	if min < 10:
		strMin = "0" +str(min)
	if hr < 10:
		strHR = "0" +str(hr)
	
	clock.text = "D" +str(day)+ " - " +strHR+ ":" +strMin

func correct_meme_animations():
	pass

func wrong_meme_animations():
	pass

func _on_content_manager_scrolled(new_content: Content) -> void:
	var content_genre: Enums.Genre = new_content.content_stats.genre
	print_debug("new content genre is ", content_genre)
	meme_manager.reload_memes(content_genre, emotion)
