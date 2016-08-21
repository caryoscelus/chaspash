# base enemy

extends RigidBody2D

signal left_space_area
signal enter_space_area
signal killed

export var kill_score = 10
export var miss_score = 0

const team = "enemy"

func _ready():
	connect("killed", PlayerInfo, "killed_enemy", [self])
	connect("left_space_area", PlayerInfo, "missed_enemy", [self])

func _on_body_enter(body):
	emit_signal("killed")
	queue_free()

func _on_left_space_area():
	queue_free()

func _on_enter_space_area():
	set_mode(MODE_RIGID)
