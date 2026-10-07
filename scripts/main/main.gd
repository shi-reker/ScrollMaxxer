extends Node2D
class_name Main

var min:int = 0
var hr:int = 6
var day:int = 1
var clockCounter:float = 0
var score: int = 0:
	set(value):
		score = value
		update_score(value)
var energy:int = 100:
	set(value):
		value = clamp(value, 0, 100)
		energy = value
		energyBar.update_energy_counter(value)

var score_add: int = 100
@onready var emotion: Enums.Emo = Enums.Emo.values().pick_random()

signal hourhand(t:int)
var isTimeStopped:bool = false
var combo: int = 0: 
	set(value):
		if value < combo:
			combo_counter.increase_animation(value)
		else:
			combo_counter.decrease_animation(value)
		combo = value

@export var cur_content: Content
@export var content_manager: ContentManager
@export var meme_manager: MemeManager
@export var clock:Label
@export var energyBar:EnergyBar
@export var combo_counter: ComboCounter
@export var effect_manager: EffectManager
@export var pause:TextureButton
@export var scoreBoard:Label
@export var to_do_list: ToDoList

func _ready() -> void:
	energy = energy
	scoreBoard.text = "score: "+str(score)

func _process(delta: float) -> void:
	if !isTimeStopped:
		if clockCounter >= 0.5:
			min+=1
			update_clock_and_energy()
			clockCounter = 0
		clockCounter += delta
	else:
		if clockCounter >= 3:
			isTimeStopped = false
			clockCounter = 0
			to_do_list.enableGeneration = true
			to_do_list.toggle_progress.emit(true)
		clockCounter += delta

func _on_meme_manager_meme_selected(meme: Meme, is_correct: bool) -> void:
	if is_correct:
		combo = combo + 1
		score = score + score_add * combo
		correct_meme_animations()
	else:
		combo = combo / 2
		print_debug("wrong")
		wrong_meme_animations()
	
	if meme_manager.is_effect_exist and meme_manager.effected_meme == meme:
		meme_manager.is_effect_exist = false
		var effect: Enums.Effect = meme_manager.existing_effect
		effect_manager.add_effect(effect, self)
		
	content_manager.next_content()

func update_score(score: int):
	scoreBoard.text = "score: " +str(score)

func update_clock_and_energy():
	while min >= 60:
		hr+=1
		min -= 60
		hourhand.emit(1)
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

func _on_pause_button_pressed() -> void:
	MenuChanges.dateNtime = [day, hr, min]
	MenuChanges.playerScore = score
	
	var pauseLayer = CanvasLayer.new()
	pauseLayer.process_mode = PROCESS_MODE_ALWAYS
	var pauseScene = load("res://Scenes/pause_menu.tscn")
	var pauseMenu = pauseScene.instantiate()
	pauseLayer.add_child(pauseMenu)
	get_tree().root.add_child(pauseLayer)
	get_tree().paused = true
