extends Control

class_name GameplayUI

@onready var weapons_slots: BoxContainer = $MarginContainer/Control/WeaponsSlots
@onready var health_bar: HealthBar = $MarginContainer/Control/HealthBar

func update_weapons_display(equiped_weapons: Array):
	for i in range(0, weapons_slots.get_child_count()):
		var slot = weapons_slots.get_children()[i]
		if slot is WeaponSlot:
			if i < len(equiped_weapons): 
				slot.update_weapon(equiped_weapons[i])
			else:
				slot.update_weapon(null)

func update_health(new_health = null, new_max_health = null):
	print(health_bar)
	health_bar.update_health(new_health, new_max_health)

func update_shield(new_health = null, new_max_health = null):
	print(health_bar)
	health_bar.update_health(new_health, new_max_health)


func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
