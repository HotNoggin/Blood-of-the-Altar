class_name OnceSound
extends AudioStreamPlayer
## Frees itself when it finishes playing

func _ready():
	stop()
	finished.connect(queue_free)


static func new_sibling(node: Node, sound: AudioStream) -> OnceSound:
	var once_sound: OnceSound = OnceSound.new()
	node.add_sibling(once_sound)
	once_sound.stream = sound
	return once_sound
