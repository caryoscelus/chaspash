# base enemy

extends RigidBody2D

signal left_space_area
signal enter_space_area

func _on_body_enter(body):
	queue_free()

func _on_left_space_area():
	queue_free()

func _on_enter_space_area():
	set_mode(MODE_RIGID)
