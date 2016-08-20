# Level
extends Node2D

signal change_level

export(String, FILE, "*.tscn") var next_level

func _on_end_enter(body):
	body.emit_signal("end_of_level")

func _on_change_level():
	if next_level:
		get_tree().change_scene(next_level)
