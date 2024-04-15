class_name Tutorial
extends Node

static var has_moved: bool = false
static var has_kicked: bool = false
static var has_grabbed: bool = false
static var has_sacrificed: bool = false

@export var label: Label
@export var spawners: Node2D
@export var time_per_letter: float = 0.06
@export var title: Sprite2D
@export var graphic: Sprite2D
@export var controller_image: Texture2D
@export var keyboard_image: Texture2D
@export var player: Player
@export var player_scene: PackedScene

var tween: Tween

signal step_complete


func _ready():
	do_tutorial.call_deferred()


func _process(_delta):
	if is_instance_valid(graphic):
		graphic.texture = \
		controller_image if Input.get_connected_joypads().size() > 0 else keyboard_image
		


func do_tutorial():
	# Fade out title, hide text, deactivate player
	graphic.modulate = Color.TRANSPARENT
	
	label.text = ""
	await get_tree().create_timer(2).timeout
	get_tree().create_tween().tween_property(graphic, "modulate", Color.WHITE, 0.4)
	await get_tree().create_tween().tween_property(
		title, "modulate", Color.TRANSPARENT, 1.2).finished
		
	# Activate player
	Altar.instance.summon(player_scene)
	
	# Skip tutorial
	if has_sacrificed:
		spawners.process_mode = Node.PROCESS_MODE_INHERIT
		speak("Defend me... with your life.")
		await get_tree().create_timer(4).timeout
		label.text = ""
		create_tween().tween_property(graphic, "modulate", Color.TRANSPARENT, 0.4)
		return
	else:
		has_moved = false
		has_kicked = false
		has_grabbed = false
		has_sacrificed = false

	
	# Pause spawners
	spawners.process_mode = Node.PROCESS_MODE_DISABLED
	# Teach move
	speak("The altar hungers. Find a sacrifice.")
	await Player.instance.moved_first
	# Teach kick
	speak("Kick the enemy to knock its bone out.")
	await Player.instance.kicked_enemy_first
	# Teach grab
	speak("Grab the bone and bring it to the altar.")
	await Player.instance.grabbed_bone_first
	# Teach summon
	speak("Bring it to me... summon my assistance.")
	await Player.instance.sacrificed_first
	# Unpause spawners
	spawners.process_mode = Node.PROCESS_MODE_INHERIT
	speak("Defend me... with your life.")
	await get_tree().create_timer(4).timeout
	label.text = ""
	get_tree().create_tween().tween_property(graphic, "modulate", Color.TRANSPARENT, 0.4)
	queue_free()


func speak(text: String) -> void:
	var total_time: float = text.length() * time_per_letter
	label.visible_ratio = 0
	label.text = text
	if tween: tween.kill();
	tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1, total_time)
