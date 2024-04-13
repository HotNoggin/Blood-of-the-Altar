class_name Entity
extends CharacterBody2D

@export var animator: AnimationPlayer
@export var visuals: Node2D
@export var hurtbox: Hurtbox


func play_safe(animation: String):
	if animator.has_animation(animation):
		animator.play(animation)
	else:
		print("Animation not found")


func play_effect_as_sibling(effect: OnceEffect):
	effect.reparent(get_parent())
	effect.play()
