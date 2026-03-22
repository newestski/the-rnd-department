extends State

class_name DeadState

var dropped_weapon: PackedScene
@export var drop_chance = 0.55

func enter():
	print("owie i died!")
	GameManager.kills += 1
	character.particle_system.set_particle("explode", true)
	if character is Character:
		if randf() < drop_chance:
			var file = load("res://scenes/box.tscn")
			var box = file.instantiate()
			box.position = character.position
			character.add_sibling(box)
		character.sprite.visible = false
		
		var timer := Timer.new()
		character.add_child(timer)
		timer.start()
		await timer.timeout
		character.queue_free()
