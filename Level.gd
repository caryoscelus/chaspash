# Level
extends Node2D

export(String, FILE, "*.tscn") var next_level

const GameOver = preload("res://GameOver.tscn")
onready var hud = get_node("hud")

func _on_end_enter(body):
	body.emit_signal("end_of_level")

func _on_change_level():
	if next_level:
		get_tree().change_scene(next_level)

func _on_game_over():
	hud.add_child(GameOver.instance())
