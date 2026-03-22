extends Weapon

func shoot():
	spawn_bullet("black_hole", 200)
	recoil(200)
