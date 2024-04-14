extends Node2D

@export var speed: float = 20
@export var lifetime: float = 5

var direction: Vector2 = Vector2.RIGHT
var _time_alive: float = 0


func _ready():
	direction = Vector2.LEFT if randf_range(0, 1) == 1 else Vector2.RIGHT


func _physics_process(delta):
	_time_alive += delta
	if _time_alive >= lifetime:
		queue_free()
	position += direction * speed * delta
