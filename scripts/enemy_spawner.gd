extends Node2D

class_name EnemySpawner

@export var timer:Timer
@export var enabled:bool

var enemy_list: Array
var enemy: PackedScene

var current_time: float = 15

func _ready() -> void:
	var dir := DirAccess.open("res://scenes/enemies")
	if dir == null: printerr("Could not open folder"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var resource := load(dir.get_current_dir() + "/" + file.trim_suffix('.remap'))
		if resource is Resource:
			enemy_list.append(resource)
	print("WTF?:"+str(enemy_list))
	timer.timeout.connect(spawn)
	timer.start(current_time)
	spawn()

func spawn():
	current_time *= randf_range(0.98, 1.01)
	print("HIIII!!!!"+str(current_time))
	if !enabled: return
	enemy = enemy_list[randi_range(0,len(enemy_list)-1)]
	var spawned = enemy.instantiate()
	spawned.position = position
	add_sibling.call_deferred(spawned)
