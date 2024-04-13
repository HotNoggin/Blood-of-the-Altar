class_name OnceEffect
extends GPUParticles2D
## Frees itself when it finishes playing

func _ready():
	emitting = false
	one_shot = true
	finished.connect(queue_free)


func play():
	emitting = true
