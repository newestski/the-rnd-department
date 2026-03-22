extends Node

class_name StateMachine

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	# Register child states
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			#Set refrences in states:
			#state machine
			child.state_machine = self
			#character
			child.character = get_parent()

	
	if initial_state:
		change_state(initial_state.name.to_lower())

func _process(delta: float):
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float):
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent):
	if current_state:
		current_state.handle_input(event)

func change_state(new_state_name: String):
	print("entered new state: " + new_state_name)
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())
	
	if current_state:
		current_state.enter()
