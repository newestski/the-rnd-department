extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_points: Label = $CenterContainer/PanelContainer/VBoxContainer/LabelPoints
@onready var label_kills: Label = $CenterContainer/PanelContainer/VBoxContainer/LabelKills
@onready var label_time: Label = $CenterContainer/PanelContainer/VBoxContainer/LabelTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_fail_signal.connect(on_game_fail)

func on_game_fail():
	animation_player.play("open")
	label_points.text = "Points - "+str(GameManager.points)
	label_kills.text = "Kills - "+str(GameManager.kills)
	label_time.text = "Time - "+str(format_as_mm_ss_mmmm(GameManager.get_scene_time()))

func format_as_mm_ss_mmmm(t: float):
	var milliseconds: String = str(floori(t)%1000)
	if len(milliseconds) == 1:
		milliseconds.insert(0, "00")
	elif len(milliseconds) == 2:
		milliseconds = milliseconds.insert(0, "0")
	
	var seconds: String = str(floori(t/1000)%60)
	if len(seconds) == 1:
		seconds = seconds.insert(0, "0")
	var minutes: String = str(floori(t/60000))
	return str(minutes) + ":" + str(seconds) + "." + str(milliseconds)
