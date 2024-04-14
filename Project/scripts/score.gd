extends CanvasLayer

@export var score_label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreTimer.update_best()
	score_label.text = "You survived for: " +\
	str(ScoreTimer.time_as_string(int(ScoreTimer.time_this_round))) + "\n" +\
	"Your best: " + str(ScoreTimer.time_as_string(int(ScoreTimer.best_time)))


func _process(_delta):
	if Input.is_action_just_pressed("act"):
		get_tree().paused = true
		Transition.switch_to_packed(Transition.arena_scene)
