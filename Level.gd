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
	if next_level:
		SceneTransition.change_scene(next_level)
	else:
		_back_to_menu()

func _back_to_menu():
	# duh, can we just read main_scene?
	PlayerInfo.finish()
	SceneTransition.change_scene("res://Menu.tscn")

func _on_game_over():
	var game_over = GameOver.instance()
	hud.add_child(game_over)
	game_over.get_node("button").grab_focus()
	game_over.connect("dismiss", self, "_back_to_menu")
	space.stop()

func update_score(score):
	hud.get_node("score").set_text(str(score))
