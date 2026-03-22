extends State

class_name BasicNavState

@export var move_speed: float = 1200

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(delta: float):
	character.navigation_agent.target_position = get_tree().get_first_node_in_group("enemy_target").position
	var direction = sign(character.position.x-character.navigation_agent.target_position.x)
	if direction == 1:
		character.sprite.flip_h = true
	elif direction == -1:
		character.sprite.flip_h = false
	if !character.navigation_agent.is_target_reached():
		var nav_point_direction = character.to_local(character.navigation_agent.get_next_path_position()).normalized()
		character.velocity = nav_point_direction * move_speed * delta
	character.move_and_slide()

func handle_input(_event: InputEvent):
	pass
