extends State

class_name NavAndShootState

@export var bullet_speed: float = 100

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

var time:float = 0
func physics_update(delta: float):
	if !get_tree().get_first_node_in_group("enemy_target"): return
	var target_pos = get_tree().get_first_node_in_group("enemy_target").position
	print(target_pos)
	character.navigation_agent.target_position = target_pos
	time += delta
	var direction: Vector2 = (character.position - target_pos).normalized()*-bullet_speed
	if time > 1:
		character.bullet_component.spawn_bullet("test_bullet", character.position, direction)
		time = 0
