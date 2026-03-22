extends Bullet

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func on_spawn():
	animation_player.play("spawn")
	timer.start()

func animation():
	animation_player.play("loom")

func _process(_delta: float) -> void:
	velocity *= 0.95

func hit(body):
	if body is Character:
		body.get_node("HealthComponent").damage(damage)
	else:
		body.queue_free()

func _on_timer_timeout() -> void:
	animation_player.play("despawn")
