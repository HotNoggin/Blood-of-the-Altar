class_name Holdable
extends Area2D

@export var floor_height: float = 32
@export var item_offset: float = 8
@export var fall_gravity: float = 15
@export var bounce_multiple: float = 0.8
@export var velocity: float = -3

@export var time_to_live: float = 8
@export var use_infinite_lifetime: bool = false

var _time_alive: float = 0


func _ready():
	if position.y >= floor_height - item_offset:
		position.y = floor_height - item_offset


func _physics_process(delta):
	if is_held():
		modulate.a = 1
	else:
		fall_and_bounce(delta)
		_time_alive += delta
		modulate.a = lerp(1, 0, _time_alive / time_to_live)
		if _time_alive > time_to_live:
			queue_free()


## Called when the holdable is picked up
func grab() -> void:
	_time_alive = 0


## Called when the hodable is dropped
func drop() -> void:
	velocity = -3


func is_held() -> bool:
	return get_parent() is AnchorPoint


func retrigger_overlaps() -> void:
	for area in get_overlapping_areas():
		area.area_entered.emit(self)


func fall_and_bounce(delta: float) -> void:
	# Fall
	velocity += fall_gravity * delta
	position.y += velocity
	# Bounce
	if position.y >= floor_height - item_offset:
		velocity = velocity * (- bounce_multiple)
		position.y = floor_height - item_offset
