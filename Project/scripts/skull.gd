extends Enemy

@export var spawn_range: float = 192


func _spawn_in():
	position.x += randf_range(-spawn_range, spawn_range)


func _physics_process(_delta):
	if is_instance_valid(Player.instance):
		direction = global_position.direction_to(Player.instance.global_position)
	velocity = direction * speed
	move_and_slide()
	face_direction()
