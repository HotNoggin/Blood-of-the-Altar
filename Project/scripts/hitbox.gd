class_name Hitbox
## Deals damage
extends Area2D

signal hurtbox_entered(hurtbox: Hurtbox)

@export var is_active: bool = true


func _ready():
	area_entered.connect(func(area: Area2D):
		if is_active:
			if area is Hurtbox:
				if area.is_active: hurtbox_entered.emit(area))
