extends Node

class_name DespawnComponent



@onready var parent: Node = $".."
var sprite

@export var time_to_despawn: float = 5
@export var time_flashing: float = 1
@export var time_between_flashes: float = 1
@export var do_flash: bool = true
@export var autostart_despawn: bool = true

var despawn_timer: Timer
var start_flashing_timer: Timer
var flash_timer: Timer
var is_flashing: bool = false

func _ready() -> void:
	if !parent is CanvasItem:
		do_flash = false
	if autostart_despawn == true:
		start_despawn()

func cancel_despawn():
	if despawn_timer:
		despawn_timer.queue_free()
	if do_flash:
		if start_flashing_timer:
			start_flashing_timer.queue_free()
		if is_flashing:
			if flash_timer:
				flash_timer.queue_free()
			is_flashing = false
			parent.visible = true

func start_despawn():
	despawn_timer = Timer.new()
	add_child(despawn_timer)
	despawn_timer.start(time_to_despawn)
	despawn_timer.timeout.connect(despawn)
	
	if do_flash == true:
		start_flashing_timer = Timer.new()
		add_child(start_flashing_timer)
		start_flashing_timer.start(time_to_despawn-time_flashing)
		start_flashing_timer.timeout.connect(start_flashing)
	
func despawn():
	parent.queue_free()

func start_flashing():
	is_flashing = true
	flash_timer = Timer.new()
	add_child(flash_timer)
	flash_timer.start(time_between_flashes)
	flash_timer.timeout.connect(flash)

func flash():
	flash_timer.start(time_between_flashes)
	if parent.visible == true:
		parent.visible = false
	else:
		parent.visible = true
