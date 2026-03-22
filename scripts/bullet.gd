extends Area2D

class_name Bullet

@onready var sprite: Sprite2D = $Sprite2D

var velocity: Vector2
@export var damage: float = 10
@export var despawn_time: float = 100
@export var rotate_sprite: bool = false
@export var grav: float = 0
var time: float = 0

func _ready():
	body_entered.connect(hit)
	on_spawn()

func on_spawn():
	pass

func _physics_process(delta: float) -> void:
	position += velocity * delta
	velocity.y += grav * delta
	time += delta
	if time > despawn_time:
		queue_free()
	if rotate_sprite == true:
		sprite.rotation = velocity.angle()
	on_physics_process(delta)

func on_physics_process(_delta: float):
	pass

func hit(body):
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").damage(damage)
		queue_free()
	elif body is TileMapLayer:
		queue_free()
