extends Character

class_name Player

@onready var weapon_component: WeaponComponent = $WeaponComponent
@onready var sound_component: SoundComponent = $SoundComponent

func _on_health_component_death() -> void:
	GameManager.game_fail()

func _on_health_component_damaged(_health: Variant, _damage: Variant) -> void:
	sound_component.play("hurt_sound")
