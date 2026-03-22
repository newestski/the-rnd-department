extends Node2D

class_name WeaponComponent

@onready var gameplay_ui: GameplayUI = $"../../MainUI/GameplayUI"
@onready var parent: Player = $".."
@export var deafult_weapon: Weapon
@export var max_weapons: int
@export var default_weapon: int
var current_weapon: Weapon
var equiped_weapons: Array
var full = false
var empty = true

func _ready() -> void:
	pass

func validate_equiped():
	equiped_weapons = equiped_weapons.filter(is_instance_valid)
	#ensure number of weapons < max weapons and displays correct weapons
	if current_weapon != deafult_weapon:
		if equiped_weapons:
			current_weapon = equiped_weapons.get(0)
		for i in range(0, len(equiped_weapons)):
			if equiped_weapons[i] == current_weapon:
				equiped_weapons[i].held = true
			else:
				equiped_weapons[i].held = false
			if i >= max_weapons:
				equiped_weapons.remove_at(i)
		if len(equiped_weapons) >= max_weapons:
			full = true
		else:
			full = false
		empty = false
		#overide display if no weapons and only defualt
		deafult_weapon.held = false
		gameplay_ui.update_weapons_display(equiped_weapons)
	else:
		var deafult_displays: Array
		full = false
		empty = true
		deafult_displays.append(deafult_weapon)
		deafult_weapon.held = true
		gameplay_ui.update_weapons_display(deafult_displays)

func add_weapon(new_weapon: Weapon) -> void:
	if new_weapon:
		current_weapon = new_weapon
		equiped_weapons.push_front(new_weapon)
		validate_equiped()
		
		#connect sound to when thrown
		new_weapon.thrown.connect(on_thrown)

func on_thrown():
	parent.sound_component.play("throw_sound")

func cycle_weapons():
	equiped_weapons.append(equiped_weapons.pop_front())
	validate_equiped()

func remove_weapon(weapon: Weapon) -> void:
	equiped_weapons.erase(weapon)
	validate_equiped()

func _process(delta: float):
	if current_weapon:
		current_weapon.update(delta)
	else:
		validate_equiped()
	# if there are no weapons equiped, equip default
	if !equiped_weapons:
		current_weapon = deafult_weapon
		current_weapon.wielder = owner
		validate_equiped()


func _physics_process(delta: float):
	if current_weapon:
		current_weapon.physics_update(delta)

func _input(event: InputEvent):
	if current_weapon:
		current_weapon.handle_input(event)
	if Input.is_action_just_pressed("cycle_weapons"):
		cycle_weapons()
