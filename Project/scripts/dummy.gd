extends Enemy

@export var spawn_range: float = 64


func _enemy_ready():
	position.x += randf_range(-spawn_range, spawn_range)


func die(to_drop_loot: bool = true):
	if not Tutorial.has_kicked:
		Player.instance.kicked_enemy_first.emit()
		Tutorial.has_kicked = true
	super.die(to_drop_loot)
