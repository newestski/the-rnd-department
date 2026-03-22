extends Character

var direction: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = sign(get_tree().get_first_node_in_group("enemy_target").position.x - position.x)
	if direction == -1:
		sprite.flip_h = true
