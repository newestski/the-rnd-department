extends State

class_name EnemyJumpState

# Called when the node enters the scene tree for the first time.
func enter():
	character.velocity.y -= 300
	character.velocity.x = character.direction * 30
	character.move_and_slide()
	state_machine.change_state("enemyfallstate")
