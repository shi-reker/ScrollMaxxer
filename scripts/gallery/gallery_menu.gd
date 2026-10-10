extends TextureRect

@export var backButton:TextureButton
@export var hoverSound:AudioStreamPlayer2D
@export var pressSound:AudioStreamPlayer2D

@export var gallery_item_container: HFlowContainer

@onready var gallery_item_scene = preload("res://Scenes/gallery_item.tscn")

func _ready() -> void:
	for child in gallery_item_container.get_children():
		child.queue_free()
	for content in Enums.content_resource.keys():
		generate_content_card(content, Enums.content_resource[content])
	
	for meme in Enums.meme_resource.keys():
		generate_meme_card(meme, Enums.meme_resource[meme])
	
func generate_content_card(_content: Enums.Content, res: ContentStats):
	var gallery_item: GalleryItem = gallery_item_scene.instantiate() as GalleryItem
	gallery_item.res = res
	gallery_item_container.add_child(gallery_item)

func generate_meme_card(_meme: Enums.Meme, res: MemeStats):
	var gallery_item: GalleryItem = gallery_item_scene.instantiate() as GalleryItem
	gallery_item.res = res
	gallery_item_container.add_child(gallery_item)


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
