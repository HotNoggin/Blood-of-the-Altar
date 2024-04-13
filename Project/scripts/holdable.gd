class_name Holdable
extends Area2D

@export var floor_height: float = 32
@export var item_offset: float = 8
@export var fall_gravity: float = 15
@export var bounce_multiple: float = 0.8
@export var velocity: float = 2


func _physics_process(delta):
	if not is_held():
		fall_and_bounce(delta)

## Called when the holdable is picked up
func grab() -> void:
	pass


## Called when the hodable is dropped
func drop() -> void:
	pass


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
