extends Button

@onready var settings_button: Button = $"."
@onready var settings_menu: PanelContainer = $"../../../../SettingsMenu"

func _on_pressed() -> void:
	settings_menu.visible = true
