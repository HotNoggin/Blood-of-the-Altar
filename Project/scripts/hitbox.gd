class_name Hitbox
extends Area2D
## Deals damage

signal hurtbox_entered(hurtbox: Hurtbox)

@export var is_active: bool = true


func _ready():
	area_entered.connect(func(area: Area2D):
		if is_active:
			if area is Hurtbox:
				if area.is_active: hurtbox_entered.emit(area))
	_hitbox_ready.call_deferred()


func trigger_hit() -> void:
	for area in get_overlapping_areas():
		if area is Hurtbox:
			area.hitbox_entered.emit(self)


func _hitbox_ready() -> void:
	pass
