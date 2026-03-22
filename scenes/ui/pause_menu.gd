extends PanelContainer

@onready var unpause_button: Button = $PanelContainer/MarginContainer/VBoxContainer/UnpauseButton
@onready var settings_button: Button = $PanelContainer/MarginContainer/VBoxContainer/SettingsButton
@onready var main_menu_button: Button = $PanelContainer/MarginContainer/VBoxContainer/MainMenuButton
@onready var quit_button: Button = $PanelContainer/MarginContainer/VBoxContainer/QuitButton

var settings_menu
var paused = false

func _ready():
	settings_menu = get_tree().get_first_node_in_group("settings_menu")

func _on_unpause_button_pressed() -> void:
	visible = false
	paused = false
	get_tree().paused = false

func _on_settings_button_pressed() -> void: 
	settings_menu.visible = true
	visible = false
	await settings_menu.visibility_changed
	visible = true

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	GameManager.change_scene("main_menu")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_exit_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	paused = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false and paused == false:
			visible = true
			paused = true
			get_tree().paused = true
		elif get_tree().paused == true and paused == true:
			visible = false
			paused = false
			get_tree().paused = false
