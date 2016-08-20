# base enemy

extends RigidBody2D

signal left_space_area
signal enter_space_area
signal killed

onready var player = get_tree().get_root().get_node("PlayerInfo")

func _ready():
	connect("killed", player, "killed_enemy", [self])

func _on_body_enter(body):
	emit_signal("killed")
	queue_free()

func _on_left_space_area():
	queue_free()

func _on_enter_space_area():
	set_mode(MODE_RIGID)
