extends State

class_name AirState

const GRAVITY = 980
const FAST_GRAVITY = 1400
const MOVE_VELOCITY = 1500
const MAX_VELOCITY = 350
const TERMINAL_VELOCITY = 800
const FRICTION = 0.95
 
func enter():
	character.sprite.play("jump")

func physics_update(delta: float):	
	#gravity
	if character.velocity.y < TERMINAL_VELOCITY:
		if Input.is_action_pressed("jump"):
			character.velocity.y += GRAVITY * delta
		else:
			character.velocity.y += FAST_GRAVITY * delta
	else:
		if Input.is_action_pressed("jump"):
			character.velocity.y -= GRAVITY * delta
		else:
			character.velocity.y -= FAST_GRAVITY * delta
	
	#Air movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction == 0:
		character.velocity.x *= FRICTION
	else:
		character.velocity.x += direction * MOVE_VELOCITY * delta
		if abs(character.velocity.x) > MAX_VELOCITY:
			character.velocity.x *= FRICTION
		
	character.move_and_slide()
	
	#Update state when on floor
	if character.is_on_floor():
		if direction == 0:
			state_machine.change_state("idlestate")
		else:
			state_machine.change_state("walkstate")
	
	#Update state when hitting wall
	if character.is_on_wall():
		state_machine.change_state("wallslidestate")

func handle_input(_event):
	if Input.is_action_just_pressed("slide"):
		state_machine.change_state("slidestate")
