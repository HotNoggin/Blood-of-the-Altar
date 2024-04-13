class_name Enemy
extends Entity

@export var effect: OnceEffect


func _ready():
	hurtbox.hitbox_entered.connect(func(_hitbox: Hitbox):
		kill()
		)


func kill():
	Globals.timestop(0.1 , 0.2)
	play_effect_as_sibling(effect)
	queue_free()
