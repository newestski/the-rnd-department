extends Weapon

func on_pickup():
	pass

func on_throwout():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func shoot():
	# do raycast
	var raycast = raycast_shoot()
	if raycast:
		var hit = raycast["collider"]
		deal_damage(hit, damage)
		bullet_visual(raycast)
