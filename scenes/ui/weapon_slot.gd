extends Control

class_name WeaponSlot

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label
var wielder: Player
var displayed_weapon: Weapon
func update_weapon(new_weapon: Weapon):
	displayed_weapon = new_weapon
	if displayed_weapon == null or displayed_weapon.name == "PlayerPunch":
		texture_rect.visible = false
		label.visible = false
	else:
		progress_bar.value = 0
		texture_rect.visible = true
		label.visible = true
		texture_rect.texture = displayed_weapon.sprite.texture
		wielder = displayed_weapon.wielder

func _process(_delta: float) -> void:
	if displayed_weapon:
		label.text = str(displayed_weapon.ammo)+"/"+str(displayed_weapon.initial_ammo)
		progress_bar.value = 1 - displayed_weapon.time_since_reload/displayed_weapon.reload_time
	else:
		update_weapon(null)
	
