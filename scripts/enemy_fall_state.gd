extends State

class_name EnemyFallState

var gravity = 980

# Called when the node enters the scene tree for the first time.
func physics_update(delta: float):
	character.velocity.y += gravity * delta
	character.sprite.animation = "air"
	
	character.move_and_slide()
	
	if character.is_on_floor():
		print("GAMING")
		state_machine.change_state("enemywalkstate")
