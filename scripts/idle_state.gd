extends State

class_name IdleState

func enter():
	if !character.is_on_floor():
		state_machine.change_state("airstate")
	character.sprite.play("idle")
	character.velocity = Vector2(0,0)
	
func handle_input(_event: InputEvent):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_state("walkstate")
	elif Input.is_action_pressed("jump"):
		state_machine.change_state("jumpstate")

func physics_update(_delta: float):
	if character.velocity != Vector2(0,0):
		state_machine.change_state("walkstate")
