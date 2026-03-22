extends State

class_name JumpState

const JUMP_VELOCITY = 400

func enter():
	character.velocity.y = -JUMP_VELOCITY
	character.sound_component.play("jump_sound", 1.5)
	state_machine.change_state("airstate")
	character.particle_system.set_particle("jumpparticles", true)
