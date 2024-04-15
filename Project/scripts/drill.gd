extends Enemy

@export var spawn_range: float = 192
@export var initial_speed: float = -10
@export var lifetime: float = 4

var time_alive: float = 0



func _spawn_in():
	position.x += randf_range(-spawn_range, spawn_range)

func _enemy_ready():
	velocity.y = initial_speed


func _physics_process(delta):
	time_alive += delta
	if time_alive > lifetime:
		queue_free()
	apply_gravity(delta)
	move_and_slide()
