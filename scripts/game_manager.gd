extends Node

signal game_fail_signal

var player: Player
var main_ui: Control
var fade_transition: FadeTransition

var points: int = 0
var kills: int = 0
var scene_start_time: float = 0
var epic_chance: float = 1

func _ready() -> void:
	get_tree().scene_changed.connect(setup)
	setup.call_deferred()
	scene_start_time = Time.get_ticks_msec()

func get_scene_time():
	return Time.get_ticks_msec()-scene_start_time

func setup():
	main_ui = get_tree().get_first_node_in_group("main_ui")
	player = get_tree().get_first_node_in_group("player")
	fade_transition = get_tree().get_first_node_in_group("fade_transition")
	
	var root_node: Node = get_tree().current_scene
	if root_node.name == "MainMenu":
		get_tree().paused = false
		fade_transition.fade_in()
		
		MusicManager.stop.call_deferred()
		MusicManager.play.call_deferred("menu_loop")
	else:
		MusicManager.stop()
		
		#set up health bar
		player.health_component.damaged.connect(on_player_damage)
		main_ui.health_bar.update_health(player.health_component.health, player.health_component.max_health)
		
		#do intro animation
		fade_transition.fade_in()
		main_ui.get_node("CoolText/AnimationPlayer").play("cool_text")
		await main_ui.get_node("CoolText/AnimationPlayer").current_animation_changed
		
		#play music
		MusicManager.play("danger_loop_1")


func change_scene(scene_name: String):
	fade_transition.fade_out()
	await fade_transition.animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/levels/"+str(scene_name)+".tscn")

func on_player_damage(_health, _damage):
	main_ui.health_bar.update_health(player.health_component.health)

func game_fail():
	print("game fail")
	get_tree().paused = true
	MusicManager.stop()
	game_fail_signal.emit()
	player.sound_component.play("die_sound")
