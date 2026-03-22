extends State

class_name EnemyWalkState

@export var damage: float = 10
@export var speed: float = 10

var shape_cast: ShapeCast2D

func enter():
	character.sprite.animation = "walk"
	character.velocity.y = 0
	character.velocity.x = speed * character.direction
	shape_cast = generate_shapecast(10, (character.direction-1)*(PI/2))
	shape_cast.collision_mask = 0b00000000_00000000_00000000_00000001

func exit():
	shape_cast.queue_free()

func physics_update(_delta: float):
	character.move_and_slide()
	
	if !character.is_on_floor():
		state_machine.change_state("enemyfallstate")
		
	if shape_cast.is_colliding():
		state_machine.change_state("enemyjumpstate")
