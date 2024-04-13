extends Node2D

@export var main_scene: PackedScene = preload("res://scenes/arena.tscn")
@export var process_materials: Array[ParticleProcessMaterial]

var frames_active: int = 0
var loading_done: bool = false

func _process(_delta):
	if loading_done:
		return
	
	# Transition if we're done
	if frames_active > process_materials.size() + 2:
		get_tree().change_scene_to_packed(main_scene)
		loading_done = true
		return
	
	# Add the particles to the scene to load and cache the process material
	if frames_active < process_materials.size():
		var particle: GPUParticles2D = GPUParticles2D.new()
		particle.process_material = process_materials[frames_active]
		add_child(particle)
		particle.emitting = true
	
	frames_active += 1

