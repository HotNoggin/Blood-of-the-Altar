class_name Player
extends Entity

@export_group("Components")
@export var player_controller: PlayerController
@export var interactor: Interactor
@export var anchor: AnchorPoint
@export var hitbox: Hitbox
@export_group("Visuals")
@export var walking_effect: GPUParticles2D
@export var death_effect: OnceEffect
@export var tilt_amount: float = 8
@export_group("Audio")
@export var slide_player: AudioStreamPlayer
@export var landing_sound: AudioStream
@export var death_sound: AudioStream

var is_alive: bool = true

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
	hurtbox.hitbox_entered.connect(func(_entered_hitbox: Hitbox):
		die()
		)


func _process(_delta):
	if not is_alive:
		play_safe("die")
		return
	
	
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
		play_safe("hold_idle") if anchor.is_holding() else play_safe("idle")


func _physics_process(_delta):
	if not is_alive:
		return
	
	
	# Kicking locks the player in the animation and enables hitbox
	if is_kicking():
		hitbox.is_active = true
		hurtbox.is_active = false
		move_and_slide()
		return
	else:
		hitbox.is_active = false
		hurtbox.is_active = true
	
	# Cooling down locks the player in the animation with gravity
	if is_cooling_down():
		velocity.x = look_direction * player_controller.cooldown_speed
		velocity.y += player_controller.gravity
		move_and_slide()
		return

	if player_controller.just_acted():
		# Drop item
		if anchor.is_holding():
			anchor.drop_held_holdable()
		# Kick
		else:
			velocity.x = player_controller.kick_speed * look_direction
			velocity.y = 0
			play_safe("kick")
			move_and_slide()
			return
		
	
	# Grab if the player is grabbing the selected holdable
	if player_controller.just_grabbed() and interactor.is_selected():
		if not anchor.is_holding():
			anchor.grab_holdable(interactor.selected_holdable)
	
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


func die():
	if not is_alive:
		return
	
	is_alive = false
	z_index = 5
	OnceSound.new_sibling(self, death_sound).play()
	Globals.timestop(0.4 , 1)
	Globals.shake(100, 1, 4)
	play_effect_as_sibling(death_effect)


func is_kicking() -> bool:
	# True if the kick animation is playing
	return animator.is_playing() and animator.current_animation == "kick"


func is_cooling_down() -> bool:
	# True if the kick cooldwon animation is playing
	return animator.is_playing() and animator.current_animation == "kick_cooldown"
