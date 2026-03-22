extends Bullet

@onready var hit_sound: AudioStreamPlayer2D = $HitSound

# Called when the node enters the scene tree for the first time.
func hit(body):
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").damage(damage)
		hit_sound.play()
	if body is TileMapLayer:
		queue_free()
		hit_sound.play()
