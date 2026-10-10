extends TextureRect

@export var backButton:TextureButton
@export var musicSlider:Setting_slot
@export var sfxSlider:Setting_slot
@export var hoverSound:AudioStreamPlayer2D
@export var pressSound:AudioStreamPlayer2D

func _ready() -> void:
	musicSlider.settingTitle.text = "music"
	sfxSlider.settingTitle.text = "sfx"
	musicSlider.busType = "Music"
	sfxSlider.busType = "SFX"
	
	musicSlider.setup()
	sfxSlider.setup()
	musicSlider.settingSlider.value_changed.connect(_on_music_changed)
	sfxSlider.settingSlider.value_changed.connect(_on_sfx_changed)

func _on_music_changed(val:float):
	print_debug(val)

func _on_sfx_changed(val:float):
	print_debug(val)

func _on_back_pressed() -> void:
	pressSound.play()
	await  pressSound.finished
	if MenuChanges.prevScene == "res://Scenes/pause_menu.tscn":
		var pauseScene = load(MenuChanges.prevScene)
		get_parent().add_child(pauseScene.instantiate())
		queue_free()
	else:
		get_tree().change_scene_to_file(MenuChanges.prevScene)

func _on_back_mouse_entered() -> void:
	hoverSound.play()
