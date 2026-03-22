extends Node

var sounds_registry: Dictionary
var current_sound: AudioStreamPlayer
var sounds_start_volumes: Dictionary
var sounds_volumes_scale: Dictionary

signal music_finished

# Creates registry of sounds witch are it's children
func _ready() -> void:
	for child in get_children():
		sounds_registry.set(str(child.name).to_snake_case(), child)
	print("hello"+str(sounds_registry))
	for key in sounds_registry:
		var value = sounds_registry[key]
		sounds_start_volumes.set(value, value.volume_linear)
		sounds_volumes_scale.set(value, 1)

func find_sound(sound_name: String):
	if sounds_registry.has(sound_name): 
		var found_sound: AudioStreamPlayer = sounds_registry[sound_name]
		return found_sound
	else:
		printerr("sound of name "+str(sound_name)+" not found in sound component's registry")

func play(sound_name: String):
	var playing_sound = find_sound(sound_name)
	current_sound = playing_sound
	playing_sound.play()
	print("played sound "+str(playing_sound))
	await playing_sound.finished
	music_finished.emit()

func stop():
	if current_sound:
		current_sound.stop()
		current_sound = null 
