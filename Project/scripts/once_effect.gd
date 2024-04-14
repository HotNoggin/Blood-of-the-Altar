class_name OnceEffect
extends GPUParticles2D
## Frees itself when it finishes playing

func _ready():
	emitting = false
	one_shot = true
	finished.connect(queue_free)


func play() -> void:
	emitting = true


func duplicate_and_play() -> OnceEffect:
	var new_effect: OnceEffect = duplicate() as OnceEffect
	add_sibling(new_effect)
	new_effect.play()
	return new_effect
