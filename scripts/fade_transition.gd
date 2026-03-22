extends Panel

class_name FadeTransition

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_in():
	print("fade in")
	animation_player.play("fade_in")

func fade_out():
	print("fade out")
	animation_player.play("fade_out")
