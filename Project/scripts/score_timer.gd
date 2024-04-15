class_name ScoreTimer
extends RefCounted

static var best_time: float = 0.0
static var time_this_round: float = 0.0


static func reset_time_this_round() -> void:
	time_this_round = 0


static func update_best() -> float:
	if time_this_round > best_time:
		best_time = time_this_round
	return best_time


static func time_as_string(time_in_sec: float) -> String:
	var seconds: float = fmod(time_in_sec, 60)
	var minutes: float = fmod((time_in_sec/ 60), 60)
	var hours: float = (time_in_sec/ 60)/ 60
	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
