class_name PlayerController
extends Node

@export var speed: float = 120
@export var kick_speed: float = 200
@export var cooldown_speed: float = 80
@export var gravity: float = 9.8
@export var jump_force: float = 200
@export var bounce_force: float = 80
@export var jump_buffer_time: float = 0.25

var jump_buffer: float = jump_buffer_time + 1


func _process(delta):
	jump_buffer += delta
	if Input.is_action_just_pressed("jump"):
		jump_buffer = 0.0


func get_movement() -> float:
	return Input.get_axis("left", "right") * speed


func is_jump_buffered() -> bool:
	# True if the buffer has not exceeded the jump buffer time
	return jump_buffer <= jump_buffer_time


func just_acted() -> bool:
	return Input.is_action_just_pressed("act")


func get_movement_as_int() -> int:
	if is_zero_approx(get_movement()):
		return 0
	elif get_movement() > 0:
		return 1
	elif get_movement() < 0:
		return -1
	return 0


func is_moving() -> bool:
	# True if the movement is not zero
	return not (get_movement_as_int() == 0)
