extends PhysicsBody2D

class_name Box

@export var health_component: HealthComponent
@export var state_machine: StateMachine 
var weapon_list: Array

func _ready():
	var dir := DirAccess.open("res://scenes/weapons")
	if dir == null: printerr("Could not open folder"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var resource: Resource = load(dir.get_current_dir() + "/" + file.trim_suffix('.remap'))
		if resource is Resource:
			weapon_list.append(resource)
	print(weapon_list)

func spawn():
	var dropped_weapon = weapon_list[randi_range(0,len(weapon_list)-1)]
	var spawned = dropped_weapon.instantiate()
	spawned.position = position
	add_sibling.call_deferred(spawned)
	queue_free()

func _on_health_component_death() -> void:
	spawn()
