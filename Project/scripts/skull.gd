extends Enemy


func _physics_process(_delta):
	if is_instance_valid(Player.instance):
		direction = global_position.direction_to(Player.instance.global_position)
	velocity = direction * speed
	move_and_slide()
	face_direction()
