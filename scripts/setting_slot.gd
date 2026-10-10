extends TextureRect
class_name Setting_slot

@export var settingTitle:Label
@export var settingSlider:HSlider
@export var hoverSound:AudioStreamPlayer2D

var busType:String

func setup() -> void:
	settingSlider.value = _get_bus_volume(busType)

func _get_bus_volume(bus_name: String) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name)))

func _on_h_slider_mouse_entered() -> void:
	hoverSound.play()

func _on_h_slider_value_changed(value: float) -> void:
	_set_bus_volume(busType, value)

func _set_bus_volume(bus_name: String, value: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	AudioServer.set_bus_mute(idx, value <= 0.0)
