class_name Holdable
extends Area2D


## Called when the holdable is picked up
func grab() -> void:
	pass


## Called when the hodable is dropped
func drop() -> void:
	pass


func is_held() -> bool:
	return get_parent() is AnchorPoint
