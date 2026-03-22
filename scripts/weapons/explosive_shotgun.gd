extends Weapon

@export var spray_amount: int = 5
@export var spray_angle: float = 0.1

func on_pickup():
	pass

func on_throwout():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func shoot():
	for i in range(spray_amount):
		var raycast = raycast_shoot(500, randf_range(-spray_angle, spray_angle))
		if raycast:
			var hit = raycast["collider"]
			deal_damage(hit, damage)
			bullet_visual(raycast)
	recoil(250)
	
