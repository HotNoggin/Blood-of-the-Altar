class_name AmbientSoundPlayer
extends Node

@export var minimum_time: float
@export var maximum_time: float
@export var sounds: Array[AudioStream]

var time_left: float = 0


func _ready():
	time_left = randf_range(minimum_time, maximum_time)


func _process(delta):
	time_left -= delta
	if time_left <= 0:
		OnceSound.new_sibling(self, sounds.pick_random()).play()
