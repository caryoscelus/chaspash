# main menu
extends Container

export(String, FILE, "*.tscn") var first_level
onready var score_label = get_node("score/label")

func _ready():
	get_node("start").grab_focus()
	PlayerInfo.connect("max_score_changed", self, "update_max_score")
	update_max_score(PlayerInfo.max_score)
	PlayerInfo.restart()

func update_max_score(max_score):
	score_label.text = str(max_score)

func _on_start_pressed():
	SceneTransition.change_scene(first_level)

func _on_exit_pressed():
	get_tree().quit()
