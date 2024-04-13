class_name AnchorPoint
extends Marker2D

var holdable: Holdable: ## CRITICAL ONLY SET USING grab_holdable() !!!
	set(value):
		if is_instance_valid(holdable):
			holdable.drop()
		if is_instance_valid(value):
			value.grab()
		holdable = value
@export var root_node: Node


## Make the holdable a child and remember it
func grab_holdable(holdable_to_grab: Holdable) -> void:
	if is_instance_valid(holdable_to_grab):
		holdable_to_grab.reparent(self)
		holdable_to_grab.position = Vector2.ZERO
		holdable_to_grab.global_scale = global_scale
		holdable = holdable_to_grab


## Make the holdable a sibling of the root node and forget it
func drop_held_holdable() -> void:
	if is_holding():
		holdable.reparent(root_node.get_parent())
		holdable.rotation = Vector2.RIGHT.angle()
		holdable.scale = Vector2.ONE
		holdable = null


func is_holding() -> bool:
	return is_instance_valid(holdable)
