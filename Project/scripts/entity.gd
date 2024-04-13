class_name Entity
extends CharacterBody2D

@export var animator: AnimationPlayer
@export var visuals: Node2D
@export var hurtbox: Hurtbox
@export var loot_drop: PackedScene


func play_safe(animation: String) -> void:
	if animator.has_animation(animation):
		animator.play(animation)
	else:
		print("Animation not found")


func play_effect_as_sibling(effect: OnceEffect) -> void:
	effect.reparent(get_parent())
	effect.play()


func drop_loot() -> void:
	if loot_drop:
		if not loot_drop.can_instantiate():
			return
		var loot_instance: Node = loot_drop.instantiate()
		add_sibling_at_self_position.call_deferred(loot_instance)


func add_sibling_at_self_position(sibling: Node2D) -> void:
	add_sibling(sibling)
	sibling.global_position = global_position
