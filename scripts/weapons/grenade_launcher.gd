extends Weapon

func shoot():
	spawn_bullet("grenade", 400)
	recoil(200)
