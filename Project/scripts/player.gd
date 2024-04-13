class_name Player
extends CharacterBody2D

@export var player_controller: PlayerController
@export var visuals: Node2D


func _process(_delta):
	# Rotate if the player is moving
	if player_controller.is_moving():
		visuals.scale.x = player_controller.get_movement_as_int()


func _physics_process(_delta):
	velocity.x = player_controller.get_movement()
	velocity.y += player_controller.gravity
	
	if is_on_floor() and player_controller.is_jump_buffered():
		velocity.y = - player_controller.jump_force
	
	move_and_slide()
