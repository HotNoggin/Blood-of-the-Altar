extends Hitbox

@export var effect: OnceEffect
@export var sound: AudioStream
@export var bounce_sound: AudioStream
@export var time_to_live: float = 4
@export var fall_gravity: float = 15
@export var floor_height: float = 32
@export var item_offset: float = 16
@export var bounce_multiple: float = 0.8
@export var spawn_y: float = -160
@export var spawn_x_range: float = 160

var velocity: float
var time_alive: float = 0


func _hitbox_ready():
	position.y = spawn_y
	position.x = randf_range(-spawn_x_range, spawn_x_range)


func _physics_process(delta):
	time_alive += delta
	if time_alive > time_to_live:
		effect.duplicate_and_play().reparent(get_parent())
		OnceSound.new_sibling(self, sound).play()
		queue_free()
		return
	
	fall_and_bounce(delta)


func fall_and_bounce(delta: float) -> void:
	# Fall
	velocity += fall_gravity * delta
	position.y += velocity
	# Bounce
	if position.y >= floor_height - item_offset:
		OnceSound.new_sibling(self, bounce_sound).play()
		velocity = velocity * (- bounce_multiple)
		position.y = floor_height - item_offset
