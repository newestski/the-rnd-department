extends State

class_name WalkState

const MAX_VELOCITY = 300
const MOVE_VELOCITY = 2000
const FRICTION = 0.9
const VELOCITY_TO_IDLE = 10
const COYOTE_TIME = 0.05

const TIME_BETWEEN_STEP_SFX: float = 0.1
const RANDOM_PITCH_STEP_SFX: float = 1.1

var air_time: float

func enter():
	character.sound_component.play_looped("step_sound", TIME_BETWEEN_STEP_SFX, RANDOM_PITCH_STEP_SFX)
	character.sprite.play("running")
	character.particle_system.set_particle("runningparticles", true)

func exit():
	character.particle_system.set_particle("runningparticles", false)
	character.sound_component.stop_loop("step_sound")

func physics_update(delta: float):	
	#left and right mevoment
	var direction := Input.get_axis("move_left", "move_right")
	if direction == 0:
		character.velocity.x *= FRICTION
		#if stop moving
		if abs(character.velocity.x) < VELOCITY_TO_IDLE and direction == 0:
			state_machine.change_state("idlestate")
	else:
		character.velocity.x += direction * MOVE_VELOCITY * delta
		if abs(character.velocity.x) > MAX_VELOCITY:
			character.velocity.x *= 0.9
	
	character.move_and_slide()
	
	#flip sprite
	if character.velocity.x > 0:
		character.sprite.flip_h = false
	elif character.velocity.x < 0:
		character.sprite.flip_h = true
	
	#change animation speed
	character.sprite.speed_scale = character.velocity.x/MAX_VELOCITY
	character.sound_component.scale_sound_volume("step_sound", abs(character.velocity.x/MAX_VELOCITY))
	
	#falling off ledges + coyote time
	if character.is_on_floor():
		air_time = 0
	else:
		air_time += delta
	if air_time > COYOTE_TIME:
		state_machine.change_state("airstate")
	
	#running into walls
	if character.is_on_wall():
		state_machine.change_state("wallpushstate")

func handle_input(_event: InputEvent):
	if Input.is_action_pressed("jump"):
		state_machine.change_state("jumpstate")
	if Input.is_action_pressed("slide"):
			state_machine.change_state("slidestate")
