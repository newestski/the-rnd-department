extends State

class_name WallslideState

const GRAVITY_STRENGTH = 800
const TERMINAL_VELOCITY = 300
const JUMP_VELOCITY: Vector2 = Vector2(200, 250)

var wall_direction: int
var shape_cast: ShapeCast2D

func enter():
	#find wall direction (1 for right, -1 for left)
	if character.get_wall_normal().angle()>PI/2:
		wall_direction = 1
	else:
		wall_direction = -1
	
	#setup particles
	character.particle_system.scale.x = wall_direction
	character.particle_system.set_particle("wallslideparticles", true)
	
	# generate shapecast to check for wall
	shape_cast = generate_shapecast(5, character.get_wall_normal().angle()+PI)
	
	character.sprite.play("wall_slide")
	
func exit():
	character.particle_system.scale.x = 1
	character.particle_system.set_particle("wallslideparticles", false)
	shape_cast.queue_free()

func physics_update(delta: float):	
	#gravity
	if character.velocity.y < TERMINAL_VELOCITY:
		character.velocity.y += GRAVITY_STRENGTH * delta
	else:
		character.velocity.y -= GRAVITY_STRENGTH * delta
	character.move_and_slide()
	
	#left and right movement
	var direction = Input.get_axis("move_left", "move_right")
	if wall_direction == -direction:
		state_machine.change_state("airstate")
	
	#check if wall is still there
	if !shape_cast.is_colliding():
		state_machine.change_state("airstate")
	
	#check if hiting floor
	if character.is_on_floor():
		state_machine.change_state("wallpushstate")
	
	#flip sprite correctly
	if wall_direction == 1:
		character.sprite.flip_h = false
	else:
		character.sprite.flip_h = true

func handle_input(_event: InputEvent):
	#wall jump
	if Input.is_action_just_pressed("jump"):
		character.velocity += Vector2(JUMP_VELOCITY.x * character.get_wall_normal().x, -JUMP_VELOCITY.y)
		state_machine.change_state("airstate")
		character.particle_system.set_particle("jumpparticles", true)
		character.sound_component.play("jump_sound")
	
	
