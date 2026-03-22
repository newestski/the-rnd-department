extends Node2D

class_name SoundComponent

var sounds_registry: Dictionary
var looping_sounds: Dictionary
var sounds_start_volumes: Dictionary
var sounds_volumes_scale: Dictionary


# Creates registry of sounds witch are it's children
func _ready() -> void:
	for child in get_children():
		sounds_registry.set(str(child.name).to_snake_case(), child)
	for key in sounds_registry:
		var value = sounds_registry[key]
		sounds_start_volumes.set(value, value.volume_linear)
		sounds_volumes_scale.set(value, 1)

func find_sound(sound_name: String):
	if sounds_registry.has(sound_name):
		var found_sound: AudioStreamPlayer2D = sounds_registry[sound_name]
		return found_sound
	else:
		printerr("sound of name "+str(sound_name)+" not found in sound component's registry")

func play(sound_name: String, random_pitch: float = 1):
	var playing_sound = find_sound(sound_name)
	playing_sound.pitch_scale = randf_range(1, random_pitch)
	playing_sound.play()

func scale_sound_volume(sound_name: String, volume_scale: float):
	var playing_sound = find_sound(sound_name)
	sounds_volumes_scale.set(playing_sound, volume_scale)
	playing_sound.volume_linear = sounds_volumes_scale[playing_sound] * sounds_start_volumes[playing_sound]

func play_looped(sound_name: String, loop_speed: float = 0, random_pitch: float = 1):
	var playing_sound = find_sound(sound_name)
	looping_sounds.set(playing_sound, loop_speed)
	var timer = Timer.new()
	add_child(timer)
	var wait_time: float = looping_sounds[playing_sound]
	while looping_sounds.has(playing_sound):
		playing_sound.pitch_scale = randf_range(1, random_pitch)
		playing_sound.play()
		timer.start(wait_time)
		if loop_speed != 0:
			await timer.timeout
		else: 
			await playing_sound.finished

func stop_loop(sound_name: String):
	var playing_sound = find_sound(sound_name)
	looping_sounds.erase(playing_sound)

func stop(sound_name):
	var playing_sound = find_sound(sound_name)
	playing_sound.stop()
