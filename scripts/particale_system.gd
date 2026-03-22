extends Node2D

class_name ParticleSystem

var particles: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is CPUParticles2D:
			particles[child.name.to_lower()] = child

func set_particle(particle: String, emitting: bool):
	particles[particle].emitting = emitting
