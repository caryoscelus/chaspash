# Level
extends Node2D

export(String, FILE, "*.tscn") var next_level

func _on_end_enter(body):
	body.emit_signal("end_of_level")
