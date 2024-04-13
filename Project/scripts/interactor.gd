class_name Interactor
extends Area2D

var selected_holdable: Holdable


func _ready():
	area_entered.connect(func(area: Area2D):
		if area is Holdable:
			selected_holdable = area
	)
	area_exited.connect(func(area: Area2D):
		if area == selected_holdable:
			selected_holdable = null)


func is_selected() -> bool:
	return is_instance_valid(selected_holdable)
