class_name Player
extends Entity

@export var player_controller: PlayerController
@export var hitbox: Hitbox
@export var walking_effect: GPUParticles2D
@export var tilt_amount: float = 8
@export var landing_sound: AudioStream

var look_direction: int:
	set(value):
		visuals.scale.x = value
	get:
		return int(visuals.scale.x)


func _ready():
	# Cooldown animation after a kick
	animator.animation_finished.connect(func(animation_name):
		if animation_name == "kick":
			play_safe("kick_cooldown")
		)


func _process(_delta):
	# Flip graphics
	if player_controller.is_moving():
		look_direction = player_controller.get_movement_as_int()
	
	# Tilt graphics
	if is_zero_approx(velocity.x):
		visuals.rotation_degrees = 0
	else:
		visuals.rotation_degrees = abs( velocity.x ) / velocity.x * (- tilt_amount)
	
	# Emit particles
	walking_effect.emitting = true if not(is_zero_approx(velocity.x)) and is_on_floor() else false
	
	# Kicking and cooling down locks animation
	if is_kicking() or is_cooling_down():
		return
	
	if not is_on_floor():
		play_safe("jump")
	elif player_controller.is_moving():
		play_safe("run")
	else:
		play_safe("idle")


func _physics_process(_delta):
	# Kicking locks the player in the animation and enables hitbox
	if is_kicking():
		hitbox.is_active = true
		move_and_slide()
		return
	else:
		hitbox.is_active = false
	
	# Cooling down locks the player in the animation with gravity
	if is_cooling_down():
		velocity.x = look_direction * player_controller.cooldown_speed
		velocity.y += player_controller.gravity
		move_and_slide()
		return
	
	# Kick if not cooling down or kicking already
	if player_controller.just_acted():
		velocity.x = player_controller.kick_speed * look_direction
		velocity.y = 0
		play_safe("kick")
		move_and_slide()
		return
	
	# Fall
	velocity.y += player_controller.gravity
	
	# Get movemement
	velocity.x = player_controller.get_movement()
	
	# Jump
	if is_on_floor() and player_controller.is_jump_buffered():
		velocity.y = - player_controller.jump_force
	
	# Move
	var was_on_floor: bool = is_on_floor()
	move_and_slide()
	
	# Play sound if the move just caused the player to land
	if is_on_floor() and (not was_on_floor):
		OnceSound.new_sibling(self, landing_sound).play()


func is_kicking() -> bool:
	# True if the kick animation is playing
	return animator.is_playing() and animator.current_animation == "kick"


func is_cooling_down() -> bool:
	# True if the kick cooldwon animation is playing
	return animator.is_playing() and animator.current_animation == "kick_cooldown"
