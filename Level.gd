# Level
extends Node2D

export(String, FILE, "*.tscn") var next_level

const GameOver = preload("res://GameOver.tscn")
onready var hud = get_node("hud")
onready var space = get_node("Space")

func _ready():
	PlayerInfo.connect("score_changed", self, "update_score")
	update_score(PlayerInfo.score)

func _on_end_enter(body):
	body.emit_signal("end_of_level")

func _on_change_level():
	var scene = next_level
	if not scene:
		# duh, can we just read main_scene?
		scene = "res://Menu.tscn"
	SceneTransition.change_scene(scene)

func _on_game_over():
	hud.add_child(GameOver.instance())
	space.stop()

func update_score(score):
	hud.get_node("score").set_text(str(score))
