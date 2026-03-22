extends Camera2D

var scroll_speed = 40
var scroll_limit = 960

func _process(delta: float) -> void:
	position.x += delta * scroll_speed
	offset = get_tree().current_scene.get_global_mouse_position()/35
	if position.x > scroll_limit:
		position.x = 0
