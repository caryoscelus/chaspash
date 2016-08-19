# Space

extends Area2D

func _on_body_exit(body):
	body.emit_signal("left_space_area")
