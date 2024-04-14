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


func trigger_hit() -> void:
	for area in get_overlapping_areas():
		if area is Hurtbox:
			area.hitbox_entered.emit(self)
