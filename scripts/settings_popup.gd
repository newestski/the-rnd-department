extends PanelContainer

@onready var exit_button: Button = $Control/ExitButton
@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer/MusicSlider
@onready var sound_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer2/SoundSlider

var master_bus_index
var music_bus_index
var sfx_bus_index

func _ready():
	master_bus_index = AudioServer.get_bus_index("Master")
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	
	music_slider.value = AudioServer.get_bus_volume_linear(music_bus_index)
	sound_slider.value = AudioServer.get_bus_volume_linear(sfx_bus_index)

func _on_sound_slider_drag_ended(_value_changed: bool) -> void:
	var volume_db = linear_to_db(sound_slider.value)
	AudioServer.set_bus_volume_db(sfx_bus_index, volume_db)

func _on_music_slider_drag_ended(_value_changed: bool) -> void:
	var volume_db = linear_to_db(music_slider.value)
	AudioServer.set_bus_volume_db(music_bus_index, volume_db)

func _on_exit_button_pressed() -> void:
	visible = false


func _on_resolution_button_item_selected(index: int) -> void:
	if index == 0:
		get_tree().root.content_scale_factor = 1
		get_tree().root.size = Vector2i(480, 240)
		get_tree().root.content_scale_size = Vector2i(480, 240)
	elif index == 1:
		get_tree().root.content_scale_factor = 2
		get_tree().root.size = Vector2i(960, 480)
		get_tree().root.content_scale_size = Vector2i(960, 480)
	elif index == 2:
		get_tree().root.content_scale_factor = 3
		get_tree().root.size = Vector2i(1440, 720)
		get_tree().root.content_scale_size = Vector2i(1440, 720)
	elif index == 3:
		get_tree().root.content_scale_factor = 4
		get_tree().root.size = Vector2i(1920, 960)
		get_tree().root.content_scale_size = Vector2i(1920, 960)
	
