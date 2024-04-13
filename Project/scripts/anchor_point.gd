class_name AnchorPoint
extends Marker2D

@export var holdable: Holdable: ## CRITICAL ONLY SET USING grab_holdable() !!!
	set(value):
		if is_instance_valid(holdable):
			holdable.drop()
		if is_instance_valid(value):
			value.grab()
			holdable = value


func grab_holdable(holdable_to_grab: Holdable) -> void:
	add_child(holdable_to_grab)
	holdable = holdable_to_grab
