extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var health_component: HealthComponent = $HealthComponent
@onready var sound_component: SoundComponent = $SoundComponent

var total_enemies: int = 0
var damage_per_enemy: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("enemy"):
		total_enemies += 1

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		total_enemies -= 1

func _on_timer_timeout() -> void:
	health_component.damage(damage_per_enemy * total_enemies)
	timer.start()

func _on_health_component_death() -> void:
	GameManager.game_fail()

func _on_health_component_damaged(_health: Variant, _damage: Variant) -> void:
	sound_component.play("hit_sound", 2)
