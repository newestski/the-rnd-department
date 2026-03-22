extends Bullet

func hit(body):
	if body.has_node("HealthComponent"):
		print("HIT:::!!!"+str(body))
		body.get_node("HealthComponent").damage(damage)
