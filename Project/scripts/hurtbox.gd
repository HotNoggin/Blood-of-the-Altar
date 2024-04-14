class_name Hurtbox
## Recieves damage
extends Area2D

signal hitbox_entered(hitbox: Hitbox)

@export var is_active: bool = true


func _ready():
	area_entered.connect(func(area: Area2D):
		if is_active:
			if area is Hitbox:
				if area.is_active: hitbox_entered.emit(area))


func _physics_process(_delta):
	for area in get_overlapping_areas():
		if area is Hitbox:
			if is_active and area.is_active:
				area.hurtbox_entered.emit(self)
