class_name EnemySpawner2D
extends Marker2D

@export var scene: PackedScene
@export var initial_time: float = 5
@export var wait_time: float = 20

var time_elapsed: float = 0

func _ready():
	# Set the time elapsed so that it starts with initial_time left until reaching wait_time
	time_elapsed = wait_time - initial_time


func _process(delta):
	time_elapsed += delta
	if time_elapsed > wait_time:
		_on_timer_timeout()


func _on_timer_timeout():
	# Reset the timer and spawn an enemy
	time_elapsed = 0
	var instance: Enemy = scene.instantiate() as Enemy
	add_sibling(instance)
	instance.global_position = global_position
	instance._spawn_in()
