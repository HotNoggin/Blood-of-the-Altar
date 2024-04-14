class_name Interactor
extends Area2D

var selected_holdable: Holdable
var altar: Altar


func _ready():
	area_entered.connect(func(area: Area2D):
		if area is Holdable:
			selected_holdable = area
		if area is Altar:
			altar = area
	)
	area_exited.connect(func(area: Area2D):
		if area == selected_holdable:
			selected_holdable = null
		if area == altar:
			altar = null
	)


func is_selected() -> bool:
	return is_instance_valid(selected_holdable)


func is_altar_selected() -> bool:
	return is_instance_valid(altar)
