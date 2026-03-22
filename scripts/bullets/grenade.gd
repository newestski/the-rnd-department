extends Bullet

var light_increase: float = 20

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var bullet_component: BulletComponent = $BulletComponent
var hitted: bool = false

func hit(_body):
	if hitted == false:
		hitted = true
		bullet_component.spawn_bullet("explosion", global_position, Vector2(0,0))
		queue_free()
