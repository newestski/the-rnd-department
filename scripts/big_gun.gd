extends Node2D

@export var velocity: float
@onready var parent: NavigationCharacter = $".."

@onready var point_at_target: PointAtTarget = $PointAtTarget
@onready var bullet_component: BulletComponent = $BulletComponent
@onready var timer: Timer = $Timer

func _ready():
	point_at_target.target = get_tree().get_first_node_in_group("player")
	parent.health_component.death.connect(on_death)
 
func _on_timer_timeout() -> void:
	bullet_component.spawn_bullet("test_bullet", get_parent().position, Vector2(cos(rotation),sin(rotation))*velocity)
	timer.start()

func on_death():
	visible = false
	timer.stop()
