extends ProgressBar

@onready var health_component: HealthComponent = $"../HealthComponent"

func _ready():
	max_value = health_component.max_health
	value = health_component.max_health

func _on_health_component_damaged(health: Variant, _damage: Variant) -> void:
	value = health
