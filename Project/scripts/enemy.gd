class_name Enemy
extends Entity

@export var effect: OnceEffect
@export var sound: AudioStream
@export var pitch_randomization: float = 3


func _ready():
	hurtbox.hitbox_entered.connect(func(_hitbox: Hitbox):
		kill()
		)


func kill():
	OnceSound.new_sibling(self, sound).play()
	Globals.timestop(0.2 , 0.3)
	play_effect_as_sibling(effect)
	drop_loot()
	queue_free()
