extends Camera2D

var shaking: bool = false
var intensity: float = 0
var distance: float = 0
var duration: float = 0

var tween: Tween
var time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.shake_screen.connect(shake_screen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Don't process if there's no shaking happening
	if not shaking:
		return
	
	time += delta
	
	# Don't interrupt the current tween
	if tween != null and tween.is_valid():
		return
	
	# If the time is over, reset
	if time >= duration:
		shaking = false
		create_tween().tween_property(self, "offset", Vector2.ZERO, (1 / intensity) / 2)
		intensity = 0
		distance = 0
		duration = 0
		return
	
	# Make a new tween to a new target position
	tween = create_tween()
	var random_rotation: float = randi_range(1, 360)
	var target_direction: Vector2 = Vector2.from_angle(deg_to_rad(random_rotation))
	var target_position: Vector2 = target_direction * distance
	tween.tween_property(self, "offset", target_position, 1 / intensity)


func shake_screen(p_intensity: float , p_distance: float, p_duration: float):
	intensity = p_intensity
	distance = p_distance
	duration = p_duration
	if is_instance_valid(tween):
		tween.kill()
	shaking = true
	time = 0
