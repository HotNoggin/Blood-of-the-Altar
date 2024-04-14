class_name Altar
extends Area2D

static var instance: Altar

@export_group("Behavior")
@export var scene_pool: Array[PackedScene]
@export var hurtbox: Hurtbox
@export_group("Graphics")
@export var sacrifice_effect: OnceEffect
@export var hurt_effect: OnceEffect
@export var death_effect: OnceEffect
@export var sprite: Sprite2D
@export_group("Audio")
@export var sacrifice_sound: AudioStream
@export var death_sound: AudioStream



var health: int = 3
var is_alive: bool = true


func _ready():
	instance = self
	hurtbox.hitbox_entered.connect(func(_hitbox: Hitbox):
		if is_instance_valid(Player.instance):
			if not Player.instance.is_invincible:
				hurt()
		)


func sacrifice(item: Holdable) -> void:
	if is_instance_valid(item):
		# Remove the holdable and do effects
		item.queue_free()
		sacrifice_effect.duplicate_and_play()
		OnceSound.new_sibling(self, sacrifice_sound).play()


func hurt() -> void:
	if health > 0:
		# Reset invinvibility timer, set health
		Player.instance.is_invincible = true
		get_tree().create_timer(Player.instance.invincibility_time).timeout.connect(
			func():
				Player.instance.is_invincible = false
		)
		
		health -= 1
		sprite.frame = health
		
		if health <= 0:
			die()
			return
		
		OnceSound.new_sibling(self, death_sound).play()
		hurt_effect.duplicate_and_play()
		Player.instance.hurt_effect.duplicate_and_play()
		Globals.shake(50, 0.5, 0.5)
		Globals.timestop(0.2, 0.5)
	else:
		health = 0
		die()
		return


func die() -> void:
	if not is_alive:
		return
	
	is_alive = false
	OnceSound.new_sibling(self, death_sound).play()
	Globals.timestop(0.4 , 1)
	Globals.shake(100, 1, 4)
	death_effect.reparent(get_parent())
	death_effect.play()
	Player.instance.die()
