extends Weapon

func shoot():
	wielder.health_component.damage(-50)
	sprite.frame = 1
