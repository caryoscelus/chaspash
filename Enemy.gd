# base enemy

extends RigidBody2D

signal left_space_area
signal enter_space_area
signal killed

export var kill_score = 10
export var miss_score = 0

const team = "enemy"

onready var sound = get_node("sound")
onready var stream = get_node("stream")
onready var dying_timer = get_node("dying_timer")

func _ready():
	connect("killed", PlayerInfo, "killed_enemy", [self])
	connect("left_space_area", PlayerInfo, "missed_enemy", [self])

func _on_body_enter(body):
	emit_signal("killed")
	die()

func _on_left_space_area():
	die()

func die():
	for node in get_children():
		if not node in get_tree().get_nodes_in_group("corpse"):
			node.queue_free()
	dying_timer.start()

func _on_enter_space_area():
	set_mode(MODE_RIGID)

func play_explosion():
	sound.play("explosion-0000")
