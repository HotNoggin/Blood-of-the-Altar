class_name Enemy
extends Entity

@export var direction: Vector2
@export var death_effect: OnceEffect
@export var death_sound: AudioStream
@export var speed: float = 15
@export var gravity: float = 12
@export var hitbox: Hitbox
@export var die_on_contact: bool = false

var dead: bool = false


func _ready():
	hurtbox.hitbox_entered.connect(func(_hitbox: Hitbox):
		if not dead:
			die()
			dead = true
		)
	
	hitbox.hurtbox_entered.connect(func(collided_box: Hurtbox):
		if collided_box is PlayerTeamHurtbox:
			_reached_altar_or_player()
		if die_on_contact:
			die(false)
		)
	
	_enemy_ready()


func _enemy_ready() -> void:
	pass


func _spawn_in() -> void:
	pass


func _reached_altar_or_player() -> void:
	pass


func die(to_drop_loot: bool = true) -> void:
	OnceSound.new_sibling(self, death_sound).play()
	play_effect_as_sibling(death_effect)
	if to_drop_loot:
		drop_loot()
	queue_free()


func face_direction() -> void:
	if not is_zero_approx(direction.x):
		visuals.scale.x = 1 if direction.x > 0 else - 1


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta
