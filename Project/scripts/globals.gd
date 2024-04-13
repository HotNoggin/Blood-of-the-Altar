extends Node
 
signal shake_screen(intensity: float, distance: float, duration: float)


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func timestop(time_scale: float, duration: float) -> void:
	if time_scale == 0 or duration == 0:
		push_error("Timestop only accepts non-zero values.")
	Engine.time_scale = time_scale
	get_tree().create_timer(duration * time_scale).timeout.connect(reset_time_scale)


func reset_time_scale():
	Engine.time_scale = 1


func shake(intensity: float , distance: float, duration: float):
	shake_screen.emit(intensity, distance, duration)
