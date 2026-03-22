extends Node

class_name BulletComponent

var character: Character

func spawn_bullet(bullet_name: String, s_positon: Vector2, s_velocity: Vector2):
	var bullet = load("res://scenes/bullets/"+bullet_name+".tscn")
	var instance: Bullet = bullet.instantiate()
	instance.position = s_positon
	instance.velocity = s_velocity
	get_tree().current_scene.add_child.call_deferred(instance)
	print(instance)
