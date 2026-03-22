extends Node

class_name PointAtTarget

@export var target: Node2D
@export var smoothing: float

@onready var parent: Node2D = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if target:
		var direction = (target.global_position - parent.global_position).angle()
		parent.rotation = direction
