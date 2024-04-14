extends CanvasLayer

@export var arena_scene: PackedScene
@export var animator: AnimationPlayer

var scene: PackedScene
var path: StringName


func reload_arena(is_dead: bool = false) -> void:
	scene = null
	path = ""
	animator.play("fade_in_dead") if is_dead else animator.play("fade_in")
	animator.animation_finished.connect(_on_fade_in)


func switch_to_packed(p_scene: PackedScene) -> void:
	scene = p_scene
	path = ""
	animator.play("fade_in")
	animator.animation_finished.connect(_on_fade_in)


func switch_to_file(p_path: String) -> void:
	path = p_path
	scene = null
	animator.play("fade_in")
	animator.animation_finished.connect(_on_fade_in)


func _on_fade_in(_anim_name: String) -> void:
	if scene and scene.can_instantiate():
			get_tree().change_scene_to_packed(scene)
	elif not path.is_empty():
		get_tree().change_scene_to_file(path)
	else:
		get_tree().reload_current_scene()
	animator.animation_finished.disconnect(_on_fade_in)
	animator.play("fade_out")
