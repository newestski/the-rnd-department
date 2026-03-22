extends Node2D

class_name Weapon

@onready var area_2d: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var despawn_component: DespawnComponent = $DespawnComponent
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

var weapon_component: WeaponComponent
var wielder: Player
var held: bool = false

@export var initial_ammo: int = 10
@export var reload_time: float = 1
@export var hold_distance: float = 20 
@export var damage: float = 10 
@export var throw_velocity: float = 400
@export var throw_gravity: float = 1000
@export var throw_spin_speed: float = 30
@export var throw_damage: float = 10
@export var shoot_sfx: AudioStreamPlayer2D
@export var equip_sfx: AudioStreamPlayer2D

var ammo: int
var time_since_reload: float
var in_the_air: bool = true
var velocity: Vector2 = Vector2(0,0)

signal thrown

func _ready() -> void:
	ammo = initial_ammo
	area_2d.body_entered.connect(collided)
	area_2d.set_collision_layer_value(3, true)
	on_ready()

func collided(body: Node):
	if !in_the_air and body is Player:
		get_equiped(body)
	if in_the_air:
		if body is TileMapLayer:
			in_the_air = false
			sprite.rotation = 0
			if ammo <= 0:
				destroy()
		elif body.is_in_group("enemy") or body.is_in_group("box"):
			if body is Character:
				deal_damage(body, throw_damage)

func generate_shapecast(direction: Vector2):
	var shape_cast = ShapeCast2D.new()
	shape_cast.shape = collision_shape.shape
	shape_cast.position = collision_shape.position
	shape_cast.target_position = direction
	add_child(shape_cast)
	shape_cast.force_shapecast_update()
	return shape_cast

func destroy():
	queue_free()

func get_equiped(player: Player):
	if player.weapon_component.full:
		return
	wielder = player
	despawn_component.cancel_despawn()
	weapon_component = wielder.weapon_component
	weapon_component.add_weapon(self)
	area_2d.body_entered.disconnect(collided)
	on_pickup()
	if equip_sfx:
		equip_sfx.play()

func throw():
	thrown.emit()
	if held:
		rotation = 0
		despawn_component.start_despawn()
		area_2d.body_entered.connect(collided)
		weapon_component.remove_weapon(self)
		velocity = wielder.get_local_mouse_position().normalized()*throw_velocity
		held = false
		wielder = null
		in_the_air = true
		on_throw()

func position_in_hands():
	position = wielder.position + wielder.get_local_mouse_position().normalized()*hold_distance
	rotation = wielder.get_local_mouse_position().angle()
	if sprite:
		sprite.flip_v = sign(wielder.position.x - position.x) == 1

func deal_damage(hit: Node, amount: float):
	if hit.has_node("HealthComponent"):
		hit.get_node("HealthComponent").damage(amount)

func raycast_shoot(distance: float = 500, rot: float  = 0):
	var space_state = get_world_2d().direct_space_state
	var mouse_vector = wielder.global_position + wielder.get_local_mouse_position().normalized()*distance
	var rotated_vector = mouse_vector.rotated(rot)
	var query = PhysicsRayQueryParameters2D.create(wielder.global_position, rotated_vector, 0b00000000_00000000_00000000_00100001)
	var result = space_state.intersect_ray(query)
	return result

func bullet_visual(raycast):
	var visual:Line2D = Line2D.new()
	visual.add_point(self.position)
	if raycast:
		visual.add_point(raycast["position"])
	else:
		visual.add_point(Vector2(cos(self.rotation), sin(self.rotation))*500)
	add_sibling(visual)
	visual.default_color = Color(1.0, 0.35, 0.349, 1.0)
	visual.width = 1
	var tween = get_tree().create_tween()
	tween.tween_property(visual, "default_color", Color(0.877, 0.0, 0.0, 0.0), 0.25)
	tween.tween_callback(visual.queue_free)

func recoil(strength):
	wielder.velocity -= Vector2(cos(rotation), sin(rotation))*strength

func spawn_bullet(bullet_name: String, vel: float = 100, rot: float = 0):
	var _space_state = get_world_2d().direct_space_state
	var mouse_vector = wielder.get_local_mouse_position().normalized()*vel
	var rotated_vector = mouse_vector.rotated(rot)
	wielder.bullet_component.spawn_bullet(bullet_name, position, rotated_vector)

func handle_input(_event: InputEvent):
	if Input.is_action_just_pressed("shoot"):
		
		if ammo <= 0:
			throw()
		
		if time_since_reload >= reload_time:
			time_since_reload = 0
			# ammo
			if ammo > 0:
				ammo -= 1
				shoot()
				#sounds
				if shoot_sfx:
					shoot_sfx.play()
	elif Input.is_action_just_pressed("throw"):
		throw()

func _physics_process(delta: float) -> void:
	time_since_reload += delta
	#handle visuals while held
	if wielder:
		if held:
			position_in_hands()
			visible = true
		else:
			visible = false
	
	if in_the_air:
		position += velocity * delta
		velocity.y += throw_gravity * delta
		sprite.rotation += throw_spin_speed * delta

#Functions to be ovewritten by inheritors
func on_ready():
	pass

func on_pickup():
	pass

func on_throw():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func shoot():
	pass
