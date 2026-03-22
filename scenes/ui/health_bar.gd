extends Control

class_name HealthBar

@onready var progress_bar: ProgressBar = $ProgressBar

var displayed_health: int
var max_health: int

func update_health(new_health = null, new_max_health = null):
	if new_health:
		progress_bar.value = new_health
	if new_max_health:
		progress_bar.max_value = new_max_health
