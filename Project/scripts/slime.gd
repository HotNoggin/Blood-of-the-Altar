extends Enemy


func _physics_process(delta):
	direction.x = 1 if Altar.instance.global_position.x > global_position.x else -1
	velocity.x = direction.x * speed
	apply_gravity(delta)
	move_and_slide()


func _reached_altar_or_player() -> void:
	play_effect_as_sibling(death_effect)
	queue_free()
