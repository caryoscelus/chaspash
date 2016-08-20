# main menu
extends Container

export(String, FILE, "*.tscn") var first_level
onready var player = get_node("/root/PlayerInfo")
onready var score = get_node("score")

func _ready():
	player.connect("max_score_changed", self, "update_max_score")
	update_max_score(player.max_score)

func update_max_score(max_score):
	score.text = str(max_score)

func _on_start_pressed():
	get_tree().change_scene(first_level)
