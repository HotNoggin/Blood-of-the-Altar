class_name EnemySpawner2D
extends Marker2D

@export var scene: PackedScene
@export var initial_time: float = 5
@export var wait_time: float = 20


func _ready():
	get_tree().create_timer(initial_time).timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	var instance: Enemy = scene.instantiate() as Enemy
	add_sibling(instance)
	instance.global_position = global_position
	get_tree().create_timer(wait_time).timeout.connect(_on_timer_timeout)
