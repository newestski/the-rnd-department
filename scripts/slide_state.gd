extends State

class_name SlideState

const START_VELOCITY = 400
const FRICTION = 0.99
const VELOCITY_TO_IDLE = 75
const MAX_SLIDE_TIME = 0.5
const GRAVITY = 980
@export var shape: Shape2D

var direction: int
var time: float

func enter():
	character.set_collision_mask_value(7, false)
	character.sprite.play("slide")
	direction = int(Input.get_axis("move_left", "move_right"))
	character.velocity.x = direction*START_VELOCITY
	character.collider.scale.y *= 0.5
	character.collider.position.y += 4
	character.sound_component.play("swoosh_sound")
	time = 0

func exit():
	character.set_collision_mask_value(7, true)
	character.collider.scale.y *= 2
	character.collider.position.y -= 4
	time = 0


func physics_update(delta: float):
	character.velocity.x *= FRICTION
	
	#gravity (sometimes)
	if character.is_on_floor():
		character.velocity.y = 0
	else:
		character.velocity.y += GRAVITY * delta
	
	character.move_and_slide()
	
	#if stop moving
	if abs(character.velocity.x) < VELOCITY_TO_IDLE:
		state_machine.change_state("walkstate")
	
	#if runs into wall
	if character.is_on_wall():
		if character.is_on_floor():
			state_machine.change_state("wallpushstate")
		else:
			state_machine.change_state("wallslidestate")
	
	# if slide times out
	time += delta
	if time > MAX_SLIDE_TIME:
		if character.is_on_floor():
			state_machine.change_state("walkstate")
		else:
			state_machine.change_state("airstate")

func handle_input(_event: InputEvent):
	if Input.is_action_pressed("jump"):
		if character.is_on_floor():
			state_machine.change_state("jumpstate")
