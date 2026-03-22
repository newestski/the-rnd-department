extends Weapon

func on_ready() -> void:
	in_the_air = false

func shoot():
	spawn_bullet("punch_bullet")
	ammo = 2

func throw():
	pass
