extends State

class_name WallPushState

var shape_cast: ShapeCast2D

func enter():
	character.sprite.play("idle")

func handle_input(_event: InputEvent):
	#find wall direction (1 for right, -1 for left)
	var wall_direction: int
	if character.get_wall_normal().angle()>1.57:
		wall_direction = 1
	else:
		wall_direction = -1
	
	#left and right movement
	var direction = Input.get_axis("move_left", "move_right")
	if wall_direction == -direction:
		state_machine.change_state("walkstate")
	
	#jump
	if Input.is_action_pressed("jump"):
		state_machine.change_state("jumpstate")
