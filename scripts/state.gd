extends Node

class_name State

# Refrence to state machine:
var state_machine: StateMachine
var character
var character_collider: CollisionShape2D
var character_animated_sprite: AnimatedSprite2D
var character_particle_system: ParticleSystem

func generate_shapecast(distance, direction):
	var shape_cast = ShapeCast2D.new()
	shape_cast.shape = character.collider.shape
	shape_cast.position = character.collider.position
	shape_cast.target_position = Vector2(distance, 0).rotated(direction)
	character.add_child(shape_cast)
	shape_cast.force_shapecast_update()
	return shape_cast

# Virtual methods that child states can override
func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func handle_input(_event: InputEvent):
	pass
